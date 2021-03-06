#!/usr/bin/env ruby
require 'gosu'
require_relative 'circle'
require_relative 'map'
require_relative 'player'
require_relative 'ray'
require_relative 'wall_3d'
require_relative 'background'
require_relative 'texture'

class RayCasting < Gosu::Window
  WALL_STRIP = 1
  MINIMAP_SCALE = 0.2
  TILE_SIZE = 64

  def initialize
    @map = Map.new(TILE_SIZE, MINIMAP_SCALE)
    @player = Player.new(@map)
    @background = Background.new(@map)

    super @map.width, @map.height
    self.caption = "Ray Casting Game"

    @rays_count = @map.width / WALL_STRIP

    @rays = []
    @texture = Texture.new(TILE_SIZE)
  end

  def update
    @player.turn_direction = button_down?(Gosu::KB_RIGHT) ? 1 : (button_down?(Gosu::KB_LEFT) ? -1 : 0)
    @player.walk_direction = button_down?(Gosu::KB_UP) ? 1 : (button_down?(Gosu::KB_DOWN) ? -1 : 0)

    @player.update
    @rays = Ray.cast_all(@player, @map, @rays_count)
    @wall_3d = Wall3d.new(@rays_count, @rays, @map, @player, WALL_STRIP)
  end

  def draw
    @background.draw
    @wall_3d.draw
    draw_minimap

    # (0..300).each do |slice|
    #   x = slice * (420/TILE_SIZE)
    #   width = 420/TILE_SIZE
    #   height = 420
    #   puts "x=#{x} | width=#{width} | height=#{height}"
    #   @texture.draw_rect(x, 0, width, height, false, slice)
    # end
  end

  def draw_minimap
    @map.draw
    @player.draw
    @rays.each(&:draw)
  end
end

RayCasting.new.show
