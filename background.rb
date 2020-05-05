class Background
  def initialize(map)
    @map = map
  end

  def draw
    Gosu.draw_rect(0,0, @map.width, 0.7 * @map.height, Gosu::Color.new(255,100,150,230))
    Gosu.draw_rect(0, 0.7 * @map.height, @map.width, @map.height, Gosu::Color.new(255,230,150,100))
  end
end