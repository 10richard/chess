require_relative './piece.rb'

class Pawn < Piece

    def find_valid_moves
        letter = @initial_pos[0]
        num = @initial_pos[1]
        color = white? ? 'white' : 'black'
        if on_start_pos?(num, color)
            #change the bottom loop l8
            if color == 'white'
                for n in 1..2
                    num = num.next
                    @valid_moves.push(letter + num) if @board.board[letter][num] == '-'
                end
            else
                for n in 1..2
                    num = (num.to_i - 1).to_s
                    @valid_moves.push(letter + num) if @board.board[letter][num] == '-'
                end
            end
        elsif @board.board[letter][num.next] == '-'
            @valid_moves.push(letter + num.next)
        end
        able_to_capture?
        @valid_moves
    end

    def on_start_pos?(num, color)
        #if pawn is on start position, then let player move up to two places
        return true if color == 'white' && num == '2'
        return true if color == 'black' && num == '7'
        false
    end

    def able_to_capture?
        transformations = white? ? [[-1, 1], [1, 1]] : [[1, -1], [-1, -1]]
        #find if pawn can capture any pieces and append to valid moves if yes
        capturable = white? ? @@black_pieces : @@white_pieces
        transformations.each do |t|
            letter = @initial_pos[0]
            num = @initial_pos[1]
            letter = (letter.ord + t[0]).chr
            num = (num.ord + t[1]).chr
            puts letter + num
            @valid_moves.push(letter + num) if on_board?(letter + num) && capturable.include?(@board.board[letter][num])
        end
    end

    def able_to_transform?
        #if black pawn reach number 1 then true
        #if white pawn reach number 8 then true
        #can transform to queen, rook, bishop, or knight
    end
end