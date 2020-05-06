class Wall3d

  def initialize(rays_count, rays, map, player, wall_strip)
    @rays_count = rays_count
    @rays = rays
    @map = map
    @player = player
    @wall_strip = wall_strip
    @texture = Texture.new(@map.tile_size)
  end

  def draw
    (0..@rays_count - 1).each do |column|
      ray = @rays[column]

      # fix fish-eye effect
      ray_distance = ray.distance * Math.cos(ray.angle - @player.rotation_angle)

      projection_distance = (@map.width / 2) / Math.tan(Ray::FOV)
      wall_height =(@map.tile_size / ray_distance) * projection_distance

      color_tone = case ray.color
                   when 1 then [139, 195, 74] # green
                   when 2 then [103, 58, 183] # purple
                   when 3 then [255, 152, 0 ] # orange
                   else        [0,   0,   0 ] # black
                   end

      color_value =  ray.vertical_hit? ? color_tone.map {|c| c - ( c * 0.2)} : color_tone

      color = Gosu::Color.new(255, color_value[0], color_value[1], color_value[2])

      # Gosu.draw_rect(column * @wall_strip,
      #                (@map.width / 2) - (wall_height / 2),
      #                @wall_strip,
      #                wall_height,
      #                color)

      @texture.draw_rect(column * @wall_strip,
                        (@map.width / 2) - (wall_height / 2),
                        @wall_strip,
                        wall_height,
                        ray.vertical_hit?,
                        ray.slice)

    end
  end
end