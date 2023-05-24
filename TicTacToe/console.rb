require 'singleton'
class Console
  include Singleton

  def error
    puts "Please select one of the available choices."
  end

  def msg(msg)
    puts(msg)
  end

  def get_input
    gets.chomp
  end

  def get_input_int
    gets.chomp.to_i
  end

  # HERE WE DISPLAY THE EMPTY TIC TAC TOE BOARD WITH MOVES ONLY
  def display_board(board)
    puts "  #{board[0]}  |  #{board[1]}  |   #{board[2]}  "
    puts "-----------------"
    puts "  #{board[3]}  |  #{board[4]}  |   #{board[5]}  "
    puts "-----------------"
    puts "  #{board[6]}  |  #{board[7]}  |   #{board[8]}  "
  end

  # HERE WE DISPLAY THE FIRST TIC TAC TOE BOARD WITH THE PLACES TO HELPS USER
  def display_initial_board(board)
    puts "  #{board[0].to_i + 1}  |  #{board[1].to_i + 1}  |   #{board[2].to_i + 1}  "
    puts "-----------------"
    puts "  #{board[3].to_i + 1}  |  #{board[4].to_i + 1}  |   #{board[5].to_i + 1}  "
    puts "-----------------"
    puts "  #{board[6].to_i + 1}  |  #{board[7].to_i + 1}  |   #{board[8].to_i + 1}  "
  end

  def clear
    puts "\n" * 50 #clear the console system("clear") does not work
  end

end
