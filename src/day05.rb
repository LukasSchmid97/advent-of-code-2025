# frozen_string_literal: true

input_string = "3-5
10-14
16-20
12-18

1
5
8
11
17
32"

File.open 'input/day05.txt' do |puzzle_in|
  input_string = puzzle_in.read
end

ranges_txt, items_txt = input_string.split("\n\n")

ranges = ranges_txt.split("\n").collect do |range_txt|
  start, stop = range_txt.split('-').collect(&:to_i)
  (start..stop)
end.sort_by(&:first) # might need to also sort by last

ranges = ranges.reduce([]) do |range_list, range|
  last = range_list.last
  if last&.cover?(range.begin)
    range_list[-1] = (last.begin..[last.end, range.end].max)
  else
    range_list << range
  end
  range_list
end

items = items_txt.split("\n").collect(&:to_i).sort

count_fresh = 0
id_count = ranges.collect(&:size).sum
cur_range = ranges.shift
cur_item = items.shift
while cur_range && cur_item
  if cur_range.cover?(cur_item)
    count_fresh += 1
    cur_item = items.shift
  elsif cur_item < cur_range.begin
    cur_item = items.shift
  elsif cur_item > cur_range.end
    cur_range = ranges.shift
  end
end
puts count_fresh
puts id_count
