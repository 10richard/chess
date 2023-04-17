class Pawn < Piece
    
    def find_valid_moves
        letter = @initial_pos[0]
        num = @initial_pos[1]
        color = white? ? 'white' : 'black'
        if on_start_pos?(num, color)
            #change the bottom loop l8
            for n in 1..2
                @valid_moves.push(letter + num.next)
            end
        elsif @board[letter][num.next] == '-'
            @valid_moves.push(letter + num.next)
        end
        able_to_capture?(color)
    end

    def on_start_pos?(num, color)
        #if pawn is on start position, then let player move up to two places
        return true if color == 'white' && num == '2'
        return true if color == 'black' && num == '7'
        false
    end

    def able_to_capture?(color)
        transformations = [[-1, -1]. [1, 1]]
        #find if pawn can capture any pieces and append to valid moves if yes
        capturable = white? ? @@black_pieces : @@white_pieces

        transformations.each do |t|
            letter = @initial_pos[0]
            num = @initial_pos[1]
            letter = (letter.ord + t[0]).chr
            num = (letter.ord + t[1]).chr
            @valid_moves.push(letter + num) if capturable.include?(@board[letter][num])
        end
    end
end