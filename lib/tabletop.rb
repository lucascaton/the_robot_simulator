class Tabletop
  attr_accessor :placements

  def initialize(size)
    @placements = size.times.map { [:empty].cycle.take(size) }
  end

  def move(robot, x, y)
    if x >= 0 && y >= 0 && @placements[x] && @placements[x][y] == :empty
      @placements[robot.x][robot.y] = :empty if robot.x && robot.y
      @placements[x][y] = robot
      robot.move(x, y)
      true
    else
      false
    end
  end
end
