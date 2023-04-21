require_relative './piece.rb'

class Knight < Piece

    def find_valid_moves
        flower_pattern
        @valid_moves
    end

    def flower_pattern
        transformations = [[-2, -1], [-1, -2], [-2, 1], [-1, 2], 
        [1, 2], [2, 1], [2, -1], [1, -2]].freeze

        transformations.each do |t|
            letter = @initial_pos[0]
            num = @initial_pos[1].to_i
            letter = (letter.ord + t[0]).chr
            num = (num + t[1]).to_s
            @valid_moves.push(letter + num.to_s) if on_board?(letter + num) && position_capturable?(letter + num)
        end
    end

    def position_capturable?(pos)
        capturable = white? ? @@black_pieces : @@white_pieces
        return true if @board.board[pos[0]][pos[1]] == '-' || capturable.include?(@board.board[pos[0]][pos[1]])
        false
    end
end