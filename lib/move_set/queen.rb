class Queen < Piece
    
    def find_valid_moves
        horizontal
        vertical
        diagonal_moves_quadrant_one
        diagonal_moves_quadrant_two
        diagonal_moves_quadrant_three
        diagonal_moves_quadrant_four
    end

    #add rook and bishop methods
    def horizontal
        letter = @initial_pos[0]
        num = @initial_pos[1]
        capturable = white? ? @@black_pieces : @@white_pieces

        while @letters.include?(letter) && @board[letter][num] == '-'
            #gets previous letter in alphabet
            letter = (letter.ord - 1).chr
            @valid_moves.push(letter + num) if @letters.include?(letter)
        end
        @valid_moves.pop unless capturable.include?(@board[letter][num])

        letter = @initial_pos[0]

        while @letters.include?(letter) && @board[letter][num] == '-'
            #gets previous letter in alphabet
            letter = (letter.ord + 1).chr
            @valid_moves.push(letter + num) if @letters.include?(letter)
        end
        @valid_moves.pop unless capturable.include?(@board[letter][num])
    end

    def vertical
        letter = @initial_pos[0]
        num = @initial_pos[1]
        capturable = white? ? @@black_pieces : @@white_pieces

        while @nums.include?(num) && @board[letter][num] == '-'
            #gets previous letter in alphabet
            num = num.to_i
            num -= 1
            num = num.to_s
            @valid_moves.push(letter + num) if @nums.include?(num)
        end
        @valid_moves.pop unless capturable.include?(@board[letter][num])

        num = @initial_pos[1]

        while @nums.include?(num) && @board[letter][num] == '-'
            #gets previous letter in alphabet
            num = num.to_i
            num += 1
            num = num.to_s
            @valid_moves.push(letter + num) if @nums.include?(num)
        end
        @valid_moves.pop unless capturable.include?(@board[letter][num])
    end

    def diagonal_moves_quadrant_one
        letter = @initial_pos[0]
        num = @initial_pos[1]
        capturable = white? ? @@black_pieces : @@white_pieces

        while on_board?(letter + num) && @board[letter][num] == '-'
            #gets previous letter in alphabet
            letter = (letter.ord - 1).chr
            num = num.to_i
            num -= 1
            num = num.to_s
            @valid_moves.push(letter + num) if on_board?(letter + num)
        end
        @valid_moves.pop unless capturable.include?(@board[letter][num])
    end

    def diagonal_moves_quadrant_two
        letter = @initial_pos[0]
        num = @initial_pos[1]
        capturable = white? ? @@black_pieces : @@white_pieces

        while on_board?(letter + num) && @board[letter][num] == '-'
            #gets previous letter in alphabet
            letter = (letter.ord + 1).chr
            num = num.to_i
            num -= 1
            num = num.to_s
            @valid_moves.push(letter + num) if on_board?(letter + num)
        end
        @valid_moves.pop unless capturable.include?(@board[letter][num])
    end

    def diagonal_moves_quadrant_three
        letter = @initial_pos[0]
        num = @initial_pos[1]
        capturable = white? ? @@black_pieces : @@white_pieces

        while on_board?(letter + num) && @board[letter][num] == '-'
            #gets next letter in alphabet
            letter = (letter.ord + 1).chr
            num.next!
            @valid_moves.push(letter + num) if on_board?(letter + num)
        end
        @valid_moves.pop unless capturable.include?(@board[letter][num])
    end

    #quadrant 4
    def diagonal_moves_quadrant_four
        letter = @initial_pos[0]
        num = @initial_pos[1]
        capturable = white? ? @@black_pieces : @@white_pieces

        while on_board?(letter + num) && @board[letter][num] == '-'
            #gets previous letter in alphabet
            letter = (letter.ord - 1).chr
            num.next!
            @valid_moves.push(letter + num) if on_board?(letter + num)
        end
        @valid_moves.pop unless capturable.include?(@board[letter][num])
    end
end