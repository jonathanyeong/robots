require_relative "board"
require "pry"
require "matrix"

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
        @direction = [0, 1]
      elsif (direction.eql?("EAST"))
        @direction = [1, 0]
      elsif (direction.eql?("SOUTH"))
        @direction = [0, -1]
      elsif (direction.eql?("WEST"))
        @direction = [-1, 0]
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
    if (@direction.first.eql?(1))
      position = "EAST"
    elsif (@direction.first.eql?(-1))
      position = "WEST"
    elsif (@direction.last.eql?(1))
      position = "NORTH"
    elsif (@direction.last.eql?(-1))
      position = "SOUTH"
    end

    output_string = "#{@pos.first}, #{@pos.last}, #{position}"
  end

  def rotate(f)  # Where f is left or right..
    #subtracting x and adding a y
    if (f.eql?(0)) # arbitrary left flag
      rotation_matrix = Matrix[[0,1],[-1,0]]
    elsif (f.eql?(1)) # arbitrary right flag
      rotation_matrix = Matrix[[0,-1],[1,0]]
    end
    
    pos_matrix = Matrix[[@direction.first, @direction.last]]
    pos_matrix = pos_matrix * rotation_matrix 
    @direction = [pos_matrix[0,0], pos_matrix[1,0]]
  end
end
