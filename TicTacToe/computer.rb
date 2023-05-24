require_relative 'player.rb'
require_relative "console.rb"
require_relative "manager.rb"

#TYPE OF DIFFICULTY
EASY = 1 # ROLL THE DICE - IF DICE == 6 GETS THE BEST MOVE, ELSE GETS A RANDOM SPOT
NORMAL = 2 #  ROLL THE DICE - IF DICE > 3 GETS THE BEST MOVE, ELSE GETS A RANDOM SPOT
HARD = 3 # COMPUTER IS ALWAYS TRYING TO GET THE BEST MOVE

class Computer < Player

  def initialize(marker, num)
    @name = get_computer_name(num)
    def self.name
      @name
    end
    @marker = marker
    def self.marker
      @marker
    end
    @difficulty = get_computer_difficulty
  end

  def get_computer_name(num)
    @name = "Computer#{num}"
  end

  def get_spot(op_marker, board)
    if @difficulty == EASY
      get_easy_spot(op_marker, board)
    elsif @difficulty == NORMAL
      get_normal_spot(op_marker, board)
    else # HARD
      get_hard_spot(op_marker, board)
    end
  end

  def lucky_dice
    rand(1...7)
  end

  def get_easy_spot(op_marker, board)
    if lucky_dice == 6
      get_best_spot(op_marker, board)
    else
      get_random_spot(op_marker, board)
    end
  end

  def get_normal_spot(op_marker, board)
    if lucky_dice < 4
      get_random_spot(op_marker, board)
    else
      get_best_spot(op_marker, board)
    end
  end

  def get_hard_spot(op_marker, board)
    get_best_spot(op_marker, board)
  end

  def get_random_spot(op_marker, board)
    spot = rand(9)
    if board[spot] != @marker and board[spot] != op_marker
      return spot
    else
      get_random_spot(op_marker, board)
    end
  end

  def get_best_spot(opponent_marker, board)
    if board[4] == "4"
      best_spot = 4
      return best_spot
    else
      spot = get_best_move(opponent_marker, board)
      if board[spot] != "X" && board[spot] != "O"
        return spot
      else
        get_best_spot(opponent_marker, board)
      end
    end
  end

  def get_best_move(op_marker, board)
    available_spaces = []
    move_to_not_lose = nil
    board.each do |s|
      if s != "X" && s != "O"
        available_spaces << s
      end
    end
    available_spaces.each do |as|
      board[as.to_i] = @marker
      if game_is_over(board) # for each available space checks if the move win the game
        win_move = as.to_i
        board[as.to_i] = as
        return win_move
      else
        board[as.to_i] = op_marker # for each available space checks if the move makes opponent win the game
        if game_is_over(board)
          move_to_not_lose = as.to_i
        end
        board[as.to_i] = as
      end
    end

    if move_to_not_lose
      return move_to_not_lose
    end

    n = rand(0..available_spaces.count)
    return available_spaces[n].to_i
  end

  def get_computer_difficulty
    Console.instance.msg("Choose #{@name} difficulty:\n")
    Console.instance.msg("#{EASY} - Easy\n#{NORMAL} - Normal\n#{HARD} - Hard\n")
    difficulty = Console.instance.get_input_int
    if (1..3).to_a.include? difficulty
      @difficulty = difficulty
    else
      Console.instance.error
      get_computer_difficulty
    end
  end
end



