# data = DATA.readlines

data = File.readlines(ARGV.first)

p "Challenge 1"
p data
  .map(&:chomp)
  .chunk_while { |a, b| b != "" }.to_a
  .map{ |a| a.map(&:to_i) }
  .map(&:sum)
  .max

p "Challenge 2"
p data
  .map(&:chomp)
  .chunk_while { |a, b| b != "" }.to_a
  .map{ |a| a.map(&:to_i) }
  .map(&:sum)
  .max(3)
  .sum


__END__
1000
2000
3000

4000

5000
6000

7000
8000
9000

10000