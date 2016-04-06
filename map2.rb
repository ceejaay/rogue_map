require 'gosu'
FONT_COLOR = 0xff_ffff00

class GameWindow < Gosu::Window
  def initialize
    super 640, 480
    self.caption = "Rogue"
    @map = Map.new("media/map.txt")
    @player = Player.new(0, 0)
  end

  def update
  end

  def draw
    @map.draw
    @player.draw
  end

  def button_down(id)
    #button down code
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

  def right
    @x += 20
  end

  def left
    @x -= 20
  end

  def down
    @y += 20
  end

  def draw
    @image.draw("@", @x, @y, FONT_COLOR)
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
      item[:sprite].draw(item[:x], item[:y], 1)
    end
  end

  def solid?(x, y)
    tru_false = false
    @array.each do |item|
      #check for solid
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
end


window = GameWindow.new
window.show

