require 'gosu'
FONT_COLOR = 0xff_ffff00

class GameWindow < Gosu::Window
  def initialize
    super 640, 480
    self.caption = "Rogue"

    @map = Map.new("media/map.txt")
    #@player = Player.new(0, 0)
  end

  def update
  end

  def draw
    @map.draw
    #draw code
  end

  def button_down(id)
    #button down code
  end
end

class Map
  attr_accessor :array, :sprite
  def initialize(file)
    raw_map = File.readlines(file).map {|lines| lines.chomp.split(//)}
     @sprite = Gosu::Image.new("media/wall.png")
    self.array = []
    raw_map.each_with_index do |value0, index0|
      value0.each_with_index do |value1, index1|
        if value1 == "#"
          self.array << {:x => index1 * 20, :y => index0 * 20, :sprite => @sprite }
        end
      end
    end
  end
  def draw
    @array.each do |item|
      item[:sprite].draw(item[:x], item[:y], 3)
    end
  end
end


window = GameWindow.new
window.show

