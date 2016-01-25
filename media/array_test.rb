map = File.readlines("map.txt").map {|lines| lines.chomp.split(//)}
print map


map.each_with_index do |value0, key0|
  value0.each_with_index do |value1, key1|
    puts [key0 * 20, key1 * 20]
    end
end
