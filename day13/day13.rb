def valid(l, r)
  return nil if l.empty? && r.empty?
  return true if l.empty?
  return false if r.empty?

  l_head, *l_tail = l
  r_head, *r_tail = r
  case[l_head, r_head]
  in [Integer, Integer]
    return true if l_head < r_head
    return false if l_head > r_head
  in [Array, Array]
    result = valid(l_head, r_head)
  in [Array, Integer]
    result = valid(l_head, [r_head])
  in [Integer, Array]
    result = valid([l_head], r_head)
  end

  result.nil? ? valid(l_tail, r_tail) : result
end

if ARGV.empty?
  data = DATA.read
else
  data = File.read(ARGV[0])
end

# PART 1
# result = data
#   .split("\n\n")
#   .map { |x| x.split("\n") }
#   .map { _1.map(&method(:eval)) }
#   .each_with_index
#   .inject(0) { |sum, ((a, b), i)| sum + (valid(a, b) ? i + 1 : 0)}

# p result

# PART 2
with_decoder = data
  .split("\n")
  .reject { _1 == '' }
  .map(&method(:eval))
  .push([[2]])
  .push([[6]])
  .sort { |a, b| valid(a, b) ? -1 : 1 }

a = with_decoder.find_index([[2]]) + 1
b = with_decoder.find_index([[6]]) + 1

p a * b

if ARGV.empty?
  require 'rspec/autorun'

  RSpec.describe 'valid' do
    it 'works for the example input' do
      a = [1,1,3,1,1]
      b = [1,1,5,1,1]
      expect(valid(a, b)).to eq(true)

      a = [[1],[2,3,4]]
      b = [[1],4]
      expect(valid(a, b)).to eq(true)

      a = [9]
      b = [[8,7,6]]
      expect(valid(a, b)).to eq(false)

      a = [[4,4],4,4]
      b = [[4,4],4,4,4]
      expect(valid(a, b)).to eq(true)

      a = [7,7,7,7]
      b = [7,7,7]
      expect(valid(a, b)).to eq(false)

      a = []
      b = [3]
      expect(valid(a, b)).to eq(true)

      a = [[[]]]
      b = [[]]
      expect(valid(a, b)).to eq(false)

      a = [1,[2,[3,[4,[5,6,7]]]],8,9]
      b = [1,[2,[3,[4,[5,6,0]]]],8,9]
      expect(valid(a, b)).to eq(false)

    end
  end
end
__END__
[1,1,3,1,1]
[1,1,5,1,1]

[[1],[2,3,4]]
[[1],4]

[9]
[[8,7,6]]

[[4,4],4,4]
[[4,4],4,4,4]

[7,7,7,7]
[7,7,7]

[]
[3]

[[[]]]
[[]]

[1,[2,[3,[4,[5,6,7]]]],8,9]
[1,[2,[3,[4,[5,6,0]]]],8,9]