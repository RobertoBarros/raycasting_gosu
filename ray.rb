class Ray
  FOV = 60 * (Math::PI / 180)
  attr_reader :distance, :angle, :color

  def initialize(player, map, angle)
    @player = player
    @x = player.x
    @y = player.y
    @angle = normalize(angle)
    @map = map
    @tile_size = map.tile_size.to_f
    @facing_down = @angle > 0 && @angle < Math::PI
    @facing_right = @angle < 0.5 * Math::PI || @angle > 1.5 * Math::PI
    @x_wall_hit = 0.0
    @y_wall_hit = 0.0
    @distance = 0
    @vertical_hit = false
    @color = 0
  end

  def vertical_hit?
    @vertical_hit
  end

  private def normalize(angle)
    angle = angle % (2 * Math::PI)
    angle += (2 * Math::PI) if angle < 0
    angle
  end

  private def facing_down?
    @facing_down
  end

  private def facing_up?
    !facing_down?
  end

  private def facing_right?
    @facing_right
  end

  private def facing_left?
    !facing_right?
  end

  private def distance_between_point(x1, y1, x2, y2)
    Math.sqrt(((x2 - x1) ** 2) + ((y2 - y1) ** 2))
  end

  def cast
    #----------------------------------------------------------------------
    #         HORIZONTAL GRID INTERCEPTION
    #----------------------------------------------------------------------
    x_horizontal_wall_hit = 0
    y_horizontal_wall_hit = 0

    # Find the x and y coordenates of first horizontal grid interception
    y_intercept = (@y / @tile_size).floor * @tile_size
    y_intercept += @tile_size if facing_down?

    x_intercept = @x + ((y_intercept - @y) / Math.tan(@angle))

    # Calculate the increment x_step and y_step
    y_step = @tile_size
    y_step = - y_step if facing_up?

    x_step = @tile_size / Math.tan(@angle)
    x_step = - x_step if facing_left? && x_step > 0
    x_step = - x_step if facing_right? && x_step < 0

    next_x_intercept = x_intercept
    next_y_intercept = y_intercept

    found_horizontal_hit = false
    while( next_x_intercept >= 0 && next_x_intercept <= @map.width && next_y_intercept >=0 && next_y_intercept <= @map.height )


      if @map.wall?(next_x_intercept, facing_up? ? next_y_intercept - 1 : next_y_intercept)
        found_horizontal_hit = true
        x_horizontal_wall_hit = next_x_intercept
        y_horizontal_wall_hit = next_y_intercept
        break
      else
        next_x_intercept += x_step
        next_y_intercept += y_step
      end
    end

    #----------------------------------------------------------------------
    #         VERTICAL GRID INTERCEPTION
    #----------------------------------------------------------------------
    x_vertical_wall_hit = 0
    y_vertical_wall_hit = 0

    # Find the x and y coordenates of first vertical grid interception
    x_intercept = (@x / @tile_size).floor * @tile_size
    x_intercept += @tile_size if facing_right?

    y_intercept = @y + ((x_intercept - @x) * Math.tan(@angle))

    # Calculate the increment x_step and y_step
    x_step = @tile_size
    x_step = - x_step if facing_left?

    y_step = @tile_size * Math.tan(@angle)
    y_step = - y_step if facing_up? && y_step > 0
    y_step = - y_step if facing_down? && y_step < 0

    next_x_intercept = x_intercept
    next_y_intercept = y_intercept

    found_vertical_hit = false
    while( next_x_intercept >= 0 && next_x_intercept <= @map.width && next_y_intercept >=0 && next_y_intercept <= @map.height )


      if @map.wall?(facing_left? ? next_x_intercept - 1 : next_x_intercept, next_y_intercept)
        found_vertical_hit = true
        x_vertical_wall_hit = next_x_intercept
        y_vertical_wall_hit = next_y_intercept
        break
      else
        next_x_intercept += x_step
        next_y_intercept += y_step
      end
    end


    #----------------------------------------------------------------------
    #         CALCULATE DISTANCES
    #----------------------------------------------------------------------
    horizontal_distance = found_horizontal_hit ? distance_between_point(@x, @y, x_horizontal_wall_hit, y_horizontal_wall_hit) : Float::INFINITY

    vertical_distance = found_vertical_hit ? distance_between_point(@x, @y, x_vertical_wall_hit, y_vertical_wall_hit) : Float::INFINITY

    # Use the smallest hit distance
    if horizontal_distance < vertical_distance
      @x_wall_hit = x_horizontal_wall_hit
      @y_wall_hit = y_horizontal_wall_hit
      @distance = horizontal_distance
      @vertical_hit = false
      @color = @map.wall_color(@x_wall_hit, facing_up? ? @y_wall_hit - 1 : @y_wall_hit)
    else
      @x_wall_hit = x_vertical_wall_hit
      @y_wall_hit = y_vertical_wall_hit
      @distance = vertical_distance
      @vertical_hit = true
      @color = @map.wall_color(facing_left? ? @x_wall_hit - 1 : @x_wall_hit, @y_wall_hit)
    end

  end

  def draw
    Gosu.draw_line(@map.scale * @x,
                   @map.scale * @y,
                   Gosu::Color::GREEN.dup,
                   @map.scale * @x_wall_hit,
                   @map.scale * @y_wall_hit,
                   Gosu::Color::GREEN.dup,)

  end

  def self.cast_all(player, map, rays_count)
    angle = player.rotation_angle - (FOV / 2)
    rays = []

    rays_count.times do
      ray = Ray.new(player, map, angle)
      ray.cast
      rays << ray
      angle += FOV / rays_count
    end

    rays
  end
end