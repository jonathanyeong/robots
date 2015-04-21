require_relative "board"

class Robot
  attr_accessor :pos, :direction
  def initialize()
    @pos = nil
    @direction = nil
    @width = 5
    @height = 5
  end

  def place(x, y, f)
    is_valid = false
    direction = f.upcase
    # Check if it's in the bounds of the board
    if (x < @width and x >= 0 and y < @height and y >= 0)
      @pos = [x, y]
      is_valid = true
      if (direction.eql?("NORTH"))
        @direction = [1, 0]
      elsif (direction.eql?("EAST"))
        @direction = [0, 1]
      elsif (direction.eql?("SOUTH"))
        @direction = [-1, 0]
      elsif (direction.eql?("WEST"))
        @direction = [0, -1]
      else
        is_valid = false
      end
    end
    is_valid  # Return is valid
  end
  
  def move
    is_valid = false
    x = @pos.first
    y = @pos.last
    moveX = @direction.first
    moveY = @direction.last
    newX = x + moveX
    newY = y + moveY
    if (newX < @width and newX >= 0 and newY < @height and newY >= 0)
      is_valid = true
      @pos.replace([newX, newY])
    end
    is_valid
  end

  def report
  end
end
