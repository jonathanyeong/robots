require "matrix"

class Robot
  LEFT = 0
  RIGHT = 1
  attr_reader :pos, :direction_matrix

  def initialize(width, height)
    @board_width = width
    @board_height = height
    @robot_valid = false
    @direction_hash = { 'NORTH' => [0, 1],
                        'EAST'  => [1, 0],
                        'SOUTH' => [0, -1],
                        'WEST'  => [-1, 0]
                       }
  end

  def command(cmd)
    cmd_array = cmd.split(' ')
    if cmd_array.first == "PLACE"
      args = cmd_array.last.split(",")
      x = args[0].to_i
      y = args[1].to_i
      direction = args[2]
      place(x, y, direction)
      return false if @robot_valid.eql?(false)
    elsif @robot_valid
      if cmd_array.first == "MOVE"
        move
      elsif cmd_array.first == "LEFT"
        rotate(0)
      elsif cmd_array.first == "RIGHT"
        rotate(1)
      elsif cmd_array.first == "REPORT"
        return "OUTPUT: #{report}"
      end
    end
  end

  # Robot test will fail if these methods are private

  def place(x, y, f)
    direction = f.upcase
    @robot_valid = false
    @direction_matrix = @direction_hash[direction]
    return unless within_board?(x, y)
    return if @direction_matrix.nil? # Invalid direction
    @pos = [x, y]
    @robot_valid = true
  end

  def move
    is_valid = false
    # Zip merges elements of @pos with
    # corresponding elements of @direction_matrix
    # Then the map sums each sub array
    new_pos = @pos.zip(@direction_matrix).map{|x| x.inject{|a, b| a + b}}
    newX = new_pos[0]
    newY = new_pos[1]
    if within_board?(newX, newY)
      is_valid = true
      @pos.replace([newX, newY])
    end
    @robot_valid = is_valid
  end

  def report
    if @direction_matrix.first.eql?(1)
      position = "EAST"
    elsif @direction_matrix.first.eql?(-1)
      position = "WEST"
    elsif @direction_matrix.last.eql?(1)
      position = "NORTH"
    elsif @direction_matrix.last.eql?(-1)
      position = "SOUTH"
    end

    output_string = "#{@pos.first},#{@pos.last},#{position}"
  end

  def rotate(f)
    if f.eql?(LEFT) # arbitrary left flag
      rotation_matrix = Matrix[[0, 1], [-1, 0]]
    elsif f.eql?(RIGHT) # arbitrary right flag
      rotation_matrix = Matrix[[0, -1], [1, 0]]
    end

    pos_matrix = Matrix[[@direction_matrix.first, @direction_matrix.last]]
    pos_matrix = pos_matrix * rotation_matrix
    @direction_matrix = [pos_matrix[0,0], pos_matrix[0,1]]
  end

  private

  def within_board?(x, y)
    if x < @board_width && x >= 0 \
        && y < @board_height && y >= 0
      return true
    end
    false
  end
end
