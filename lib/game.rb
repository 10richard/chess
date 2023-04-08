require_relative './display.rb'
require_relative './board.rb'
require_relative './move_set/piece.rb'

class Game < Board

    include Display

    attr_accessor :board
    attr_reader :current

    def initialize
        @board = Board.new()
        #interchange current with 'white' and 'black'
        @current = 'white'
        @game_over = nil
        @piece_selected = ''
        #if king is in check, call another method (other than select_old_pos)
        #ie/ move_king
    end

    def play
        until @game_over
            display_turn(@current)
            display_board(@board.board, @current)
            initial_pos = select_initial_pos
            new_pos = select_new_pos
            board.modify_board(initial_pos, new_pos)
            @current == 'white' ? @current = 'black' : @current = 'white'
            @game_over = 'yes'
        end
    end

    def select_initial_pos
        puts get_player_move('initial_pos')
        initial_pos = gets.chomp
        valid_old_pos?(initial_pos.split(''))
    end

    def valid_old_pos?(split_pos)
        #check if initial position is on the board

        #check if split_pos corresponds to the current player (ie/ current = white and selected a white piece)
        #if old_pos does not match current_player's color, then callback select_old_pos
        if !position_on_board?(split_pos)
            puts selection_error('invalid_pos')
            select_initial_pos
        elsif board.get_piece(split_pos) == ' '
            puts selection_error('empty_pos')
            select_initial_pos
        elsif board.get_piece_color(split_pos) != @current
            puts selection_error('invalid_color', @current)
            select_initial_pos
        end
        puts confirm_move('initial_pos', board.get_piece(split_pos), split_pos.join(''))
    end

    def select_new_pos
        puts get_player_move('new_pos')
        new_pos = gets.chomp
        valid_new_pos?(new_pos)
    end

    def valid_new_pos?
        #check if new_pos is in valid_moves of the piece (Piece class)
        #check if piece is able to move into selected position (if new position is empty or opposing color is on it)
        
        #if unable to/there are pieces in the way, then throw an error and call select_new_pos again
        #else return new_pos
    end

    def king_in_check?
        #checks if king is in check/checkmate
        #if king is in check, then set @check var to true - next turn will only be able to move the king
        #if checkmate then set @game_over var to 'checkmate_current' (will split and display outcome in another method)
    end

    def game_over?
        #if current king cannot move then other player wins
        #if there are only kings left, then set @gameover to 'draw'
    end

    def position_on_board?(pos)
        #checks if position selected is out of bounds
        pos[0].between?('a', 'h') && pos[1].to_i.between?(1, 8) && pos.count == 2
    end
end