require_relative "robot"
require "pry"

@robot = Robot.new()
i = 0
ARGF.each do |command|
  #puts "#{i}: #{command}"
  if (command.include?("PLACE"))
    command.slice!("PLACE ")
    args = command.split(',')
    x = args[0].to_i
    y = args[1].to_i
    direction = args[2].gsub(/\s+/, "")
    valid = @robot.place(x, y, direction)
    if (!valid.eql?(true))
      puts "Placement was invalid"
      break 
    end
  elsif (command.include?("MOVE"))
    @robot.move
  elsif (command.include?("LEFT"))
    @robot.rotate(0)
  elsif (command.include?("RIGHT"))
    @robot.rotate(1)
  elsif (command.include?("REPORT"))
    puts "OUTPUT: #{@robot.report}"
  end
  i += 1 
end
