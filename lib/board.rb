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
        
        return '-' if num == 2 || num == 7
        #return set_piece_color('pawn', color) if num == 2 || num == 7
        return '-' if num > 2 && num < 7
        #replace names of pieces with images/emojis
        case letter
        when 'a', 'h'
            return set_piece_color('rook', color)
        when 'b', 'g'
            return '-'
            #return set_piece_color('knight', color)
        when 'c', 'f'
            return '-'
            #return set_piece_color('bishop', color)
        when 'd'
            return '-'
            #return set_piece_color('queen', color)
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

    def get_piece_position(piece)
        #will be used to check if king is in check/checkmate
        for letter in 'a'..'h' do
            for num in '1'..'8' do
                return letter + num if @board[letter][num] == piece
            end
        end
    end

    def get_piece_color(pos)
        #gets color of selected piece
        piece = @board[pos[0]][pos[1]]
        @@white_pieces.include?(piece) ? 'white' : 'black'
    end

    def check_threats(pos, color, board)
        King.new(board, pos, color).threats?(pos)
    end

    def get_piece_off_count(count, set)
        piece_count = 1
        for letter in 'a'..'h' do
            for num in '1'..'8' do
                if set.include?(@board[letter][num])
                    return letter + num if piece_count == count
                    piece_count += 1
                end
            end
        end
        nil
    end

    def unable_to_protect?(king, k_pos, color, board)
        #check if any valid_moves of same set is able to move in between threat and king
        #also check if any piece in the set can capture the threat without putting king in check
        set = color == 'white' ? @@black_pieces : @@white_pieces
        threat_positions = get_threats(k_pos, color, board)
        threat_moves = []
        #mock_board will be used to check if the king wll have threats after piece is moved
        #possibility
        for t_pos in threat_positions do
            t_piece = get_piece(t_pos)
            t_color = get_piece_color(t_pos)
            threat_moves.concat(valid_moves?(t_pos, t_piece, t_color, board))
        end

        count = 1
        while true
            piece_pos = get_piece_off_count(count, set)
            return true if piece_pos == nil
            piece = get_piece(piece_pos)
            piece_moves = valid_moves?(piece_pos, piece, color, board)
            move = cross_check_moves(threat_positions, t_moves, piece_moves)
            board.modify_board(piece_pos, move)
            if !King.new(board, k_pos, color).find_valid_moves.empty?
                board.modify_board(move, piece_pos)
                return false
            end
            board.modify_board(move, piece_pos)
            count += 1
        end
    end

    def cross_check_moves(t_positions, t_moves, p_moves)
        #see if any of the possible moves matchup (between same set vs opp set)
        #or if same set can capture a pos of threat
        return p_moves.select{|pos| t_positions.include?(pos)}[0] if p_moves.intersect?(t_positions)
        return p_moves.select{|pos| t_moves.include?(pos)}[0] if p_moves.intersect?(t_moves)
    end

    def get_threats(pos, color, board)
        #get threats of king
        King.new(board, pos, color).threat_positions?(pos)
    end

    def stalemate?(pos, color, board)
        piece = color == 'white' ? @@white_pieces[5] : @@black_pieces[5]

        return true if valid_moves?(pos, piece, color, board).empty? && !check_threats(pos, color, board) && only_king?(piece)
        false
    end

    def only_king?(king)
        set = king == '♚' ? @@white_pieces : @@black_pieces
        for letter in 'a'..'h' do
            for num in '1'..'8' do
                piece = @board[letter][num]
                return false if set.include?(piece) && piece != king
            end
        end
        true
    end

    def valid_moves?(pos, piece, color, board)
        #will create an instance for the piece w/initial position, board and color
        case piece
        when '♟︎', '♙'
            return Pawn.new(board, pos, color).find_valid_moves
        when '♞', '♘'
            return Knight.new(board, pos, color).find_valid_moves
        when '♝', '♗'
            return Bishop.new(board, pos, color).find_valid_moves
        when '♜', '♖'
            return Rook.new(board, pos, color).find_valid_moves
        when '♛', '♕'
            return Queen.new(board, pos, color).find_valid_moves
        when '♚', '♔'
            return King.new(board, pos, color).find_valid_moves
        end
    end
end