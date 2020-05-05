class Wall3d

  def initialize(rays_count, rays, map, player, wall_strip)
    @rays_count = rays_count
    @rays = rays
    @map = map
    @player = player
    @wall_strip = wall_strip
  end

  def draw
    (0..@rays_count - 1).each do |column|
      ray = @rays[column]

      # fix fish-eye effect
      ray_distance = ray.distance * Math.cos(ray.angle - @player.rotation_angle)

      projection_distance = (@map.width / 2) / Math.tan(Ray::FOV)
      wall_height =(@map.tile_size / ray_distance) * projection_distance

      # color = Gosu::Color::WHITE.dup
      alpha = 255 # 200 * (1 - (ray_distance / 500)) + 55

      color = ray.vertical_hit? ? 200 : 255

      Gosu.draw_rect(column * @wall_strip,
                     (@map.width / 2) - (wall_height / 2),
                     @wall_strip,
                     wall_height,
                     Gosu::Color.new(alpha, color, color, color))
    end
  end
end