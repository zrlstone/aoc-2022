if ARGV.empty?
  data = DATA.readlines(chomp: true)
else
  data = File.readlines(ARGV[0], chomp: true)
end

grid = data.map(&:chars)
heights = Array.new(grid.size) { Array.new(grid[0].size) }
distances = {}
neighbours = []
e = nil

grid.each_with_index do |row, x|
  row.each_with_index do |cell, y|
    if cell == 'S' || cell == 'a'
      heights[x][y] = 1
      distances[[x, y]] = 0
      neighbours << [x, y]
    elsif cell == 'E'
      heights[x][y] = 26
      e = [x, y]
    else 
      heights[x][y] = cell.ord - 'a'.ord + 1
    end
  end
end

until neighbours.empty?
  x, y = neighbours.shift
  distance = distances[[x, y]]

  [[0, 1], [0, -1], [1, 0], [-1, 0]].each do |dx, dy|
    nx, ny = x + dx, y + dy
    if nx.between?(0, grid.size - 1) && ny.between?(0, grid[0].size - 1) &&
      heights[nx][ny] <= heights[x][y] + 1

      if distances[[nx, ny]].nil? || distances[[nx, ny]] > distance + 1
        neighbours << [nx, ny]
        distances[[nx, ny]] = distance + 1
      end
    end
  end
end

p distances[e]

__END__
Sabqponm
abcryxxl
accszExk
acctuvwj
abdefghi