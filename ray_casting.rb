#!/usr/bin/env ruby

require 'gosu'
require_relative 'circle'
require_relative 'map'
require_relative 'player'
require_relative 'ray'

class RayCasting < Gosu::Window

  WALL_STRIP = 50

  def initialize

    @map = Map.new(32)

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
    @rays = Ray.cast(@player, @rays_count)
  end

  def draw
    @map.draw
    @player.draw

    @rays.each { |ray| ray.draw  }
  end
end

RayCasting.new.show
