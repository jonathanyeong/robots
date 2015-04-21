require "minitest/autorun"
require_relative "../robot"

class TestRobot < Minitest::Test
  def setup
    @board = Board.new(5, 5)
    @robot = Robot.new(@board)
  end

  def test_initial_robot_state
    # Should have a nil position and direction initally
    assert_nil(@pos)
    assert_nil(@direction)
  end

  def test_invalid_x_placement
    assert_equal(false, @robot.place(10, 3, "north"),
                 "Placing robot was valid when it should be invalid")
  end

  def test_invalid_y_placement
    assert_equal(false, @robot.place(4, -10, "north"),
                 "Placing robot was valid when it should be invalid")
  end

  def test_valid_placement_on_origin
    assert_equal(true, @robot.place(0, 0, "north"),
                 "Placing robot should be valid")
  end

  def test_valid_placement_on_boundary
    assert_equal(true, @robot.place(4, 4, "north"),
                 "Placing robot should be valid")
  end

  def test_valid_movement
    @robot.place(0, 0, "north")
    assert_equal(true, @robot.move, "Robot should be able to move up")
  end
end
