require_relative './display.rb'
require_relative './board.rb'
require_relative './move_set/piece.rb'

class Game < Board

    include Display

    attr_accessor :board
    attr_reader :current, :initial_pos

    def initialize
        @board = Board.new()
        #interchange current with 'white' and 'black'
        @current = 'white'
        @game_over = nil
        @in_check = false
        @got_selections = false
        @initial_pos = nil
        @new_pos = nil
        #if king is in check, call another method (other than select_old_pos)
        #ie/ move_king
    end

    def play
        until @game_over
            until @got_selections
                display_turn(@current)
                display_board(@board.board, @current)
                @initial_pos = select_initial_pos
                @new_pos = select_new_pos
            end
            board.modify_board(@initial_pos, @new_pos)
            @initial_pos = nil
            @new_pos = nil
            @got_selections = false
            #draw?
            @in_check = king_in_check?
            @current == 'white' ? @current = 'black' : @current = 'white'
        end
        #case @game_over.split('')
        #when 
        #end
        #check @game_over var
        #split @game_over (ie/ var will look like black_wins)
    end

    def select_initial_pos
        got_move = false
        until got_move
            puts get_player_move('initial_pos')
            initial_pos = gets.chomp.downcase
            got_move = valid_old_pos?(initial_pos.split(''))
        end
        initial_pos
    end

    def valid_old_pos?(split_pos)
        #check if initial position is on the board

        #check if split_pos corresponds to the current player (ie/ current = white and selected a white piece)
        #if old_pos does not match current_player's color, then callback select_old_pos
        if !position_on_board?(split_pos)
            puts selection_error('invalid_pos')
            return false
        elsif board.get_piece(split_pos) == '-'
            puts selection_error('empty_pos')
            return false
        elsif board.get_piece_color(split_pos) != @current
            puts selection_error('invalid_color', @current)
            return false
        end
        puts confirm_move('initial_pos', board.get_piece(split_pos), split_pos.join(''))
        true
    end

    def select_new_pos
        got_move = false
        until got_move
            puts get_player_move('new_pos', board.get_piece(@initial_pos))
            new_pos = gets.chomp.downcase
            got_move = valid_new_pos?(new_pos)
        end
        new_pos
    end

    def valid_new_pos?(new_pos)
        #check if new_pos is not off the board
        #check if new_pos is in valid_moves of the piece (Piece class)
        #check if piece is able to move into selected position (if new position is empty or opposing color is on it)

        #CHECK IF KING WILL BE IN CHECK IF THE PIECE IS MOVED
        old_pos = @initial_pos
        piece = @board.get_piece(@initial_pos)
        color = @board.get_piece_color(@initial_pos)
        possible_moves = valid_moves?(old_pos, piece, color, @board)
        
        if possible_moves.include?(new_pos)
            puts confirm_move('new_pos', piece, new_pos)
            @got_selections = true
            return true
        elsif new_pos == 'back'
            puts confirm_move('reselect')
            return true
        else
            puts selection_error('invalid_new_pos')
            return false
        end
    end

    def king_in_check?
        #checks if king is in check/checkmate
        #if opposing king has no possible moves
        #if checkmate then set @game_over var to @current
        king = @current == 'white' ? '♔' : '♚'
        position = @board.get_piece_position(king)
        color = @board.get_piece_color(position)
        #possible_moves = @board.valid_moves?(position, king, color, @board)

        #check for threats
        #if no threats then return false, otherwise continue
        return false unless @board.check_threats(position, color, @board)

        #if possible_moves.empty?
            #check if any pieces can be moved to protect king
            #if not possible then game over
            #p 'check'
            #@game_over = "#{@current}_wins" unless @board.able_to_protect?(@board.board, king)
        #end
        #true
        false
    end

    def draw?
        #if there are only kings left, then set @gameover to 'draw'
        #if king cannot move and there are no threats, then set @gameover to 'draw'
        king = @current == 'white' ? '♚' : '♔'
        return 'draw' if @board.only_king?('♚', @board.board) && @board.only_king?('♔', @board.board)
        return 'stalemate' if @board.stalemate?(pos, color, @board.board)
        nil
    end

    def position_on_board?(pos)
        #checks if position selected is out of bounds
        pos.count == 2 && pos[0].between?('a', 'h') && pos[1].to_i.between?(1, 8)
    end
end