class King < Piece

    def find_valid_moves
        #king can move in any direction, but only 1 square at a time
        #check if king will be in_check if the king moves there
    end
    
    def able_to_castle?
        
    end

    def check_threats
        #will check for all diagonals and horizontals
        #every new_valid position, iterate through the above
        
        #there will have to be a special case for knights
    end

    def identify_threat
        #if piece of opposing color is found, then this method will be called
        #if piece matches (ie/ bishop at diagonal) then @valid_moves.pop. Otherwise do nothing
    end
end