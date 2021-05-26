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
            print_box(row_index, index, box, background_color)
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

    # sets the font colours for each square based on specific conditions
    # 97 = white (chess pieces)
    # 91 = light red (possible moves circle \u25CF)  might change to square depending on how it looks
    # 30 = black (chess pieces)
    def print_box(row_index, column_index, box, background)
        if box
            text_color = box.color == :white ? 97: 30
            color_box(text_color, background, box.symbol)
        elsif @active_piece&.moves&.any?([row_index, column_index])
            color_box(91, background, " \u25CF ")
        else
            color_box(30, background, '   ')
        end
    end

    # prints the final box/square with the specified background, font and string (in this case, ascii chess symbol)
    def color_box(font, background, string)
        print "\e[#{font};#{background}m#{string}\e[0m"
    end
end