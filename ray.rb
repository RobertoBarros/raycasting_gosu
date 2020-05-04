class Ray
  FOV = 60 * (Math::PI / 180)

  def initialize(player, map, angle)
    @player = player
    @x = player.x
    @y = player.y
    @angle = normalize(angle)
    @map = map
    @tile_size = map.tile_size.to_f
    @x_wall_hit = 0.0
    @y_wall_hit = 0.0
    @distance = 0
  end

  private def normalize(angle)
    angle = angle % (2 * Math::PI)
    angle += (2 * Math::PI) if angle < 0
    angle
  end

  private def facing_down?
    @angle > 0 && @angle < Math::PI
  end

  private def facing_up?
    !facing_down?
  end

  private def facing_right?
    @angle < 0.5 * Math::PI || @angle > 1.5 * Math::PI
  end

  private def facing_left?
    !facing_right?
  end

  def cast(column)
    #----------------------------------------------------------------------
    #         HORIZONTAL GRID INTERCEPTION
    #----------------------------------------------------------------------

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
    next_y_intercept = facing_up? ? ( y_intercept - 1) : y_intercept

    fount_horizontal_hit = false
    while( next_x_intercept >= 0 && next_x_intercept <= @map.width && next_y_intercept >=0 && next_y_intercept <= @map.height )


      if @map.wall?(next_x_intercept, next_y_intercept)
        fount_horizontal_hit = true
        break
      else
        next_x_intercept += x_step
        next_y_intercept += y_step
      end
    end

    @x_wall_hit = next_x_intercept
    @y_wall_hit = next_y_intercept

    # puts "next_x_intercept=#{next_x_intercept} | next_y_intercept=#{next_y_intercept} | hit=#{fount_horizontal_hit}"
  end

  def draw
    Gosu.draw_line(@x,
                   @y,
                   Gosu::Color::BLUE.dup,
                   @x_wall_hit,
                   @y_wall_hit,
                   Gosu::Color::BLUE.dup,)

  end

  def self.cast_all(player, map, rays_count)
    angle = player.rotation_angle - (FOV / 2)
    rays = []

    # (0..rays_count - 1).each do |column|
    (0..0).each do |column|
      ray = Ray.new(player, map, angle)

      ray.cast(column)

      rays << ray


      angle += FOV / rays_count
    end

    rays
  end

end