require 'set'

if ARGV.empty?
  data = DATA.readlines
else
  data = File.readlines(ARGV.first)
end

# PART 1
# p data
#    .map(&:chomp)
#    .map { _1.split(/[,-]/)}
#    .map { _1.map(&:to_i) }
#    .map { _1.each_slice(2).to_a }
#    .map { _1.map { |a, b| (a..b).to_set }}
#    .reduce(0) { |count, (a, b)| a.subset?(b) || b.subset?(a) ? count + 1 : count }

# PART 2
p data
  .map(&:chomp)
  .map { _1.split(/[,-]/)}
  .map { _1.map(&:to_i) }
  .map { _1.each_slice(2).to_a }
  .map { _1.map { |a, b| (a..b).to_set }}
  .reduce(0) { |count, (a, b)| (a & b).any? ? count + 1 : count }

__END__
2-4,6-8
2-3,4-5
5-7,7-9
2-8,3-7
6-6,4-6
2-6,4-8