class Map
  attr_reader :rows, :cols, :tile_size, :width, :height, :scale

  def initialize(tile_size, scale)

    map = <<-MAP
          111111111111111
          100000000000001
          103333333333301
          100000000030001
          102220222033331
          100000202000001
          102222202222201
          100000000000001
          111010111111101
          200020001000001
          222221111111111
    MAP

    @grid = map.split.map { |x| x.chars.map(&:to_i) }.freeze

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
    @grid[row][col] != 0
  end

  def wall_color(x, y)
    return 0 if x <= 0 || x >= @width || y <= 0 || y >= @height

    row = (y / @tile_size).floor
    col = (x / @tile_size).floor
    @grid[row][col]
  end


  def draw
    (0..@rows-1).each do |row|
      (0..@cols-1).each do |col|
        next unless @grid[row][col] != 0
        tileX = col * @tile_size
        tileY = row * @tile_size
        color = Gosu::Color::GRAY
        Gosu.draw_rect(@scale * tileX,
                       @scale * tileY,
                       @scale * @tile_size,
                       @scale * @tile_size,
                       color)
      end
    end
  end

end