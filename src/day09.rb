# frozen_string_literal: true

input_string = "7,1
11,1
11,7
9,7
9,5
2,5
2,3
7,3"

File.open 'input/day09.txt' do |puzzle_in|
  input_string = puzzle_in.read
end

orig_corners = input_string.split("\n").collect do |s|
  s.split(',').collect(&:to_i)
end


def within(x,y, x1, y1, x2, y2)
  min_x, min_y = [x1, x2].min, [y1, y2].min
  max_x, max_y = [x1, x2].max, [y1, y2].max
  return (x <= max_x) && (x => min_x) && (y <= max_y) && (y >= min_y)
end

def area(x1, y1, x2, y2)
  (x1 - x2 + 1).abs * (y1 - y2 + 1).abs
end

corners = orig_corners.dup
max_area = 0
pairs_considered = []
while true do
  new_found = false
  corners.combination(2).each do |(x1,y1), (x2, y2)|
    new_area = area(x1, y1, x2, y2)
    if new_area > max_area
      max_area = new_area
      pairs_considered << [[x1,y1], [x2, y2]]
      corners.reject! do |x,y|
        pairs_considered.any? { |(px1, py1), (px2, py2)| within(x, y, px1, py2, px2, py2) }
      end
      new_found = true
      break
    end
  end
  break unless new_found
end

puts max_area
