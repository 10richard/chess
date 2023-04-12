class Piece 

    attr_accessor :position

    def initialize(board, initial_pos, color)
        @board = board
        @initial_position = initial_pos
        @current = color
        @valid_moves = []
        @valid_captures = []
    end

    def white?
        @current == 'white'
    end
end