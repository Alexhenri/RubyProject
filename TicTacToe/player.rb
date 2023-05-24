require_relative "console.rb"

class Player
  def initialize(marker, num)
    @name = get_name(num)
    def self.name
      @name
    end
    @marker = marker
    def self.marker
      @marker
    end
  end

  def get_name(num = "")
    # SET PLAYERS NAME
    Console.instance.msg("Type the name of Player #{num}")
    @name = Console.instance.get_input
  end


  def get_spot(op_marker, board, manager=nil)
    Console.instance.msg("#{@name} please make your move (1-9)!\n")
    spot = Console.instance.get_input_int - 1
    if board.include? spot.to_s and (0..8).to_a.include? spot
      spot
    else
      Console.instance.error
      get_spot(op_marker, board)
    end
  end

end
