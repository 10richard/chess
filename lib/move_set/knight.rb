class Knight < Piece

    def initialize
        @@transformations = [[-2, -1], [-1, -2], [-2, 1], [-1, 2], 
        [1, 2], [2, 1], [2, -1], [1, -2]].freeze
    end

    def find_valid_moves
        flower_pattern
    end

    def flower_pattern
        @@transformations.each do |t|
            letter = @initial_pos[0]
            num = @initial_pos[1].to_i
            letter = (letter.ord + t[0]).chr
            num = (num + t[1]).to_s
            @valid_moves.push(letter + num.to_s) if on_board?(letter) && on_board?(num)
        end
    end

    def on_board?(part)
        @nums.include?(part) || @letters.include?(part)
    end
end