#!/usr/bin/env ruby

require 'gosu'
require_relative 'circle'
require_relative 'map'
require_relative 'player'
require_relative 'ray'
require_relative 'wall_3d'

class RayCasting < Gosu::Window

  WALL_STRIP = 1
  MINIMAP_SCALE = 0.2

  def initialize

    @map = Map.new(64, MINIMAP_SCALE)

    @player = Player.new(@map)

    super @map.width, @map.height
    self.caption = "Ray Casting Game"

    @rays_count = @map.width / WALL_STRIP

    @rays = []
  end

  def update
    @player.turn_direction = button_down?(Gosu::KB_RIGHT) ? 1 : (button_down?(Gosu::KB_LEFT) ? -1 : 0)
    @player.walk_direction = button_down?(Gosu::KB_UP) ? 1 : (button_down?(Gosu::KB_DOWN) ? -1 : 0)

    @player.update
    @rays = Ray.cast_all(@player, @map, @rays_count)
    @wall_3d = Wall3d.new(@rays_count, @rays, @map, WALL_STRIP)
  end

  def draw
    @wall_3d.draw
    @map.draw
    @player.draw
    @rays.each { |ray| ray.draw  }
  end
end

RayCasting.new.show
