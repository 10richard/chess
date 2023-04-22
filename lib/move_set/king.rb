require_relative './piece.rb'

class King < Piece

    def find_valid_moves
        #king can move in any direction, but only 1 square at a time
        #check if king will be in_check if the king moves there
        #check if king can castle - MAYBE DO THIS
        transformations = [[-1,-1],[-1,1],[1,-1],[1,1]].freeze

        transformations.each do |t|
            letter = @initial_pos[0]
            num = @initial_pos[1].to_i
            letter = (letter.ord + t[0]).chr
            num = (num + t[1]).to_s
            new_pos = letter + num
            @valid_moves.push(new_pos) if on_board?(new_pos) && position_capturable?(new_pos) && no_threats?(new_pos)
        end
        @valid_moves
    end

    def no_threats?(pos)
        #will check for all diagonals and horizontals
        return false if check_bishop_queen(pos) || check_rook_queen(pos) || check_pawn(pos) || check_knight(pos)
        true
    end

    def check_bishop_queen(pos) #check diagonals + queen
        opp_bishop = white? ? @@black_pieces[2] : @@white_pieces[2]
        opp_queen = white? ? @@black_pieces[4] : @@white_pieces[4]

        letter = pos[0]
        num = pos[1]
        count = 1

        #diagonal one
        loop do
            letter = (letter.ord - count).chr
            num = (num.to_i - count).to_s
            break unless on_board?(letter + num) && @board.board[letter][num] == '-'
            return true if @board.board[letter][num] == opp_bishop || @board.board[letter][num] == opp_queen

            letter = pos[0]
            num = pos[1]

            letter = (letter.ord + count).chr
            num = (num.to_i + count).to_s
            break unless @letters.include?(letter) && @board.board[letter][num] == '-'
            return true if @board.board[letter][num] == opp_bishop || @board.board[letter][num] == opp_queen

            count += 1
        end

        letter = pos[0]
        num = pos[1]
        count = 1

        #diagonal two
        loop do
            letter = (letter.ord + count).chr
            num = (num.to_i - count).to_s
            break unless @letters.include?(letter) && @board.board[letter][num] == '-'
            return true if @board.board[letter][num] == opp_bishop || @board.board[letter][num] == opp_queen

            letter = pos[0]
            num = pos[1]

            letter = (letter.ord - count).chr
            num = (num.to_i + count).to_s
            break unless @letters.include?(letter) && @board.board[letter][num] == '-'
            return true if @board.board[letter][num] == opp_bishop || @board.board[letter][num] == opp_queen

            count += 1
        end
        false
    end

    def check_rook_queen(pos) #vertical and horizontal + queen
        opp_rook = white? ? @@black_pieces[3] : @@white_pieces[3]
        opp_queen = white? ? @@black_pieces[4] : @@white_pieces[4]

        letter = pos[0]
        num = pos[1]
        count = 1

        #checks horizontal
        loop do
            letter = (letter.ord - count).chr
            break unless @letters.include?(letter) && @board.board[letter][num] == '-'
            return true if @board.board[letter][num] == opp_rook || @board.board[letter][num] == opp_queen

            letter = pos[0]

            letter = (letter.ord + count).chr
            break unless @letters.include?(letter) && @board.board[letter][num] == '-'
            return true if @board.board[letter][num] == opp_rook || @board.board[letter][num] == opp_queen

            count += 1
        end

        count = 1
        letter = pos[0]

        #checks vertical
        loop do
            num = (num.to_i - count).to_s
            break unless @letters.include?(letter) && @board.board[letter][num] == '-'
            return true if @board.board[letter][num] == opp_rook || @board.board[letter][num] == opp_queen

            num = pos[1]

            num = (num.to_i + count).to_s
            break unless @letters.include?(letter) && @board.board[letter][num] == '-'
            return true if @board.board[letter][num] == opp_rook || @board.board[letter][num] == opp_queen

            count += 1
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
            return true if on_board?(new_pos) && @board.board[letter][num] == opp_pawn
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
            return true if on_board?(new_pos) && @board.board[letter][num] == opp_knight
        end
        false
    end

    def position_capturable?(pos)
        capturable = white? ? @@black_pieces : @@white_pieces
        return true if @board.board[pos[0]][pos[1]] == '-' || capturable.include?(@board.board[pos[0]][pos[1]])
        false
    end
end