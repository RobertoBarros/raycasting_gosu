class Map
  attr_reader :rows, :cols, :tile_size, :width, :height

  def initialize(tile_size)
    @grid = [
      [1,1,1,1,1,1,0,0,0,0,1,1,1,1,1],
      [1,0,0,0,0,0,0,0,0,0,0,0,0,0,1],
      [1,0,0,0,0,0,0,0,0,1,1,0,0,0,1],
      [0,0,0,1,0,0,0,0,0,1,1,0,0,0,0],
      [0,0,0,1,0,0,0,0,0,0,0,0,0,0,0],
      [0,0,0,1,0,0,0,0,0,0,0,0,0,0,0],
      [0,0,0,1,0,0,0,0,0,0,0,0,0,0,0],
      [1,0,0,1,1,1,1,1,0,0,1,1,1,1,1],
      [1,0,0,0,0,0,0,0,0,0,1,0,0,0,1],
      [1,0,0,0,0,0,0,0,0,0,0,0,0,0,1],
      [1,1,1,1,1,1,0,0,0,0,1,1,1,1,1]].freeze

    @rows = @grid.count
    @cols = @grid.first.count
    @tile_size = tile_size
    @width = @cols * @tile_size
    @height = @rows * @tile_size

  end

  def wall?(x, y)
    return true if x < 0 || x > @width || y < 0 || y > height

    row = (y / @tile_size).floor
    col = (x / @tile_size).floor
    @grid[row][col] == 1
  end

  def draw
    (0..@rows-1).each do |row|
      (0..@cols-1).each do |col|
        tileX = col * @tile_size
        tileY = row * @tile_size
        if @grid[row][col] == 0
          Gosu.draw_rect(tileX, tileY, @tile_size, @tile_size, Gosu::Color::GRAY.dup)
          Gosu.draw_rect(tileX+1, tileY+1, @tile_size-1, @tile_size-1, Gosu::Color::WHITE.dup)
        else
          Gosu.draw_rect(tileX, tileY, @tile_size, @tile_size, Gosu::Color::WHITE.dup)
          Gosu.draw_rect(tileX+1, tileY+1, @tile_size-1, @tile_size-1, Gosu::Color::GRAY.dup)
        end


      end
    end
  end

end