# frozen_string_literal: true

input_string = "L68
L30
R48
L5
R60
L55
L1
L99
R14
L82"

File.open 'input/day01.txt' do |puzzle_in|
  input_string = puzzle_in.read
end

rotation_strings = input_string.split("\n")
rotations = rotation_strings.collect { |s| [s[0] == 'L' ? -1 : 1, s[1..].to_i] }
# loop with increment on 0 would suffice, no need to keep positions
part1_counter = 0
part2_counter = 0
positions = rotations.reduce([50]) do |positions, rotation|
  new_position_absolute = positions.last + rotation.reduce(:*)
  part2_counter += new_position_absolute.abs / 100
  if new_position_absolute <= 0 && positions.last != 0
    part2_counter += 1
  end
  part1_counter += 1 if new_position_absolute % 100 == 0
  positions << new_position_absolute % 100
end
puts part1_counter
puts part2_counter
