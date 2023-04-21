require_relative './piece.rb'

class Bishop < Piece

    def find_valid_moves
        diagonal_moves_quadrant_one
        diagonal_moves_quadrant_two
        diagonal_moves_quadrant_three
        diagonal_moves_quadrant_four
        @valid_moves
    end


    #find diagonal moves based on quadrants? (1, 2, 3, 4)
    def diagonal_moves_quadrant_one
        letter = @initial_pos[0]
        num = @initial_pos[1]
        capturable = white? ? @@black_pieces : @@white_pieces
        
        loop do
            #gets previous letter in alphabet
            letter = (letter.ord - 1).chr
            num = num.to_i
            num -= 1
            num = num.to_s
            @valid_moves.push(letter + num)

            break unless on_board?(letter + num) && @board.board[letter][num] == '-'
        end
        @valid_moves.pop unless on_board?(letter + num) && capturable.include?(@board.board[letter][num])
    end

    def diagonal_moves_quadrant_two
        letter = @initial_pos[0]
        num = @initial_pos[1]
        capturable = white? ? @@black_pieces : @@white_pieces

        loop do
            #gets previous letter in alphabet
            letter = (letter.ord + 1).chr
            num = num.to_i
            num -= 1
            num = num.to_s
            @valid_moves.push(letter + num)

            break unless on_board?(letter + num) && @board.board[letter][num] == '-'
        end
        @valid_moves.pop unless on_board?(letter + num) && capturable.include?(@board.board[letter][num])
    end

    def diagonal_moves_quadrant_three
        letter = @initial_pos[0]
        num = @initial_pos[1]
        capturable = white? ? @@black_pieces : @@white_pieces

        loop do
            #gets next letter in alphabet
            letter = (letter.ord + 1).chr
            num.next!
            @valid_moves.push(letter + num)

            break unless on_board?(letter + num) && @board.board[letter][num] == '-'
        end
        @valid_moves.pop unless on_board?(letter + num) && capturable.include?(@board.board[letter][num])
    end

    #quadrant 4
    def diagonal_moves_quadrant_four
        letter = @initial_pos[0]
        num = @initial_pos[1]
        capturable = white? ? @@black_pieces : @@white_pieces

        loop do
            #gets next letter in alphabet
            letter = (letter.ord - 1).chr
            num.next!
            @valid_moves.push(letter + num)

            break unless on_board?(letter + num) && @board.board[letter][num] == '-'
        end
        @valid_moves.pop unless on_board?(letter + num) && capturable.include?(@board.board[letter][num])
    end
end