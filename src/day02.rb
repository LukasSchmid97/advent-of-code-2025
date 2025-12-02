# frozen_string_literal: true

input_string = "11-22,95-115,998-1012,1188511880-1188511890,222220-222224,1698522-1698528,446443-446449,38593856-38593862,565653-565659,824824821-824824827,2121212118-2121212124"

File.open 'input/day02.txt' do |puzzle_in|
  input_string = puzzle_in.read
end

ranges = input_string.split(',').collect do |range_txt|
  range_txt.split('-').collect(&:to_i)
end

repeating = []
half_repeating = Set.new
ranges.each do |start, n_end|
  range_repeating = []
  start_length = start.to_s.size
  end_length = n_end.to_s.size
  (1..end_length/2+1).each do |sub_length|
    fst_part_start = start.to_s[...sub_length].to_i
    fst_part_end = n_end.to_s[...sub_length].to_i
    candidates = [*(fst_part_start..fst_part_end), fst_part_start, fst_part_end]
    candidates.each do |fst_part|
      (start_length..end_length).each do |length|
        fst_part_iter = fst_part
        next if length % sub_length != 0 || length / sub_length == 1
        while true do
          new_num = (fst_part_iter.to_s * (length/sub_length)).to_i
          puts "Checking #{new_num}"
          if new_num >= start && new_num <= n_end
            puts "> Recording #{new_num} in [#{start}, #{n_end}]"
            range_repeating << new_num
            half_repeating << new_num if sub_length == length / 2.0
          elsif new_num > n_end
            break
          end
          fst_part_iter += 1
        end
      end
    end
  end
  repeating += range_repeating.uniq
end

puts half_repeating.sum
puts repeating.sum
