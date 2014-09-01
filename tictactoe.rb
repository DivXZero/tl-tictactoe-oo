
module Console
  def self.clear_screen
    system('cls')
    system('clear')
  end

  def self.get_input(msg = nil)
    puts "\n~> #{msg} :" unless msg == nil
    gets.chomp.to_s
  end

  def self.display_banner(msg)
    puts "~*~*~*~*~*~*~*~*~*~ #{msg} ~*~*~*~*~*~*~*~*~*~\n\n"
  end
end

class GameBoard
  attr_reader :win_lines

  def initialize
    @board = Array.new(9)
    @win_lines = [[1,2,3],[4,5,6],[7,8,9],[1,4,7],[2,5,8],[3,6,9],[1,5,9],[3,5,7]]
  end

  def display
    puts "\n\t     |     |"
    draw_row(1)
    puts "\t_____|_____|_____"
    puts "\t     |     |"
    draw_row(2)
    puts "\t_____|_____|_____"
    puts "\t     |     |"
    draw_row(3)
    puts "\t     |     |\n\n"
  end

  def win_condition?
    win_lines.each do |line|
      if get_position(line[0]) == get_position(line[1]) && get_position(line[1]) == get_position(line[2])
        return true unless get_position(line[0]).nil?
      end
    end
    return false
  end

  def open_win_condition?
    if get_open_win_position != 0 then
      return true
    else
      return false
    end
  end

  def get_open_win_position
    win_lines.each do |line|

      if get_position(line[0]) == get_position(line[1]) && get_position(line[2]).nil?
        return line[2] unless get_position(line[0]).nil?
      end

      if get_position(line[0]) == get_position(line[2]) && get_position(line[1]).nil?
        return line[1] unless get_position(line[0]).nil?
      end

      if get_position(line[1]) == get_position(line[2]) && get_position(line[0]).nil?
        return line[0] unless get_position(line[1]).nil?
      end

    end
    return 0
  end

  def get_position(num)
    board[num-1]
  end

  def set_position(num, value)
    @board[num-1] = value
  end

  def position_set?(num)
    !board[num-1].nil?
  end

  def full?
    !board.include?(nil)
  end

  private
  def board
    @board
  end

  def draw_row(row)
    puts "\t  #{draw_position((row*3)-2)}  |  #{draw_position((row*3)-1)}  |  #{draw_position(row*3)}"
  end

  def draw_position(num)
    board[num-1] || ' '
  end
end

class Player
  attr_reader :score, :symbol

  def initialize(symbol)
    @score = 0
    @symbol = symbol
  end

  def increment_score(value = 1)
    @score += value
  end

  def turn(board)
    choice = 0
    position_accepted = false
    until choice > 0 && choice < 10 && position_accepted
      choice = Console.get_input('Choose an open position (1-9)').to_i
      if board.position_set?(choice)
        puts 'Position is already taken. Please choose another.'
      else
        position_accepted = true
      end
    end
    board.set_position(choice, self.symbol)
  end

  def ai_turn(board)
    if board.open_win_condition?
      board.set_position(board.get_open_win_position, self.symbol)
    else
      choice = Time.new.to_i # Ensure that our random numbers are unique each game
      choice = rand(1..9)
      choice = rand(1..9) until board.get_position(choice).nil?
      board.set_position(choice, self.symbol)
    end
  end
end

class Game
  attr_reader :player, :computer, :board

  def initialize
    @player = Player.new('X')
    @computer = Player.new('O')
    @board = GameBoard.new
  end

  def run
    Console.clear_screen
    Console.display_banner("Let's Play Tic-Tac-Toe!")
    board.display

    player.turn(board)
    if board.win_condition?
      Console.clear_screen
      Console.display_banner('You Win!')
      player.increment_score
    else
      computer.ai_turn(board) unless board.full?
      if board.win_condition?
        Console.clear_screen
        Console.display_banner('You Lose :(')
        computer.increment_score
      end
    end

    if board.full? && !board.win_condition?
      Console.clear_screen
      Console.display_banner('Out of moves, Game is a Draw.')
    end

    if board.win_condition? || board.full?
      board.display
      display_scores
      @board = GameBoard.new
      run if play_again?
    else
      run
    end
  end

  def display_scores
    puts "\tScores\n\t~*~*~*~*~*~*~*~*~*~\n\tYou:\t\t#{player.score}\n\tComputer:\t#{computer.score}"
  end

  private
  def play_again?
    play_again = {'y' => true, 'n' => false}
    play_again[Console.get_input('Play Again? [y/N]').downcase]
  end
end

game = Game.new
game.run