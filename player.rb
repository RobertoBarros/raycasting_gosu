class Player
  attr_accessor :walk_direction, :turn_direction
  attr_reader :x, :y, :rotation_angle

  RADIUS = 3
  MOVE_SPEED = 2
  ROTATION_SPEED = 3 * (Math::PI / 180)

  def initialize(map)
    @x = map.width / 2
    @y = map.height / 2
    @map = map
    @walk_direction = 0 # -1=back | +1=front
    @turn_direction = 0 # -1=left | +1=right
    @rotation_angle = Math::PI / 2
  end

  def update
    @rotation_angle += @turn_direction * ROTATION_SPEED
    move_step = @walk_direction * MOVE_SPEED
    new_x = @x + Math.cos(@rotation_angle) * move_step
    new_y = @y + Math.sin(@rotation_angle) * move_step
    unless @map.wall?(new_x, new_y)
      @x = new_x
      @y = new_y
    end
  end

  def draw
    Gosu.draw_circle(@x, @y, RADIUS, Gosu::Color::RED.dup)

    Gosu.draw_line(@x,
                   @y,
                   Gosu::Color::RED.dup,
                   @x + (Math.cos(@rotation_angle) * 30),
                   @y + (Math.sin(@rotation_angle) * 30),
                   Gosu::Color::RED.dup)

    # puts "walk direction: #{@walk_direction} - turn direction: #{@turn_direction}"
  end

end