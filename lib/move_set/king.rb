require_relative './piece.rb'

class King < Piece

    def find_valid_moves
        #king can move in any direction, but only 1 square at a time
        #check if king will be in_check if the king moves there
        #check if king can castle - MAYBE DO THIS
        transformations = [[-1,-1],[-1,1],[1,-1],[1,1],[0,1],[1,0],[-1,0],[0,-1]].freeze

        transformations.each do |t|
            letter = @initial_pos[0]
            num = @initial_pos[1].to_i
            letter = (letter.ord + t[0]).chr
            num = (num + t[1]).to_s
            new_pos = letter + num
            @valid_moves.push(new_pos) if on_board?(new_pos) && position_capturable?(new_pos) && !threats?(new_pos)
        end
        @valid_moves
    end

    def threats?(pos)
        #will check for all diagonals and horizontals
        check_bishop_queen(pos) || check_rook_queen(pos) || check_pawn(pos) || check_knight(pos)
    end

    def threat_positions?(pos)
        threats?(pos)
        return @threat_positions
    end

    def check_bishop_queen(pos) #check diagonals + queen
        opp_bishop = white? ? @@black_pieces[2] : @@white_pieces[2]
        opp_queen = white? ? @@black_pieces[4] : @@white_pieces[4]
        set = white? ? @@white_pieces : @@black_pieces

        letter = pos[0]
        num = pos[1]

        #diagonal one
        loop do
            letter = (letter.ord - 1).chr
            num = (num.to_i - 1).to_s
            #fix the break on loop
            break unless on_board?(letter + num)
            break if set.include?(@board.board[letter][num])
            if @board.board[letter][num] == opp_bishop || @board.board[letter][num] == opp_queen
                @threat_positions.push(letter + num) 
                return true
            end
        end

        letter = pos[0]
        num = pos[1]

        loop do
            letter = (letter.ord + 1).chr
            num = (num.to_i + 1).to_s
            break unless on_board?(letter + num)
            break if set.include?(@board.board[letter][num])
            if @board.board[letter][num] == opp_bishop || @board.board[letter][num] == opp_queen
                @threat_positions.push(letter + num) 
                return true
            end
        end

        letter = pos[0]
        num = pos[1]

        #diagonal two
        loop do
            letter = (letter.ord + 1).chr
            num = (num.to_i - 1).to_s
            break unless on_board?(letter + num)
            break if set.include?(@board.board[letter][num])
            if @board.board[letter][num] == opp_bishop || @board.board[letter][num] == opp_queen
                @threat_positions.push(letter + num) 
                return true
            end
        end

        letter = pos[0]
        num = pos[1]

        loop do
            letter = (letter.ord - 1).chr
            num = (num.to_i + 1).to_s
            break unless on_board?(letter + num)
            break if set.include?(@board.board[letter][num])
            if @board.board[letter][num] == opp_bishop || @board.board[letter][num] == opp_queen
                @threat_positions.push(letter + num)
                return true
            end
        end
        false
    end

    def check_rook_queen(pos) #vertical and horizontal + queen
        opp_rook = white? ? @@black_pieces[3] : @@white_pieces[3]
        opp_queen = white? ? @@black_pieces[4] : @@white_pieces[4]
        set = white? ? @@white_pieces : @@black_pieces

        letter = pos[0]
        num = pos[1]
        count = 1

        #checks horizontal
        loop do
            letter = (letter.ord - 1).chr
            break unless @letters.include?(letter)
            break if set.include?(@board.board[letter][num])
            if @board.board[letter][num] == opp_rook || @board.board[letter][num] == opp_queen
                @threat_positions.push(letter + num)
                return true
            end
        end

        letter = pos[0]

        loop do
            letter = (letter.ord + 1).chr
            break unless @letters.include?(letter)
            break if set.include?(@board.board[letter][num])
            if @board.board[letter][num] == opp_rook || @board.board[letter][num] == opp_queen
                @threat_positions.push(letter + num)
                return true
            end
        end

        letter = pos[0]

        #checks vertical
        loop do
            num = (num.to_i - 1).to_s
            break unless @nums.include?(letter)
            break if set.include?(@board.board[letter][num])
            if @board.board[letter][num] == opp_rook || @board.board[letter][num] == opp_queen
                @threat_positions.push(letter + num)
                return true
            end
        end

        num = pos[1]

        loop do
            num = (num.to_i + count).to_s
            break unless @nums.include?(num)
            break if set.include?(@board.board[letter][num])
            if @board.board[letter][num] == opp_rook || @board.board[letter][num] == opp_queen
                @threat_positions.push(letter + num)
                return true
            end
        end
        false
    end

    def check_pawn(pos) #check diagonal
        transformations = white? ? [[-1, 1], [1, 1]] : [[1, -1], [-1, -1]]
        opp_pawn = white? ? @@black_pieces[0] : @@white_pieces[0]

        transformations.each do |t|
            letter = pos[0]
            num = pos[1].to_i
            letter = (letter.ord + t[0]).chr
            num = (num + t[1]).to_s
            new_pos = letter + num
            if on_board?(new_pos) && @board.board[letter][num] == opp_pawn
                @threat_positions.push(letter + num)
                return true
            end
        end
        false
    end

    def check_knight(pos)
        transformations = [[-2, -1], [-1, -2], [-2, 1], [-1, 2], 
        [1, 2], [2, 1], [2, -1], [1, -2]].freeze
        opp_knight = white? ? @@black_pieces[1] : @@white_pieces[1]

        transformations.each do |t|
            letter = pos[0]
            num = pos[1].to_i
            letter = (letter.ord + t[0]).chr
            num = (num + t[1]).to_s
            new_pos = letter + num
            if on_board?(new_pos) && @board.board[letter][num] == opp_knight
                @threat_positions.push(letter + num)
                return true
            end
        end
        false
    end

    def position_capturable?(pos)
        capturable = white? ? @@black_pieces : @@white_pieces
        return true if @board.board[pos[0]][pos[1]] == '-' || capturable.include?(@board.board[pos[0]][pos[1]])
        false
    end
end