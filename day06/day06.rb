require 'rspec/autorun'
require 'set'

def marker_finder(input)
  input
    .chars
    .each_cons(14)
    .map(&:to_set)
    .find_index { |set| set.size == 14 } + 14

    # PART 1
    # .each_cons(4)
    # .map(&:to_set)
    # .find_index { |set| set.size == 4 } + 4
  end

if ARGV.empty?
  RSpec.describe 'Day 6' do
    it 'works for the example cases' do
      expect(marker_finder('mjqjpqmgbljsphdztnvjfqwrcgsmlb')).to eql 7
      expect(marker_finder('bvwbjplbgvbhsrlpgdmjqwftvncz')).to eql 5
      expect(marker_finder('nppdvjthqldpwncqszvftbrmjlhg')).to eql 6
      expect(marker_finder('nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg')).to eql 10
      expect(marker_finder('zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw')).to eql 11
    end
  end
else
  data = File.read(ARGV[0])
  p marker_finder(data)
end