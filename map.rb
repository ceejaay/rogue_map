require 'gosu'
FONT_COLOR = 0xff_ffff00

#what do comments say
class GameWindow < Gosu::Window
  def initialize
    super 640, 480
    self.caption = "Rogue"
    #raw_map = File.readlines("media/text_map.txt").map {|lines| lines.chomp.split(//)}
    @map_array = []
    @player = Player.new(400, 340)
    x = MapMaker.new
    x.square
    @tru_false = Gosu::Font.new(20)
    self.map_convert(x.array)
  end

  def map_convert(map_array)
    map_array.each_with_index do |value0, index0|
      value0.each_with_index do |value1, index1|
        if value1 == "#"
          @map_array << Map.new((index1 * 20), (index0 * 20))
        end
      end
    end
  end

  def update
  end

  def draw
    @map_array.each do |item|
      item.draw
    end
    @player.draw
    #@tru_false.draw(@message, 10, 30, FONT_COLOR)
    #@tru_false.draw("Player x => #{@player.x} Player Y => #{@player.y}", 10, 60, FONT_COLOR)
  end

  def button_down(id)
     future_spot = false
     case id
       when Gosu::KbUp
         @map_array.each {|item| future_spot = true if item.solid?(@player.x, @player.y - 20)}
         @player.up if future_spot == false
       when Gosu::KbDown
         @map_array.each {|item| future_spot = true if item.solid?(@player.x, @player.y + 20)}
         @player.down if future_spot == false
       when Gosu::KbLeft
         @map_array.each {|item| future_spot = true if item.solid?(@player.x - 20, @player.y)}
         @player.west if future_spot == false
       when Gosu::KbRight
         @map_array.each {|item| future_spot = true if item.solid?(@player.x + 20, @player.y)}
         @player.east if future_spot == false
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

  def solid?(x, y)
    if (@x/20 == x/20 && @y/20 == y/20)
      return true
    elsif x + 20 == 660
      return true
    elsif x - 20 == -40
      return true
    elsif y - 20 == -40
      return true
    elsif y + 20 == 500
      return true
    else
      return false
    end
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

  def up
    @y -= 20
  end

  def east
    @x += 20
  end

  def west
    @x -= 20
  end

  def down
    @y += 20
  end

  def draw
    @image.draw("@", @x, @y, FONT_COLOR)
  end
end

class MapMaker
  attr_accessor :array, :x0, :x1, :y0, :y1
  def initialize
    @array
    @x0 = rand(31)
    @x1 = rand(@x0 .. 31)
    @y0 = rand(23)
    @y1 = rand(@y0 .. 23)
    self.array = Array.new(24){Array.new(32) {"#"}}
  end

  def square
    (@y0 .. @y1).to_a.each do |item|
      (@x0 .. @x1).to_a.each do |array_item|
        @array[item][array_item] = " "
      end
    end
  end
end

#this runs the game
window = GameWindow.new
window.show
