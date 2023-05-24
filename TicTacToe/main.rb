require_relative "game.rb"
require_relative "console.rb"

while true
  game = Game.new
  game.start_game

  Console.instance.msg("Do you want to play again? Y/N")
  if Console.instance.get_input != "Y"
    break
  end
end
