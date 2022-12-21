require 'set'

def parse_moves(input)
  input
    .map(&:chomp)
    .map {_1.split(' ')}
    .map {[_1[0], _1[1].to_i]}
end

def move(visited, rope, direction, distance)
  head, *tail = rope
  distance.times do
    case direction
    when 'U' then head[1] += 1
    when 'D' then head[1] -= 1
    when 'L' then head[0] -= 1
    when 'R' then head[0] += 1
    end

    rope.each_cons(2) do |h, t|
      follow(h, t)
    end
    visited << rope.last.dup
  end
  rope
end

def follow(head, tail)
  if head[0] != tail[0] &&
      head[1] != tail[1] &&
      ((head[0] - tail[0]).abs > 1 ||
       (head[1] - tail[1]).abs > 1)
    tail[0] += head[0] <=> tail[0]
    tail[1] += head[1] <=> tail[1]
  elsif (head[0] - tail[0]).abs > 1
    tail[0] += head[0] <=> tail[0]
  elsif (head[1] - tail[1]).abs > 1
    tail[1] += head[1] <=> tail[1]
  end
end


if ARGV.empty?
  require 'rspec/autorun'
  
  RSpec.describe 'day09' do
    before(:all) do
      @moves = DATA.readlines
    end
    
    it 'parses input' do
      expect(parse_moves(@moves)).to eq([
        ['R', 4],
        ['U', 4],
        ['L', 3],
        ['D', 1],
        ['R', 4],
        ['D', 1],
        ['L', 5],
        ['R', 2]
        ])
    end

    it 'moves the head and tail in one direction' do
      visited = Set.new

      expect(move(visited, [[0, 0], [0, 0]], 'U', 5)).to eql([[0, 5], [0, 4]])
      expect(move(visited, [[0, 0], [0, 0]], 'D', 5)).to eql([[0, -5], [0, -4]])
      expect(move(visited, [[0, 0], [0, 0]], 'L', 5)).to eql([[-5, 0], [-4, 0]])
      expect(move(visited, [[0, 0], [0, 0]], 'R', 5)).to eql([[5, 0], [4, 0]])
    end


    it 'moves the head and tail diagonally' do
      visited = Set.new
      expect(move(visited, [[1, 1], [0, 0]], 'U', 1)).to eql([[1, 2], [1, 1]])
      expect(move(visited, [[-1, -1], [0, 0]], 'D', 1)).to eql([[-1, -2], [-1, -1]])
      expect(move(visited, [[-1, 1], [0, 0]], 'L', 1)).to eql([[-2, 1], [-1, 1]])
      expect(move(visited, [[1, 1], [0, 0]], 'R', 1)).to eql([[2, 1], [1, 1]])
    end

    it 'works with the example' do
      head = [0, 0]
      tail = [0, 0]
      visited = Set.new
      parse_moves(@moves).each do |(dir, distance)|
        head, tail = move(visited, [head, tail], dir, distance)
      end
      expect(visited.length).to eq(13)
    end
  end
else
  visited = Set.new
  rope = Array.new(10) { Array.new(2) { 0 } }
  moves = parse_moves(File.readlines(ARGV.first))
  moves.each do |(dir, distance)|
    rope = move(visited, rope, dir, distance)
  end
  p visited.length
end


__END__
R 4
U 4
L 3
D 1
R 4
D 1
L 5
R 2