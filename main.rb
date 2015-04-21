require_relative "robot"

while true
  command = gets.chomp
  if command.eql?("exit")
    break
  elsif command.eql?("help")
    puts <<-DOC 
      Move your robot around the board. Commands:
        exit - Exit the program
    DOC
  end
end
