class Wall3d

  def initialize(rays_count, rays, map, wall_strip)
    @rays_count = rays_count
    @rays = rays
    @map = map
    @wall_strip = wall_strip
  end

  def draw
    (0..@rays_count - 1).each do |column|
      ray = @rays[column]
      ray_distance = ray.distance
      projection_distance = (@map.width / 2) / Math.tan(Ray::FOV)
      wall_height =(@map.tile_size / ray_distance) * projection_distance

      Gosu.draw_rect(column * @wall_strip,
                     (@map.width / 2) - (wall_height / 2),
                     @wall_strip,
                     wall_height,
                     Gosu::Color::WHITE.dup)
    end
  end
end