require "minitest/autorun"
require_relative "../robot"

class TestRobot < Minitest::Test
  def setup
    @robot = Robot.new
  end
  
  def test_valid_robot_place
    assert_equal(true, @robot.place(0,0,"north"), "Placing should be valid")
  end

  def test_invalid_robot_place
    assert_equal(false, @robot.place(-1, 10,"south"), 
                 "Placing should be invalid")
  end

  def test_invalid_robot_direction
    assert_equal(false, @robot.place(3, 3,"invalid"), 
                 "Placing should be invalid")
  end

  def test_valid_move
    @robot.place(0, 0, "north")
    assert_equal(true, @robot.move, "Move should be valid")
  end

  def test_invalid_move
    @robot.place(0, 0, "south")
    assert_equal(false, @robot.move, "Move should be invalid")
  end

  def test_report
    @robot.place(0, 0, "south")
    assert_equal("0, 0, south", @robot.report)
  end

end
