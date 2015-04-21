require "matrix"

class Robot
  LEFT = 0
  RIGHT = 1
  attr_reader :pos, :direction_matrix
  def initialize(width, height)
    @board_width = width 
    @board_height = height
  end

  def place(x, y, f)
    is_valid = false
    direction = f.upcase
    # Check if it's in the bounds of the board
    if (is_within_board?(x,y))
      @pos = [x, y]
      is_valid = true
      if (direction.eql?("NORTH"))
        @direction_matrix = [0, 1]
      elsif (direction.eql?("EAST"))
        @direction_matrix = [1, 0]
      elsif (direction.eql?("SOUTH"))
        @direction_matrix = [0, -1]
      elsif (direction.eql?("WEST"))
        @direction_matrix = [-1, 0]
      else
        # If direction is invalid then placement is invalid
        is_valid = false
        @pos = nil
      end
    end
    return is_valid
  end
  
  def move
    is_valid = false
    # Zip merges elements of @pos with 
    # corresponding elements of @direction_matrix
    # Then the map sums each sub array
    new_pos = @pos.zip(@direction_matrix).map{|x| x.inject{|a, b| a + b}}
    newX = new_pos[0]
    newY = new_pos[1]
    if (is_within_board?(newX, newY))
      is_valid = true
      @pos.replace([newX, newY])
    end
    return is_valid
  end

  def report
    if (@direction_matrix.first.eql?(1))
      position = "EAST"
    elsif (@direction_matrix.first.eql?(-1))
      position = "WEST"
    elsif (@direction_matrix.last.eql?(1))
      position = "NORTH"
    elsif (@direction_matrix.last.eql?(-1))
      position = "SOUTH"
    end
   
    output_string = "#{@pos.first}, #{@pos.last}, #{position}"
  end

  def rotate(f)
    if (f.eql?(LEFT)) # arbitrary left flag
      rotation_matrix = Matrix[[0,1],[-1,0]]
    elsif (f.eql?(RIGHT)) # arbitrary right flag
      rotation_matrix = Matrix[[0,-1],[1,0]]
    end
    
    pos_matrix = Matrix[[@direction_matrix.first, @direction_matrix.last]]
    pos_matrix = pos_matrix * rotation_matrix 
    @direction_matrix = [pos_matrix[0,0], pos_matrix[0,1]]
  end

  private

    def is_within_board?(x, y)
      if (x < @board_width and x >= 0 \
          and y < @board_height and y >= 0)
        return true
      end
      return false
    end
end
