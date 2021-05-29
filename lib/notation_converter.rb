# frozen_string_literal: true

class NotationConverter
    def initialize
        @row = nil
        @column = nil
    end

    def translate_notation(letter_number)
        coordinates = letter_number.split(//)   # splits into each character
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