require 'rspec/autorun'

def result(them, me)
  me.ord - 87
end

def bonus(them, me)
  case [them, me]
  in ['A', 'Z'] | ['C', 'Y'] | ['B', 'X']
    0
  in ['A', 'X'] | ['B', 'Y'] | ['C', 'Z']
    3
  else
    6
  end
end

def total(them, me)
  result(them, me) + bonus(them, me)
end

def transform(them, outcome)
  case [them, outcome]
    in ['A', 'X'] | ['B', 'Z'] | ['C', 'Y']
      'Z'
    in ['A', 'Y'] | ['B', 'X'] | ['C', 'Z']
      'X'
    in ['A', 'Z'] | ['B', 'Y'] | ['C', 'X']
      'Y'
    end
end

def total2(them, outcome)
  me = transform(them, outcome)
  result(them, me) + bonus(them, me)
end

# RSpec.describe 'RPS' do
#   [
#     ['A', 'Y', 4],
#     ['B', 'X', 1],
#     ['C', 'Z', 7]
#   ].each do |them, me, _total|
#     it 'calculates the score' do
#       expect(total2(them, me)).to eql _total
#     end
#   end

#   [
#     ['A', 'Y', 2, 6, 8],
#     ['B', 'X', 1, 0, 1],
#     ['C', 'Z', 3, 3, 6]
#   ].each do |them, me, _result, _bonus, _total|
#     it 'calculates the score' do
#       expect(result(them, me)).to eql _result
#       expect(bonus(them, me)).to eql _bonus
#       expect(total(them, me)).to eql _total
#     end
#   end
# end

# p File
#    .readlines(ARGV.first)
#    .map(&:chomp)
#    .map { _1.split(' ')}
#    .map { |them, me| total(them, me) }
#    .sum

p File
   .readlines(ARGV.first)
   .map(&:chomp)
   .map { _1.split(' ')}
   .map { |them, me| total2(them, me) }
   .sum