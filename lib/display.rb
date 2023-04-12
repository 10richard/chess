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

        #sets the numbers and letters on the sides of the chess board (coordinates)
        board_nums = set_board_nums(current)
        board_letters = set_board_letters(current)
    
        for num in 0..7 do
            puts "#{board_nums[num]} #{pieces.map {|row| row[num]}.join(' ')}"
            puts '  ' +  board_letters.join(' ') if num == 7
        end
    end

    def set_board_nums(color)
        nums = (1..8).to_a
        color == 'white' ? nums.reverse : nums
    end

    def set_board_letters(color)
        letters = ('a'..'h').to_a
        color == 'white' ? letters : letters.reverse
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