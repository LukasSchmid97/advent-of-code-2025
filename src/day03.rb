# frozen_string_literal: true

input_string = "987654321111111
811111111111119
234234234234278
818181911112111"
File.open 'input/day03.txt' do |puzzle_in|
  input_string = puzzle_in.read
end

def get_highest_num(num_string, target_length)
  nums = []
  num_string.chars.each_with_index do |char, i|
    new_num = char.to_i
    replace_limit = target_length - (num_string.size - i)
    replace_limit = [replace_limit, 0].max
    lesser = nums.collect { |n| n < new_num }
    if lesser[replace_limit..].any?
      first = replace_limit + lesser[replace_limit..].index(true)
      nums = nums[...first] + [new_num]
    elsif nums.size < target_length
      nums << new_num
    end
  end
  return nums.join.to_i
end

lines = input_string.split("\n")
total_joltage_part1 = 0
total_joltage_part2 = 0

lines.each do |line|
  joltage_part2 = get_highest_num(line, 12)
  total_joltage_part2 += joltage_part2
  total_joltage_part1 += get_highest_num(joltage_part2.to_s, 2)
end
puts total_joltage_part1
puts total_joltage_part2
