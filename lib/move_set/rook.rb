require_relative './piece.rb'

class Rook < Piece

    def find_valid_moves
        horizontal
        vertical
        @valid_moves
    end

    def horizontal
        letter = @initial_pos[0]
        num = @initial_pos[1]
        capturable = white? ? @@black_pieces : @@white_pieces

        loop do
            #gets next letter in alphabet
            letter = (letter.ord - 1).chr
            @valid_moves.push(letter + num)

            break unless @letters.include?(letter) && @board.board[letter][num] == '-'
        end
        @valid_moves.pop unless on_board?(letter + num) && capturable.include?(@board.board[letter][num])

        letter = @initial_pos[0]

        loop do
            #gets next letter in alphabet
            letter = (letter.ord + 1).chr
            @valid_moves.push(letter + num)

            break unless @letters.include?(letter) && @board.board[letter][num] == '-'
        end
        @valid_moves.pop unless on_board?(letter + num) && capturable.include?(@board.board[letter][num])
    end

    def vertical
        letter = @initial_pos[0]
        num = @initial_pos[1]
        capturable = white? ? @@black_pieces : @@white_pieces

        loop do
            #gets next letter in alphabet
            num = num.to_i
            num -= 1
            num = num.to_s
            @valid_moves.push(letter + num)

            break unless @nums.include?(num) && @board.board[letter][num] == '-'
        end
        @valid_moves.pop unless on_board?(letter + num) && capturable.include?(@board.board[letter][num])

        num = @initial_pos[1]

        loop do
            #gets next letter in alphabet
            num = num.to_i
            num += 1
            num = num.to_s
            @valid_moves.push(letter + num)

            break unless @nums.include?(num) && @board.board[letter][num] == '-'
        end
        @valid_moves.pop unless on_board?(letter + num) && capturable.include?(@board.board[letter][num])
    end
end