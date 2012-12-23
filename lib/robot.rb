class Robot
  attr_reader :tabletop, :ready, :direction, :x, :y

  def initialize(tabletop)
    @tabletop = tabletop
    @ready = false
  end

  def execute(command)
    case
    when command.match(/PLACE/)  then place(/PLACE (?<x>\d),(?<y>\d),(?<direction>[A-Z]+)/.match(command))
    when command.match(/MOVE/)   then move_forward
    when command.match(/LEFT/)   then turn_left
    when command.match(/RIGHT/)  then turn_right
    when command.match(/REPORT/) then print_report
    else raise 'Unknown command'
    end
  end

  def move(x, y)
    @x, @y = x, y
  end

  private

  def place(data)
    @direction = data[:direction]
    x, y = data[:x].to_i, data[:y].to_i

    if @tabletop.move(self, x, y)
      @ready = true
    end
  end

  def move_forward
    return unless @ready

    case @direction
    when 'NORTH' then @tabletop.move(self, @x, @y.succ)
    when 'WEST'  then @tabletop.move(self, @x.pred, @y)
    when 'SOUTH' then @tabletop.move(self, @x, @y.pred)
    when 'EAST'  then @tabletop.move(self, @x.succ, @y)
    end
  end

  def turn_left
    return unless @ready

    case @direction
    when 'NORTH' then @direction = 'WEST'
    when 'WEST'  then @direction = 'SOUTH'
    when 'SOUTH' then @direction = 'EAST'
    when 'EAST'  then @direction = 'NORTH'
    end
  end

  def turn_right
    return unless @ready

    case @direction
    when 'NORTH' then @direction = 'EAST'
    when 'EAST'  then @direction = 'SOUTH'
    when 'SOUTH' then @direction = 'WEST'
    when 'WEST'  then @direction = 'NORTH'
    end
  end

  def print_report
    if @ready
      [@x, @y, @direction].join(',')
    else
      'PLACE command has not been executed yet'
    end
  end
end
