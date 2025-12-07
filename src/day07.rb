# frozen_string_literal: true

input_string = ".......S.......
...............
.......^.......
...............
......^.^......
...............
.....^.^.^.....
...............
....^.^...^....
...............
...^.^...^.^...
...............
..^...^.....^..
...............
.^.^.^.^.^...^.
..............."

File.open 'input/day07.txt' do |puzzle_in|
  input_string = puzzle_in.read
end

lines = input_string.split("\n")
start_pos = lines[0].index('S')

beams_at = { start_pos => 1 }
beam_splits = 0

lines.each_with_index do |row, y|
  beams_at.keys.each do |x|
    if row[x] == '^'
      [x - 1, x + 1].each do |new_x|
        beams_at[new_x] ||= 0
        beams_at[new_x] += beams_at[x]
      end
      beams_at.delete(x)
      beam_splits += 1
    end
  end
end

puts beam_splits
puts beams_at.values.sum