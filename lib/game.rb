

require_relative 'game_prompts'


class Game

    class InputError < StandardError
        def message
            "Invalid input! Please enter file and rank. eg: d2"
        end
    end


    class CoordinatesError < StandardError
        def message
            "Invalid coordinates! Please enter file and rank of the correct color."
        end
    end


    class MoveError < StandardError
        def message
            "Invalid coordinates! Please enter a valid file and rank to move."
        end
    end


    class PieceError < StandardError
        def message
            "Invalid piece! There are no legal moves for this piece."
        end
    end

    
end