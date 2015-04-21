# Robots

Board - houses the robot's position and tells the robot that they can move.
Robot - Only cares about trying to move. They don't do any checks they just ask the board:
"Hey board can I move here?"

Position of the robot is returned by the board because it makes sense to ask the board
where the robot is. Instead of asking the robot where it *thinks* it is on the board. (Obviously,
the robot will know where it is but semantically this makes sense in my head).
