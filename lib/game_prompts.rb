# frozen_string_literal: true

require 'colorize'

# contains text prompts for chess game
module GamePrompts
  def select_game_mode
    prompt = TTY::Prompt.new
    menu_select = prompt.select('MAIN MENU',
                                ['1 - Single Player',
                                 '2 - Two Player',
                                 '3 - Load Game',
                                 '4 - How to Play',
                                 '5 - Quit'])
    @mode = menu_select.to_i
  end

  def return_to_menu
    @back_to_menu = TTY::Prompt.new
    @navigation = @back_to_menu.select(' ', ['Back to Menu', 'Start a New Game', 'Exit'])
    puts "This is the users selection: #{@navigation}"
  end

  # def select_game_mode
  #     user_mode_select = gets.strip
  #     return user_mode_select if user_mode_select.match?(/^[12345]$/)   # will only return if input matches defined numbers in []

  #     puts "Input error! Please select from one of the menu options: 1, 2, 3, 4 or 5."
  #     select_game_mode
  # end

  def repeat_game
    puts repeat_game_choices
    input = gets.strip
    choice = input.upcase == 'Q' ? exit_program : :repeat
    return choice if input.match?(/^[QP]$/i)

    puts 'Input error! Please enter Q or P.'
    repeat_game
  end

  def final_message
    return unless @player_count.positive?

    if @board.king_in_check?(@current_turn)
      puts "\e[96m CHECKMATE!! #{previous_color.upcase}\e[0m WINS!"
    else
      puts "\n\e[96m DRAW! STALEMATE! \n\n"
    end
  end

  private

  # def game_mode_choices2
  #     <<~HEREDOC

  #     \e[45m Welcome to CLI Chess! \e[0m

  #     To START, enter one of the following to play:

  #         \e[96m (1)\e[0m to play a \e[93mNew 1-Player\e[0m game against the computer
  #         \e[96m (2)\e[0m to play a \e[93mNew 2-Player\e[0m game
  #         \e[96m (3)\e[0m to play a \e[93mSaved\e[0m game
  #         \e[96m (4)\e[0m to view \e[93mHow To Play\e[0m
  #         \e[96m (5)\e[0m to \e[93mExit Program\e[0m

  #     HEREDOC
  # end

  # \e[45mStep 1:\e[0m
  # Select the coordinates of the piece that you want to move.

  # \e[45mStep 2:\e[0m
  # Enter coordinates of a legal move highlighted in \e[102m  \e[0m or capture \e[101m \u265F \e[0m.

  def how_to_play
    system 'clear'
    puts "HOW TO PLAY \n".colorize(:yellow)
    puts "Each player's turn will comprise of 2 steps. \n".colorize(:cyan)
    puts 'STEP 1: '.colorize(:magenta) + 'Select the coordinates of piece you wish to move.' + " eg. d2 \n".colorize(:cyan)
    puts 'STEP 2: '.colorize(:magenta) + "Enter coordinates of\e[92m valid move\e[0m:"
    puts "        square(s) highlighted \e[102m   \e[0m or capture \e[101m \u265F \e[0m\n\n"

    # "To go back to the Main Menu, press \e[4mM\e[0m"

    sleep(5)
  end

  def repeat_game_choices
    <<~HEREDOC

      Would you like to start a New Game or Quit Game?
      \e[96m[P]\e[0m to Play A New Game or \e[91m[Q] \e[0m to Quit

    HEREDOC
  end

  def game_end_message
    return unless @player_count.positive?

    if @board.king_in_check?(@current_turn)
      puts "\nCHECKMATE! #{previous_color.upcase} WINS!!\n\n".colorize(:green)
    else
      puts "\nSTALEMATE! Game is a draw.\n\n".colorize(:cyan)
    end
  end

  def user_piece_selection
    <<~HEREDOC

      Please enter the \e[94mcoordinates\e[0m of the piece you wish to move.

    HEREDOC
  end

  def user_move_selection
    <<~HEREDOC

      Please enter coordinates for a legal move:
      square(s) highlighted \e[102m   \e[0m or capture \e[101m \u265F \e[0m.

    HEREDOC
  end

  def en_passant_warning
    puts "\e[96mOption to capture the opposing pawn that just moved.\e[0m\n"
    puts "\e[91mTo capture this pawn en passant\e[0m (in passing),"
    puts "please enter the \e[41mhighlighted coordinates\e[0m."
    puts "As part of en passant, your\e[96m pawn will be moved"
    puts "to the square in front of the captured pawn\e[0m."
  end

  def king_check_warning
    puts "\n\e[91mWARNING!\e[0m Your \u2654 King is currently in \e[91mcheck!\e[0m"
  end

  def castling_warning
    puts "\e[96mYou have the option to castle: \e[0m \n\n\e[95mYour King \u2654 will move 2 spaces\e[0m \nand will castle with the rook."
    puts "Your\e[96m Rook \u2656 will be moved\e[0m to the \nsquare that the king passes through."
  end

  def previous_color
    @current_turn == :white ? 'Black' : 'White'
  end

  def resign_game
    puts "#{@current_turn.upcase} RESIGNS! #{previous_color.upcase} WINS!!! \n\n".colorize(:green)
    @player_count = 0 # when player count is less than 1, ends game
  end

  def exit_program
    puts 'Are you sure you want to Exit?'
    @input == 'yes' ? quit_app : return_to_menu
  end

  def quit_app
    system 'clear'
    puts "Thank you for playing CLI Chess! \nHope you enjoyed this game!"
    sleep(2)
    exit
  end
end
