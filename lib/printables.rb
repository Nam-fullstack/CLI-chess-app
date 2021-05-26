require 'colorize'

module Printables

    def print_chess_board
        system 'clear'
        puts "\n     a   b   c   d   e   f   g   h".colorize(cyan)
        print_board
        puts "     a   b   c   d   e   f   g   h \n".colorize(cyan)
    end

    def print_board
        @data.each_with_index do |row, index|
            print "#{8 - index} ".colorize(cyan)
            print_row(row, index)
            print "#{8 - index} ".colorize(cyan)
            puts
        end
    end

    def print_row(row, row_index)
        row.each_with_index do |box, index|
            background_color = select_background(row_index, index)
            print_square(row_index, index, box, background_color)
        end
    end

    def select_background(row_index, column_index)
        if @active_piece&.location == [row_index, column_index]
            106
        elsif capture_background?(row_index, column_index)
            101
        elsif @previous_piece&.location == [row_index, column_index]
            45
        elsif (row_index + column_index).even?
            47
        else
            46
        end
    end

    def capture_background?(row, column)
        @active_piece&.captures&.any?([row, column]) && @data[row][column]
    end
end