# frozen_string_literal: true

input_string = "987654321111111
811111111111119
234234234234278
818181911112111"
File.open 'input/day03.txt' do |puzzle_in|
  input_string = puzzle_in.read
end

lines = input_string.split("\n")
total_joltage = 0
target_length = 12
# Example: 3121910778619
# longest descending subsequence
# replace worse number after [target_len - remainaing_numbers] with better number 
lines.each do |line|
  nums = []
  line.chars.each_with_index do |char, i|
    new_num = char.to_i
    replace_limit = target_length - (line.size - i)
    replace_limit = [replace_limit, 0].max
    lesser = nums.collect { |n| n < new_num }
    if lesser[replace_limit..].any?
      first = replace_limit + lesser[replace_limit..].index(true)
      nums = nums[...first] + [new_num]
    elsif nums.size < target_length
      nums << new_num
    end
  end
  total_joltage += nums.join.to_i
end
puts total_joltage
