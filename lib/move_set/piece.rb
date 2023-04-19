class Piece 

    attr_reader :valid_moves

    @@white_pieces = ['♟︎', '♞', '♝', '♜', '♛', '♚']
    @@black_pieces = ['♙', '♘', '♗', '♖', '♕', '♔']

    def initialize(board, initial_pos, color)
        @board = board
        @initial_position = initial_pos #will be split (ie. ['a', '1'])
        @current = color
        @letters = ('a'..'h').to_a
        @nums = ('1'..'8').to_a
        @valid_moves = []
    end

    def white?
        @current == 'white'
    end

    def on_board?(pos)
        #check if position is on the board (pos = letter + num; ie. 'a1')
        @letters.include?(pos[0]) && @nums.include?(pos[1])
    end
end