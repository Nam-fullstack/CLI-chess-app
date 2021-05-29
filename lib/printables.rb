# frozen_string_literal: true

require 'colorize'

module Printables
    private
    
    # prints out chess board with file(letter) and rank(number) coordinates
    def print_chess_board
        system 'clear'
        puts "\n    a  b  c  d  e  f  g  h".colorize(:cyan)
        print_board
        puts "    a  b  c  d  e  f  g  h \n".colorize(:cyan)
    end

    # iterates through each row of the board and adds rank. In chess, the rows
    # go from 1-8, starting from the bottom. 
    def print_board
        @data.each_with_index do |row, index|
            print " #{8 - index} ".colorize(:cyan)
            print_row(row, index)
            print " #{8 - index} \n".colorize(:cyan)
        end
    end

    # creates each row to be printed with an alternating color
    def print_row(row, row_index)
        row.each_with_index do |box, index|
            background_color = select_background(row_index, index)
            print_box(row_index, index, box, background_color)
        end
    end

    # returns background color based on specific conditions:
    # 105 = magenta background (active piece to move)
    # 101 = red background     (possible captures)
    # 102 = green background   (possible moves)
    # 103 = yellow background  (previous piece that moved)
    #  44 = cyan background    (even)
    # 100 = gray background    (odd)
    def select_background(row_index, column_index)
        if @active_piece&.location == [row_index, column_index]
            105
        elsif capture_background?(row_index, column_index)
            101
        elsif @previous_piece&.location == [row_index, column_index]
            103
        elsif active_moves?(row_index, column_index)
            102
        elsif (row_index + column_index).even?
            46
        else
            100
        end
    end

    def capture_background?(row, column)
        @active_piece&.captures&.any?([row, column]) && @data[row][column]
    end

    def active_moves?(row, column)
        @active_piece&.moves&.any?([row, column])
    end

    # sets the font colours for each square based on specific conditions
    # 107 = white (chess pieces)
    # 102 = green (possible moves)
    #  30 = black (chess pieces)
    def print_box(row_index, column_index, box, background)
        if box
            text_color = box.color == :white ? 107 : 30
            color_box(text_color, background, box.symbol)
        # elsif 
        #     color_box(102, background, "\e[102m   \e[0m")
        else
            color_box(30, background, '   ')
        end
    end

    # prints the final box/square with the specified background, font and string (in this case, ascii chess symbol)
    def color_box(font, background, string)
        print "\e[#{font};#{background}m#{string}\e[0m"
    end
end