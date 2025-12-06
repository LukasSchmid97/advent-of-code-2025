# frozen_string_literal: true

input_string = "123 328  51 64 
 45 64  387 23 
  6 98  215 314
*   +   *   +  "

File.open 'input/day06.txt' do |puzzle_in|
  input_string = puzzle_in.read
end

lines = input_string.split("\n")
spaced_lines = lines.collect { |l| l.split(" ") }

vertical_maths = spaced_lines.transpose.collect do |*nums, op|
  nums.collect(&:to_i).reduce(op.to_sym)
end

puts vertical_maths.sum

character_lines = lines.collect { |l| l.split("") + [" "] }
_, _, res = character_lines.transpose.reduce([[], nil, 0]) do |(nums, op, sum), entries|
  next [[], nil, sum + nums.reduce(op)] if entries.all? { |s| s == " " }
  *new_digits, new_op = entries
  [[*nums, new_digits.join.to_i], op || new_op, sum]
end

puts res