require_relative "board"

class Robot
  attr_accessor :pos, :direction, :board
  def initialize(board)
    @pos = nil
    @direction = nil
    @board = board
  end

  def place(x, y, f)
    is_valid = false
    # Check if it's in the bounds of the board
    if (x < @board.width and x >= 0 and y < @board.height and y >= 0)
      @pos = [x, y]

      if (f == "NORTH")
        @direction = [1, 0]
      elsif (f == "EAST")
        @direction = [0, 1]
      elsif (f == "SOUTH")
        @direction = [-1, 0]
      elsif (f == "WEST")
        @direction = [0, -1]
      end
      is_valid = true
    end
    is_valid  # Return is valid
  end
  
  def move
  end
end
