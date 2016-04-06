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
    @player = Player.new(0, 0)
    @tru_false = Gosu::Font.new(20)
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
  attr_accessor :array
  def initialize(file)
    raw_map = File.readlines(file).map {|lines| lines.chomp.split(//)}
    self.array = []
    raw_map.each_with_index do |value0, index0|
      value0.each_with_index do |value1, index1|
        if value1 == "#"
          self.array << {:x => index1 * 20, :y => index0 *20}
        end
      end
    end
  end

  def solid?(x, y)
    tru_false = false
    @array.each do |item|
      if (item[:x]/20 == x/20 && item[:y]/20 == y/20)
        tru_false = true
    elsif x + 20 == 660
      tru_false = true
    elsif x - 20 == -40
      tru_false = true
    elsif y - 20 == -40
      tru_false = true
    elsif y + 20 == 500
      tru_false = true
    else
      tru_false = false
    end
    end
    return tru_false
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
window = GameWindow.new
window.show
