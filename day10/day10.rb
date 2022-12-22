if ARGV.empty?
  data = DATA.readlines(chomp: true)
else
  data = File.readlines(ARGV[0], chomp: true)
end

cycles = 0
x = 1
cycle_tracker = {}

data
  .map(&:split)
  .map { |op, arg| [op, arg.to_i] }
  .each do |cmd, arg|
    case cmd
    when 'addx'
      cycles += 1
      cycle_tracker[cycles] = x # x cycles

      cycles += 1
      cycle_tracker[cycles] = x # x cycles


      x += arg
    when 'noop'
      cycles += 1
      cycle_tracker[cycles] = x # x cycles
    else
      raise "unknown command: #{cmd}"
    end
  end

# PART 1
e = Enumerator.produce(20) { |prev| prev + 40 }
p e.take(6).map { |n| cycle_tracker[n] }.sum

# PART 2
cycle_tracker.each do |cycle, x|
  column = (cycle - 1) % 40
  puts if column == 0
  if column.between?(x -1, x + 1)
    print '#'
  else
    print '.'
  end
end


__END__
addx 15
addx -11
addx 6
addx -3
addx 5
addx -1
addx -8
addx 13
addx 4
noop
addx -1
addx 5
addx -1
addx 5
addx -1
addx 5
addx -1
addx 5
addx -1
addx -35
addx 1
addx 24
addx -19
addx 1
addx 16
addx -11
noop
noop
addx 21
addx -15
noop
noop
addx -3
addx 9
addx 1
addx -3
addx 8
addx 1
addx 5
noop
noop
noop
noop
noop
addx -36
noop
addx 1
addx 7
noop
noop
noop
addx 2
addx 6
noop
noop
noop
noop
noop
addx 1
noop
noop
addx 7
addx 1
noop
addx -13
addx 13
addx 7
noop
addx 1
addx -33
noop
noop
noop
addx 2
noop
noop
noop
addx 8
noop
addx -1
addx 2
addx 1
noop
addx 17
addx -9
addx 1
addx 1
addx -3
addx 11
noop
noop
addx 1
noop
addx 1
noop
noop
addx -13
addx -19
addx 1
addx 3
addx 26
addx -30
addx 12
addx -1
addx 3
addx 1
noop
noop
noop
addx -9
addx 18
addx 1
addx 2
noop
noop
addx 9
noop
noop
noop
addx -1
addx 2
addx -37
addx 1
addx 3
noop
addx 15
addx -21
addx 22
addx -6
addx 1
noop
addx 2
addx 1
noop
addx -10
noop
noop
addx 20
addx 1
addx 2
addx 2
addx -6
addx -11
noop
noop
noop