if ARGV.empty?
  input = <<~INPUT
  498,4 -> 498,6 -> 496,6
  503,4 -> 502,4 -> 502,9 -> 494,9
  INPUT
else
  input = File.read(ARGV[0], chomp: true)
end

lines = input
    .split("\n")
    .map { _1.split(" -> ") }
    .map do |line| 
      line.map do |point| 
        point
          .split(",")
          .map(&:to_i) 
      end
        .each_cons(2)
        .to_a
    end

MARGIN = 10000
def bounds(lines)
  min_r, max_r = lines.flat_map do |line|
    line.flat_map do |segment|
      segment.map(&:first)
    end
  end.minmax

  min_c, max_c = lines.flat_map do |line|
    line.flat_map do |segment|
      segment.map(&:last)
    end
  end.minmax

  [min_r - MARGIN, max_r + MARGIN, 0, max_c + 2]
end

def lines_to_grid(lines, bounds)
  min_r, max_r, min_c, max_c = bounds
  grid = Array.new(max_c - min_c + 1) { Array.new(max_r - min_r + 1, ".") }
  lines.each do |line|
    line.each do |segment|
      start, finish = segment.sort
      start_r, start_c = start
      finish_r, finish_c = finish
      (start_r..finish_r).each do |r|
        (start_c..finish_c).each do |c|
          grid[c - min_c][r - min_r] = "#"
        end
      end
    end
  end

  grid[-1] = Array.new(max_r - min_r + 1, "#")
  grid
end

def pour_sand(bounds, grid, entry)
  min_r, max_r, min_c, max_c = bounds
  r, c = entry

  rest = false
  while !rest
    if !r.between?(min_r, max_r)
      throw :done
    end
    if grid[c + 1 - min_c][r - min_r] == "."
      c += 1
    elsif grid[c + 1 - min_c][r - min_r] == "o" || grid[c + 1 - min_c][r - min_r] == "#"
      if grid[c + 1 - min_c][r - 1 - min_r] == "."
        r -= 1
        c += 1
      elsif grid[c + 1 - min_c][r + 1 - min_r] == "."
        r += 1
        c += 1
      else
        rest = true
      end
    end
  end
  grid[c - min_c][r - min_r] = 'o'

  throw :done if [r, c] == entry
  grid
end

def display(grid)
  puts
  grid.each do |row|
    puts row.join
  end
end

b = bounds(lines)
grid = lines_to_grid(lines, b)
count = 0

catch :done do
  while true
    pour_sand(b, grid, [500, 0])
    count += 1
    p count
  end
end
p count
