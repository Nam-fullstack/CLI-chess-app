# frozen_string_literal: true

# converts chess notation into 2D array coordinates
class NotationConverter
    def initialize
        @row = nil
        @column = nil
    end

    # returns the coordinates as a hash from the user's chess notation input: ie. d2  letter(column) and number(row)
    def translate_notation(letter_number)
        coordinates = letter_number.split(//) # splits into each character
        translate_row(coordinates[1])
        translate_column(coordinates[0])
        { row: @row, column: @column }
    end

    private

    # converts file (a-h) to a number 0-7 using ASCII numbers for characters
    def translate_column(letter)
        @column = letter.downcase.ord - 97
    end

    # converts the rank (8-1) to a number 0-7
    def translate_row(number)
        @row = 8 - number.to_i
    end
end
