class Ray

  FOV = 60 * (Math::PI / 180)

  def initialize(x, y, angle)
    @angle = angle
    @x = x
    @y = y
  end

  def draw
    Gosu.draw_line(@x,
                   @y,
                   Gosu::Color::BLUE.dup,
                   @x + (Math.cos(@angle) * 30),
                   @y + (Math.sin(@angle) * 30),
                   Gosu::Color::BLUE.dup,)

  end

  def self.cast(player, rays_count)
    angle = player.rotation_angle - (FOV / 2)
    rays = []

    (0..rays_count - 1).each do |column|
      rays << Ray.new(player.x, player.y, angle)


      angle += FOV / rays_count
    end

    rays
  end

end