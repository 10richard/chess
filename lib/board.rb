require_relative './move_set/piece.rb'
require_relative './move_set/pawn.rb'
require_relative './move_set/bishop.rb'
require_relative './move_set/knight.rb'
require_relative './move_set/king.rb'
require_relative './move_set/rook.rb'
require_relative './move_set/queen.rb'

class Board < Piece

    attr_accessor :board

    #piece order = [pawn, knight, bishop, rook, queen, king]
    @@white_pieces = ['♟︎', '♞', '♝', '♜', '♛', '♚']
    @@black_pieces = ['♙', '♘', '♗', '♖', '♕', '♔']

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
        num == 1 || num == 2 ? color = 'white' : color = 'black'
        
        return set_piece_color('pawn', color) if num == 2 || num == 7
        return '-' if num > 2 && num < 7
        #replace names of pieces with images/emojis
        case letter
        when 'a', 'h'
            return set_piece_color('rook', color)
        when 'b', 'g'
            return set_piece_color('knight', color)
        when 'c', 'f'
            return set_piece_color('bishop', color)
        when 'd'
            return set_piece_color('queen', color)
        when 'e'
            return set_piece_color('king', color)
        end
    end

    def set_piece_color(piece, color)
        #sets color of piece when generating board

        #decides current set of pieces based on color
        color == 'white' ? set = @@white_pieces : set = @@black_pieces

        case piece
        when 'pawn'
            return set[0]
        when 'knight'
            return set[1]
        when 'bishop'
            return set[2]
        when 'rook'
            return set[3]
        when 'queen'
            return set[4]
        when 'king'
            return set[5]
        end
    end

    def modify_board(old_pos, new_pos)
        #set old position to empty and new position to the piece
        #^moves chess pieces on the board
        #account for castling with king later on
        piece = get_piece(old_pos)
        @board[old_pos[0]][old_pos[1]] = '-'
        @board[new_pos[0]][new_pos[1]] = piece
    end

    def get_piece(pos)
        @board[pos[0]][pos[1]]
    end

    def get_piece_color(pos)
        #gets color of selected piece
        piece = @board[pos[0]][pos[1]]
        @@white_pieces.include?(piece) ? 'white' : 'black'
    end

    def valid_moves?(pos, piece, color, board)
        #will create an instance for the piece w/initial position, board and color
        case piece
        when '♟︎', '♙'
            return Pawn.new(board, pos, color).find_valid_moves
        when '♞', '♘'
            return Knight.new(board, pos, color).find_valid_moves
        when '♝', '♗'
            initialize_piece = Bishop.new(@board, pos, color).find_valid_moves
        when '♜', '♖'
            initialize_piece = Rook.new(@board, pos, color).find_valid_moves
        when '♛', '♕'
            initialize_piece = Queen.new(@board, pos, color).find_valid_moves
        when '♚', '♔'
            initialize_piece = King.new(@board, pos, color).find_valid_moves
        end
    end
end