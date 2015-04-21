require_relative "robot"

@robot = Robot.new(5, 5)
robot_valid = false
ARGF.each do |command|
  if (command.include?("PLACE"))
    arg_string = command.gsub!(/\s+/, "").split("PLACE")
    args = arg_string.last.split(",")
    x = args[0].to_i
    y = args[1].to_i
    direction = args[2]
    robot_valid = @robot.place(x, y, direction)
    if (robot_valid.eql?(false))
      puts "#{command} -- Placement was invalid"
    end
  elsif (command.include?("MOVE"))
    if robot_valid.eql?(true)
      @robot.move
    end
  elsif (command.include?("LEFT"))
    if robot_valid.eql?(true)
      @robot.rotate(0)
    end
  elsif (command.include?("RIGHT"))
    if robot_valid.eql?(true)
      @robot.rotate(1)
    end
  elsif (command.include?("REPORT"))
    if robot_valid.eql?(true)
      puts "OUTPUT: #{@robot.report}"
    end
  end
end
