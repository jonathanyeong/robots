WIDTH=5
HEIGHT=5

def place(x, y, f)
  if (x < WIDTH or x > 0 or y > 0 or y < HEIGHT)
    puts "robot placed facing #{f}"
    set_robot_origin
    set_robot_face(f)
  else
    puts "Invalid position"
  end
end

def move
  move_robot  # Robot will internally know which way it's facing
end

def facing?
  robot_direction
end

def left
  rotate_robot(left)
end

def right
  rotate_robot(right)
end

def report
  coords = robot_coord
  puts "x #{coords[0]}, y: #{coords[1]} and face: #{coords[2]}"
end

