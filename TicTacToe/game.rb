require_relative "console.rb"
require_relative "player.rb"
require_relative "computer.rb"
require_relative "manager.rb"

class Game

  def initialize
    @display_board = [" "," "," "," "," "," "," "," "," "]
    @players = []
  end

  # START THE GAME
  def start_game

    Console.instance.msg("Welcome to Tic Tac Toe Game\n")

    # START BY CHOOSING THE GAME TYPE
    @manager = Manager.new

    # SETTING PLAYERS
    set_players(@manager.game_type)

    # DISPLAY THE BOARD
    Console.instance.display_initial_board(@manager.control_board)
    sleep(2) #just to see watch marker each player/computer are

    # LOOP WHILE GAME IS ON, IN OTHER WORDS, UNTIL THE GAME WAS WON OR TIED
    while @manager.game_is_on
      game_loop
    end
  end

  # SET PLAYERS NAME
  def set_players(game_type)
    if game_type == PVC # player vs computer
      @player1 = Player.new("X", 1)
      @player2 = Computer.new("O", 1)
    elsif game_type == PVP # player vs player
      @player1 = Player.new("X", 1)
      @player2 = Player.new("O", 2)
    else # CVC
      @player1 = Computer.new("X", 1)
      @player2 = Computer.new("O", 2)
    end
    Console.instance.msg("#{@player1.name} will be '#{@player1.marker}'\n#{@player2.name} will be '#{@player2.marker}'")
  end

  def set_spot(spot, marker)
    @manager.control_board[spot] = marker
    @display_board[spot] = marker
  end

  def game_loop
    # SELECT THE RIGHT PLAYER FOR EACH ROUND AND GET THE SPOT
    if @manager.round % 2 != 0 # odd rounds
      spot = @manager.play_round(@player1, @player2.marker)
      player = @player1
    else # even rounds
      spot = @manager.play_round(@player2, @player1.marker)
      player = @player2
    end

    # SET THE SPOT ON DISPLAY/CONTROL BOARD
    set_spot(spot, player.marker)

    # DISPLAY UPDATED BOARD
    Console.instance.clear
    Console.instance.display_board(@display_board)

    if @manager.game_type == CVC # when are playing computer vs computer, this helps to see each move
      Console.instance.msg("#{player.name} played.")
      sleep(2)
    end

    # CHECKS IF THE GAME WAS WON OR TIED
    @manager.check_end_game(player.name)
    @manager.increase_round
  end
end

