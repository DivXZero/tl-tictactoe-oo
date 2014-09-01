
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
      if get_position(line[0]) and get_position(line[1]) and get_position(line[2])
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

  end

  def ai_turn(board)

  end
end

class Game
  def initialize

  end

  def run

  end
end

Console.clear_screen
player = Player.new('X')
computer = Player.new('O')
board = GameBoard.new
board.set_position(1, player.symbol)
#board.set_position(5, player.symbol)
board.set_position(9, player.symbol)
board.display
puts "Win Condition?: #{board.win_condition?}\tOpen Win Condition?: #{board.open_win_condition?}\tOpen Win Position: #{board.get_open_win_position}"