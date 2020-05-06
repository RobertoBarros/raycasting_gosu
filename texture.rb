class Texture
  WIDTH = 420
  HEIGHT = 420
  def initialize(tile_size)
    @tile_size = tile_size
    @wall_slices = Gosu::Image.load_tiles('wall.png', WIDTH/@tile_size, HEIGHT, {tileable: true})
  end

  def draw_rect(x,y,width,height,dark,slice_index)
    x1 = x
    y1 = y
    x2 = x1 + width
    y2 = y
    x3 = x
    y3 = y + height
    x4 = x + width
    y4 = y + height
    c = dark ? Gosu::Color.new(255,130,130,130) : Gosu::Color.new(255,255,255,255)
    @wall_slices[slice_index].draw_as_quad(x1,y1,c,x2,y2,c,x3,y3,c,x4,y4,c,0)
  end

  # def draw
  #   @wall_slices.each_with_index do |slice,index|
  #     x1 = index * (WIDTH/@tile_size)
  #     y1 = 0
  #     x2 = x1 + (WIDTH/@tile_size)
  #     y2 = 0
  #     x3 = index * (WIDTH/@tile_size)
  #     y3 = HEIGHT
  #     x4 = x3 + (WIDTH/@tile_size)
  #     y4 = HEIGHT
  #     c = Gosu::Color::WHITE
  #     slice.draw_as_quad(x1,y1,c,x2,y2,c,x3,y3,c,x4,y4,c,0)
  #   end
  # end
end