# frozen_string_literal: true

input_string = "..@@.@@@@.
@@@.@.@.@@
@@@@@.@.@@
@.@@@@..@.
@@.@@@@.@@
.@@@@@@@.@
.@.@.@.@@@
@.@@@.@@@@
.@@@@@@@@.
@.@.@@@.@."

File.open 'input/day04.txt' do |puzzle_in|
  input_string = puzzle_in.read
end

input_grid = input_string.split("\n").collect(&:chars)

def neighbors(x, y, grid)
  adjacents = []
  [-1, 0, 1].each do |x_offset|
    [-1, 0, 1].each do |y_offset|
      next if x_offset == 0 && y_offset == 0
      check_x = x + x_offset
      check_y = y + y_offset
      next if check_x < 0 || check_y < 0
      next if check_x >= grid[0].size || check_y >= grid.size
      if grid[check_y][check_x] == "@"
        adjacents << [check_x, check_y]
      end
    end
  end
  adjacents
end

def removables!(grid, recurse=true)
  accessibles = []
  to_check = Set.new
  grid.size.times do |row_index|
    grid[row_index].size.times do |col_index|
      next if grid[row_index][col_index] == '.'
      to_check << [col_index, row_index]
    end
  end
  while to_check.any?
    x, y = to_check.first
    to_check.delete([x, y])
    adjacents = neighbors(x, y, grid)
    if adjacents.count < 4
      accessibles << [x, y]
      if recurse
        remove!(x, y, grid) 
        to_check += adjacents
      end
    end
  end

  accessibles
end

def remove!(x, y, grid)
  grid[y][x] = '.'
end

puts removables!(input_grid, false).count
puts removables!(input_grid).count
