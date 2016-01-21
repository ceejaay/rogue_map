require 'gosu'
FONT_COLOR = 0xff_ffff00

class GameWindow < Gosu::Window
  def initialize
    super 640, 480
    self.caption = "Rogue"
    #raw_map = File.readlines("media/map.txt").map {|lines| lines.split("\n")}
    @map_array = []
      x_y = 0
    10.times do
      @map_array << Map.new(x_y, 0)
      x_y += 20
    end
=begin
    raw_map.each_with_index do |value0, index0|
      value0.each_with_index do |value1, index1|
        @map_array << Map.new((index1 * 20), (index0 * 20), value1)
      end
    end
=end
    @map_array.each {|item| puts "X => #{item.x} Y => #{item.y}"}
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

window = GameWindow.new
window.show
