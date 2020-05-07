class Texture
  WIDTH = 128
  HEIGHT = 128
  HORIZONTAL_SCALING = 4

  def initialize(tile_size)
    @tile_size = tile_size

    files = ['wolf1.png', 'wolf2.png', 'wolf3.png']

    slice_width = WIDTH / (@tile_size / HORIZONTAL_SCALING)
    @slices = files.map { |file| Gosu::Image.load_tiles(file, slice_width , HEIGHT, { tileable: true }) }

    @slices_count = WIDTH / slice_width
  end

  def draw_rect(id, x, y, width, height, dark, slice_index)
    index = slice_index % @slices_count
    x1 = x
    y1 = y
    x2 = (x + width)
    y2 = y
    x3 = x
    y3 = y + height
    x4 = (x + width)
    y4 = y + height
    c = dark ? Gosu::Color.new(255, 150, 150, 150) : Gosu::Color.new(255, 255, 255, 255)
    @slices[id][index].draw_as_quad(x1, y1, c, x2, y2, c, x3, y3, c, x4, y4, c, 0)
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