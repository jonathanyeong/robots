require_relative 'robot'

def main(*cmds)
  robot = Robot.new(5, 5)
  report = ''
  cmds.each do |cmd|
    report = robot.command(cmd)
    if report == false
      report = "#{cmd} -- Placement was invalid"
      break
    end
  end
  report
end
