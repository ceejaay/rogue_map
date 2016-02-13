require 'gosu'
FONT_COLOR = 0xff_ffff00

class GameWindow < Gosu::Window
  def initialize
    super 640, 480
    self.caption = "Rogue"
    raw_map = File.readlines("media/map.txt").map {|lines| lines.chomp.split(//)}
    @map_array = []
    raw_map.each_with_index do |value0, index0|
      value0.each_with_index do |value1, index1|
        if value1 == "#"
          @map_array << Map.new((index1 * 20), (index0 * 20))
        end
      end
    end
    @player = Player.new(400, 340)

  end

  def update
    @player.y -= 20
    sleep 1
  end


  def draw
    @map_array.each do |item|
      item.draw
    end
    @player.draw
  end

end

class Map
  attr_accessor :x, :y, :icon, :tile
  def initialize(x, y)
    @x = x
    @y = y
    @icon = icon
    @tile = Gosu::Image.new("media/wall.png")
  end

  def draw
    @tile.draw(@x, @y, 1)
  end
end

class Player
  attr_accessor :x, :y
  def initialize(x, y)
    @image = Gosu::Font.new(20)
    @x = x
    @y = y
  end

  def draw
    @image.draw("@", @x, @y, FONT_COLOR)
  end
end
window = GameWindow.new
window.show
