# CLI Ruby Chess App
## Demo
<img src="docs/App_Demo.gif" alt ="Short chess game demo" width="480" height="320px"/>

### Minimum Requirements
- **Ruby v2.7.2**
- **Bundler v2.2.18**
- 4G RAM
- Windows 7 or later, Mac OS X Mavericks 10.9.5, Linux Ubuntu 14  

To install Ruby, please view and follow these [instructions](https://www.ruby-lang.org/en/documentation/installation/)


To install Bundler, run
**`gem install bundler`**

### Installation
- Clone this repository [instructions](https://docs.github.com/en/github/creating-cloning-and-archiving-repositories/cloning-a-repository-from-github/cloning-a-repository)

- Alternatively, you can download the zip file from this repository. 

Please navigate to the **/src** folder directory from your root directory in your Terminal or Command Line.
- **`cd src`**
- Run **`bundle install`**

Please ensure you have the following ruby gems successfully installed on your machine before running the application:

- colorize v0.8.1
- tty-prompt v0.23.1
- tty-progressbar v0.18.2

This application was built on Ruby version 2.7.2, you may run into some potential issues if your machine is running an older version of Ruby below 2.5. To update to the latest version, please view the [ruby documentation](https://www.ruby-lang.org/en/documentation/installation/).



To check what version of ruby you are running: 
- run **`ruby -v`** or **`lib/main.rb -i`** from the src directory

You can also run lib/main.rb -h to display help message. Possible flags included are shown below, these provide info on how the save/load functions work:
- *-help* or *--help* or *-h* 
- *-info* or *--info* or *-i*
- *-load* or *--load* or *-l*
- *-path* or *--path* or *-p*
- *-save* or *--save* or *-s*

### Windows OS
To ensure correct display of chess characters, please ensure that you set your Command Line font to 

## To Play

- Run **`./run_chess.sh`**
- To start a game, simply select: 
    - Two Player Game OR
    - One Player Game (to play against computer)

For instructions on how to play the game, select **How to Play** from the MAIN MENU options. For full breakdown of rules and how to play the game of chess, please [view this video](https://www.youtube.com/watch?v=fKxG8KjH1Qg)

![How to play](docs/how-to-play.png)

You can also **save** the progress of a game at any time and resume that game later by selecting **Load Game** from the MAIN MENU options and selecting the corresponding number for the game file. 

![Saving Game](docs/Save1.png)
Enter '**s**' to save
<br>
![Main Menu](docs/Load1.png)
To Load a game, select **Load Game** from MAIN MENU
<br>
![Loading Game](docs/Load2.png)
Enter corresponding number for game, i.e. '**1**'
<br>

# Software Development Plan

### Purpose and Scope of application
This a terminal application to play Chess developed using Ruby programming language. Chess is a globally played game and bypasses language barriers. Chess is a complex game comprising of 32 pieces with countless variations and possibilities. The objective of the game is to checkmate the opponent's King.

The decision to create a terminal chess application was mainly based upon the intention of improving my learning and deepening my understanding of the Ruby programming language and Command Line. I wanted to make the game visually appealing and have features that would make it easier for user interaction. One such feature is to have a piece's possible moves and captures highlighted green and red, respectively. Having this feature would broaden the target audience as not everyone is a professional chess player, and would help visually aid them select their moves. Also, I opted to breakdown each player's turn into 2 steps, selecting the piece they wish to move and then selecting where they want the piece to move. As chess notation for both steps would make using the application considerably harder for inexperienced chess players. The target audience for this application is for anyone that wants to play chess in terminal, and also the educators and fellow students at Coder Academy. It is also intended to be used as a reference or resource for anyone that is interested in creating and designing a CLI application.

### What the Application will do
Once a game has started, it will print an (8 x 8) chess board  to the terminal window, with alternating colours, just like a real chess board. It will have all the pieces at all their starting positions (refer to Figure1.0 below). Each player has 1 turn and alternates, with white making the first move.

![Starting Position](docs/reset.png)
**Figure1.0 Start board position**

The application has all piece movement and capture functionality working as per rules of the game. Special movements like castling, en passant and pawn promotion are fully functional. The game ends when checkmate or stalemate is achieved, when either player has no more legal moves, and the King is under check for checkmate, or not under check, resulting in a stalemate aka draw.

### How user will use it
Once loaded, the user is prompted for the game mode in which they wish to play, 1 player or 2 player. Each player's turn is problem up into 2 steps.
**1)** User selects piece they wish to move by entering in its coordinates, i.e. e2
**2)** User selects the location in which they wish to move the selected piece, squares valid moves or captures will be highlighted in green and red, respectively.

At any time during the game, the user my opt to Start a **New Game**, **Save** the current game, **Load** a game or **Quit**. These options will be displayed at the top of the screen.

### Features
One of the main features I wanted to implement was having different square highlighted in various colours based on their possible moves, possible captures, previous piece that moved, active piece selected. This just really helps make gameplay for the user substantially easier with these visual cues.
![Square Color Feature](docs/feature1.png)
As you can see in the diagram above, the selected active piece is the Queen, highlighted in magenta. The possible moves are highlighted in green, and the possible captures are highlighted in red. The previous piece that moved (white King) highlighted in yellow.

The logic behind the color selection for the squares is outline in the code snippet below:

![Code for Square Colors1](docs/squares1.png)
![Code for Square Colors2](docs/squares2.png)

Below is a random example of how the ANSI escape codes are used to print out the desired output for the squares, the pieces, and piece colors:
![Example code for Square Colors](docs/squares4.png)
![Visual representation of example for Square Colors](docs/squares3.png)

This is a visual diagram representation to illustrate how ANSI escape codes work:
![ANSI Escape Code Diagram](docs/ansi-colors.png)

To display the chess pieces in terminal, these are simply just a special unicode character, so it behaves like text. Please refer to this website as a [reference](https://unicode-table.com/en/sets/chess-symbols/).

### Error Handling
If the user enters an invalid coordinate, anything that's not between [a-h] and [1-8], then it will **raise an InputError**, prompting the user to enter a letter [a-h] and number [1-8].
![Input Error message example 1](docs/input-error1.png)
![Input Error message example 2](docs/input-error2.png)

If the user selects a blank square or opponent's piece, it will **raise a CoordinatesError**, prompting the user to enter the file and rank of a piece that is their color.
![Coordinates Error message](docs/coordinates-error.png)

If the user selects a non-valid move for the selected piece, it will **raise a MoveError**, prompting them to enter a valid move.
![Move Error message](docs/move-error.png)

If the selected piece has no legal moves, it will **raise a PieceError** and will prompt user that the selected piece has no legal moves and to select another piece.
![Piece Error message](docs/piece-error.png)

When loading a saved game, if the user selects a file number value that is not listed, it will prompt the user of an input error, and tell them to enter in a valid file number.
![Load Error message](docs/load-error.png)

If there are no saved games, it will inform the user that there a no saved games to play.
![No Saved Games message](docs/no-saved-games.png)

If there is an issue with opening/loading a saved file (**IOError**), it will print to the screen:
```ruby
puts "Error while loading #{filename}"
```

If there is an issue with saving a game (**SystemCallError**), it will print to the screen:
```Ruby
puts "Error while writing to file #{filename}."
```

If for whatever reason there is any other error(s) that arise, there is a 'global/master rescue clause' to catch those errors.

![Global Error Handling](docs/global-rescue.png)

Outlined below are all the Error Classes that have been defined, they're all sub-classes of StandardError such that a single rescue clause can be used to catch them all.

![Error Classes](docs/error-classes.png)

For all the defined Error Classes, these are rescued when they arise during each turn for the 2 steps for user input:

![Error Handling](docs/error-handling.png)

Below is the logic and code for the error validation as to which error to raise.

![Error Validation](docs/error-validation.png)

