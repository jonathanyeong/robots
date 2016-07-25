require 'minitest/autorun'
require_relative '../main'

class TestMain < Minitest::Test
  def test_one
    output = main('PLACE 0,0,NORTH',
                  'MOVE',
                  'REPORT')
    assert_equal(output,
                 'OUTPUT: 0,1,NORTH',
                 "Expected OUTPUT: 0,1,NORTH instead got #{output}")
  end

  def test_two
    output = main('PLACE 0,0,NORTH',
                  'LEFT',
                  'REPORT')
    assert_equal(output,
                 'OUTPUT: 0,0,WEST',
                 "Expected OUTPUT: 0,0,WEST instead got #{output}")
  end


  def test_three
    output = main('PLACE 1,2,EAST',
                  'MOVE',
                  'MOVE',
                  'LEFT',
                  'MOVE',
                  'REPORT')
    assert_equal(output,
                 'OUTPUT: 3,3,NORTH',
                 "Expected OUTPUT: 3,3,NORTH instead got #{output}")
  end

  def test_four
    output = main('PLACE 0,0,WHEREVER',
                  'REPORT')
    assert_equal(output,
                 'PLACE 0,0,WHEREVER -- Placement was invalid',
                 "Expected invalid instead got #{output}")
  end
  #
  # def test_four
  # end
  #
  # def test_five
  # end
  #
  # def test_six
  # end
  #
  # def test_seven
  # end
  #
  # def test_eight
  # end
  #
  # def test_nine
  # end
end


# PLACE 0,0,NORTH
# LEFT
# REPORT
# EXPECTED: 0,0,NORTH
#
# PLACE 1,2,EAST
# MOVE
# MOVE
# LEFT
# MOVE
# REPORT
# EXPECTED: 3,3,NORTH
#
# PLACE 0,0,SOUTH
# MOVE
# MOVE
# MOVE
# MOVE
# REPORT
# EXPECTED: 0,0,SOUTH
#
# PLACE 5,5,NORTH
# REPORT
# EXPECTED: INVALID
#
# PLACE 2,2,NORTH
# MOVE
# MOVE
# MOVE
# REPORT
# EXPECTED: 2,4,NORTH
# RIGHT
# MOVE
# MOVE
# REPORT
# EXPECTED: 4,4,EAST
#
# PLACE 1,1,NORTH
# LEFT
# MOVE
# LEFT
# MOVE
# LEFT
# MOVE
# LEFT
# MOVE
# REPORT
# EXPECTED: 1,1,NORTH
#
# PLACE 1,1,NORTH
# RIGHT
# MOVE
# RIGHT
# MOVE
# RIGHT
# MOVE
# RIGHT
# MOVE
# REPORT
# EXPECTED: 1,1,NORTH
#
# PLACE 1,1,INVALID
# REPORT
# EXPECTED: INVALID
