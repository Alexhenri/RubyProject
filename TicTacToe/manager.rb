require 'singleton'
require_relative "console.rb"

#TYPE OF GAMES
PVC = 1 # PLAYER vs COMPUTER
PVP = 2 # PLAYER vs PLAYER
CVC = 3 # COMPUTER vs COMPUTER

class Manager

  def initialize
    @game_type = define_game_type
    def self.game_type
      @game_type
    end
    @game_is_on = true
    def self.game_is_on
      @game_is_on
    end
    @round = 1
    def self.round
      @round
    end
    @control_board = %w[0 1 2 3 4 5 6 7 8]
    def self.control_board
      @control_board
    end

  end

  # DEFINE GAME TYPE
  def define_game_type
    Console.instance.msg("Choose how do you wanna play:")
    Console.instance.msg("#{PVC} - Player vs Computer\n#{PVP} - Player vs Player\n#{CVC} - Computer vs Computer\n")
    game_type = Console.instance.get_input_int
    if (1..3).to_a.include? game_type
      @game_type = game_type
    else
      Console.instance.error
      define_game_type
    end
  end

  def play_round(player, op_marker)
    spot = player.get_spot(op_marker, @control_board)
    return spot
  end

  def increase_round
    @round += 1
  end
  def check_end_game(name)
    if game_is_over(@control_board)
      @game_is_on = false
      puts "Congratulations #{name}!! You won!! "
    end

    if tie(@control_board)
      puts "Draw!!"
      @game_is_on = false
    end
  end
end

def game_is_over(b)
    [b[0], b[1], b[2]].uniq.length == 1 ||
    [b[3], b[4], b[5]].uniq.length == 1 ||
    [b[6], b[7], b[8]].uniq.length == 1 ||
    [b[0], b[3], b[6]].uniq.length == 1 ||
    [b[1], b[4], b[7]].uniq.length == 1 ||
    [b[2], b[5], b[8]].uniq.length == 1 ||
    [b[0], b[4], b[8]].uniq.length == 1 ||
    [b[2], b[4], b[6]].uniq.length == 1
end

def tie(b)
  b.all? { |s| s == "X" || s == "O" }
end