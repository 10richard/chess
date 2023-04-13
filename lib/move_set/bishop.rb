class Bishop < Piece

    def find_valid_moves

    end


    #find diagonal moves based on quadrants? (1, 2, 3, 4)
    def diagonal_moves_quadrant_one
        letter = @initial_pos[0]
        num = @initial_pos[1]
        capturable = white? ? @@black_pieces : @@white_pieces

        while @letters.include?(letter) && @nums.include?(num) && @board[letter][num] == '-'
            #gets previous letter in alphabet
            letter = (letter.ord - 1).chr
            num = num.to_i
            num -= 1
            num = num.to_s
            @valid_moves.push(letter + num) if !@letters.include?(letter) || !@nums.include?(num)
        end
        @valid_moves.pop unless capturable.include?(@board[letter][num])
    end

    def diagonal_moves_quadrant_two
        letter = @initial_pos[0]
        num = @initial_pos[1]
        capturable = white? ? @@black_pieces : @@white_pieces

        while @letters.include?(letter) && @nums.include?(num) && @board[letter][num] == '-'
            #gets previous letter in alphabet
            letter = (letter.ord + 1).chr
            num = num.to_i
            num -= 1
            num = num.to_s
            @valid_moves.push(letter + num) if !@letters.include?(letter) || !@nums.include?(num)
        end
        @valid_moves.pop unless capturable.include?(@board[letter][num])
    end

    def diagonal_moves_quadrant_three
        letter = @initial_pos[0]
        num = @initial_pos[1]
        capturable = white? ? @@black_pieces : @@white_pieces

        while @letters.include?(letter) && @nums.include?(num) && @board[letter][num] == '-'
            #gets next letter in alphabet
            letter = (letter.ord + 1).chr
            num.next!
            @valid_moves.push(letter + num) if !@letters.include?(letter) || !@nums.include?(num)
        end
        @valid_moves.pop unless capturable.include?(@board[letter][num])
    end

    #quadrant 4
    def diagonal_moves_quadrant_four
        letter = @initial_pos[0]
        num = @initial_pos[1]
        capturable = white? ? @@black_pieces : @@white_pieces

        while @letters.include?(letter) && @nums.include?(num) && @board[letter][num] == '-'
            #gets previous letter in alphabet
            letter = (letter.ord - 1).chr
            num.next!
            @valid_moves.push(letter + num) if !@letters.include?(letter) || !@nums.include?(num)
        end
        @valid_moves.pop unless capturable.include?(@board[letter][num])
    end
end