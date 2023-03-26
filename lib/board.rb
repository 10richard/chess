class Board

    attr_accessor :board

    def initialize
        @board = generate_board
    end

    def generate_board
        board = {}
        for letter in 'a'..'h' do
            board[letter] = {}
            for num in '1'..'8' do
                board[letter][num] = set_initial_pos(letter, num.to_i)
            end
        end
        board
    end

    def set_initial_pos(letter, num)
        return 'pawn' if num == 2 || num == 7
        return 'empty' if num > 2 && num < 7

        case letter
        when 'a'
            return 'rook'
        when 'b'
            return 'knight'
        when 'c'
            return 'bishop'
        when 'd'
            return 'queen'
        when 'e'
            return 'king'
        when 'f'
            return 'bishop'
        when 'g'
            return 'knight'
        when 'h'
            return 'rook'
        end
    end
end