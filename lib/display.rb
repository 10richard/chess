module Display

    def display_board(board, current)
        pieces = []
        board.values.each do |values|
        current_col = Array.new()
        values.each do |value|
            current_col.append(value[1])
        end
        pieces.append(current_col)
        end
        
        #flips board if current turn is white
        pieces.each_with_index {|row, i| pieces[i] = row.reverse} if current == 'white'
    
        for num in 0..7 do
            p pieces.map{|row| row[num]}.join(' ')
        end
    end

    def get_player_move(msg, piece=nil)
        {
            'initial_pos' => "Enter the position of the piece that you want to move (ie. 'a1', 'b5', etc.)",
            'new_pos' => "Enter the position you want to move #{piece} to"
        }[msg]
    end

    def confirm_move(msg, piece=nil, pos=nil)
        {
            'initial_pos' => "Selected #{piece} at '#{pos}'\n",
            'new_pos' => "Moved #{piece} to #{pos}"
        }[msg]
    end

    def selection_error(msg, current=nil)
        {
            'invalid_color' => "Selected the wrong color, you are #{current}",
            'invalid_pos' => "The position you entered does not exist",
            'invalid_new_pos' => "",
            'empty_pos' => 'The position you entered is empty'
        }[msg]
    end

    def display_turn(current)
        p "#{current.capitalize}'s turn"
    end
end