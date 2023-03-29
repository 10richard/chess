require_relative './colors.rb'

class Board

    attr_accessor :board

    def initialize
        @board = generate_board
    end

    def generate_board
        board = {}
        #iterate through letters a to h
        for letter in 'a'..'h' do
            #set letter's value to another hash
            board[letter] = {}
            #iterate through numbers 1 to 8
            for num in '1'..'8' do
                #inside of the letter's hash, set number as key, and piece as value
                board[letter][num] = set_initial_pos(letter, num.to_i)
            end
        end
        board
    end

    def set_initial_pos(letter, num)
        num == 1 || num == 2 ? color = '_white' : color = '_black'

        return 'pawn' + color if num == 2 || num == 7
        return 'empty' + color if num > 2 && num < 7

        case letter
        when 'a'
            return 'rook' + color
        when 'b'
            return 'knight' + color
        when 'c'
            return 'bishop' + color
        when 'd'
            return 'queen' + color
        when 'e'
            return 'king' + color
        when 'f'
            return 'bishop' + color
        when 'g'
            return 'knight' + color
        when 'h'
            return 'rook' + color
        end
    end

    def modify_board(old_pos, new_pos)
        #set old position to empty and new position to the piece
        
    end
end