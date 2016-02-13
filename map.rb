require 'gosu'
FONT_COLOR = 0xff_ffff00

class GameWindow < Gosu::Window
  def initialize
    super 640, 480
    self.caption = "Rogue"
    raw_map = File.readlines("media/map.txt").map {|lines| lines.chomp.split(//)}
   puts raw_map
   # puts raw_ma"p
    @map_array = []
    raw_map.each_with_index do |value0, index0|
      value0.each_with_index do |value1, index1|
        if value1 == "#"
          @map_array << Map.new((index1 * 20), (index0 * 20)) 
        end
      end
    end
  puts @map_array

  end

  def update
  end

  def draw
    @map_array.each do |item|
      item.draw
    end
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
  def initialize

  end

  def draw

  end
end
window = GameWindow.new
window.show
