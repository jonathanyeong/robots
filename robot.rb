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
    cmd_keyword = cmd_array.first
    args = cmd_array.last.split(',')

    place(args) if cmd_keyword == 'PLACE'
    return false unless @robot_valid
    return "OUTPUT: #{report}" if cmd_keyword == 'REPORT'
    move if cmd_keyword == 'MOVE'
    rotate(0) if cmd_keyword == 'LEFT'
    rotate(1) if cmd_keyword == 'RIGHT'
  end

  def place(args)
    args = extract_place_args(args)
    x = args[0]
    y = args[1]
    direction = args[2].upcase
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
    new_x = new_pos[0]
    new_y = new_pos[1]
    if within_board?(new_x, new_y)
      is_valid = true
      @pos.replace([new_x, new_y])
    end
    @robot_valid = is_valid
  end

  def report
    if @direction_matrix.first.eql?(1)
      position = 'EAST'
    elsif @direction_matrix.first.eql?(-1)
      position = 'WEST'
    elsif @direction_matrix.last.eql?(1)
      position = 'NORTH'
    elsif @direction_matrix.last.eql?(-1)
      position = 'SOUTH'
    end
    "#{@pos.first},#{@pos.last},#{position}"
  end

  def rotate(f)
    if f.eql?(LEFT) # arbitrary left flag
      rotation_matrix = Matrix[[0, 1], [-1, 0]]
    elsif f.eql?(RIGHT) # arbitrary right flag
      rotation_matrix = Matrix[[0, -1], [1, 0]]
    end

    pos_matrix = Matrix[[@direction_matrix.first, @direction_matrix.last]]
    pos_matrix *= rotation_matrix
    @direction_matrix = [pos_matrix[0, 0], pos_matrix[0, 1]]
  end

  private

  def within_board?(x, y)
    if x < @board_width && x >= 0 \
        && y < @board_height && y >= 0
      return true
    end
    false
  end

  def extract_place_args(args)
    x = args[0].to_i
    y = args[1].to_i
    direction = args[2]
    [x, y, direction]
  end
end
