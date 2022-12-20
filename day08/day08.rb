if ARGV.empty?
  data = DATA.readlines
else
  data = File.readlines(ARGV.first)
end

trees = data
  .map(&:chomp)
  .map(&:chars)
  .map { _1.map(&:to_i) }

def check_visible(trees, i, j)
  height = trees[i][j]
  row = trees[i]
  col = trees.transpose[j]
  return 1 if  i == 0 || j == 0 || i == trees.length - 1 || j == trees.length - 1
  return 1 if height > row[0...j].max
  return 1 if height > row[j + 1..-1].max
  return 1 if height > col[0...i].max
  return 1 if height > col[i + 1..-1].max
  0
end
  
def visibility(trees)
  trees.length.times.map do |i|
    trees.first.length.times.map do |j|
      check_visible(trees, i, j)
    end
  end
end

p visibility(trees).flatten.sum

def scenic_score(trees, i, j)
  height = trees[i][j]
  row = trees[i]
  col = trees.transpose[j]
  scores = []

  # LEFT
  score = 0
  (j-1).downto(0).each do |k|
    score += 1
    break if row[k] >= height
  end
  scores << score

  # RIGHT
  score = 0
  (j+1...trees.first.length).each do |k|
    score += 1
    break if row[k] >= height
  end
  scores << score

  # ABOVE
  score = 0
  (i-1).downto(0).each do |k|
    score += 1
    break if col[k] >= height
  end
  scores << score

  # BELOW
  score = 0
  (i+1...trees.length).each do |k|
    score += 1
    break if col[k] >= height
  end
  scores << score

  scores.inject(&:*)
end

def scenic_scores(trees)
  trees.length.times.map do |i|
    trees.first.length.times.map do |j|
      scenic_score(trees, i, j)
    end
  end
end

p "------------ANSWER------------"
p scenic_scores(trees).flatten.max


if ARGV.empty?
  require 'rspec/autorun'
  RSpec.describe 'day08' do
    it 'works for the test case' do
      expect(visibility(trees)).to eq(
        [
          [1, 1, 1, 1, 1],
          [1, 1, 1, 0, 1],
          [1, 1, 0, 1, 1],
          [1, 0, 1, 0, 1],
          [1, 1, 1, 1, 1]
        ]
      )
    end

    it 'works for the scenic test case' do
      expect(scenic_score(trees, 1, 2)).to eq(4)
      expect(scenic_score(trees, 3, 2)).to eq(8)
    end
  end
end

__END__
30373
25512
65332
33549
35390