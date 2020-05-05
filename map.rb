class Map
  attr_reader :rows, :cols, :tile_size, :width, :height, :scale

  def initialize(tile_size, scale)
    @grid = [
      [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1],
      [1,0,0,0,0,0,0,0,0,1,0,0,0,0,1],
      [1,0,0,0,0,1,0,0,0,1,1,1,1,0,1],
      [1,0,1,1,1,1,1,0,0,0,0,0,0,0,1],
      [1,0,0,0,0,0,1,0,0,0,1,1,1,0,1],
      [1,0,1,1,1,1,1,0,1,0,0,0,0,0,1],
      [1,0,0,0,0,0,1,0,1,0,1,0,1,0,1],
      [1,0,1,0,0,0,1,0,1,1,0,0,1,0,1],
      [1,0,1,1,1,1,1,0,0,1,0,1,1,0,1],
      [1,0,0,0,0,0,0,0,0,1,0,0,0,0,1],
      [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]].freeze

    @rows = @grid.count
    @cols = @grid.first.count
    @tile_size = tile_size
    @scale = scale
    @width = @cols * @tile_size
    @height = @rows * @tile_size

  end

  def wall?(x, y)
    return true if x <= 0 || x >= @width || y <= 0 || y >= @height

    row = (y / @tile_size).floor
    col = (x / @tile_size).floor
    @grid[row][col] == 1
  end

  def draw
    (0..@rows-1).each do |row|
      (0..@cols-1).each do |col|
        tileX = col * @tile_size
        tileY = row * @tile_size
        color = @grid[row][col] == 0 ? Gosu::Color::WHITE.dup : Gosu::Color::GRAY.dup
        Gosu.draw_rect(@scale * tileX,
                       @scale * tileY,
                       @scale * @tile_size,
                       @scale * @tile_size,
                       color)
      end
    end
  end

end