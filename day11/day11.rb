class Monkey
  @monkeys = {}
  attr_reader :test

  def initialize(items, operation, test, success_monkey, failure_monkey)
    @items = items
    @operation = operation
    @test = test
    @success_monkey = success_monkey
    @failure_monkey = failure_monkey
    @inspect_count = 0
  end

  def self.parse(monkey_data)
    n, i, o, t, tr, fa = monkey_data.split("\n")
    name = n.split(/:| /)[1].to_i 
    items = i.split(": ").last.split(", ").map(&:to_i)
    operation = o.split("= ").last
    test = t.split(" ").last.to_i
    success_monkey = tr.split(" ").last.to_i
    failure_monkey = fa.split(" ").last.to_i

    @monkeys[name] = Monkey.new(
      items,
      operation,
      test,
      success_monkey,
      failure_monkey
    )
  end

  def self.all
    @monkeys
  end

  def self.round(n)
    n.times do
      @monkeys.values.each(&:inspect_all)
    end
  end

  def self.most_active
    @monkeys.values.sort_by(&:inspect_count)
  end

  def self.monkey_business
    most_active.last(2).map(&:inspect_count).inject(:*)
  end

  def self.relief
    @monkeys.values.map(&:test).inject(:*)
  end

  def inspect_count
    @inspect_count
  end

  def insp
    @inspect_count += 1
    item = @items.shift
    item = apply_operation(item)
    # item /= 3
    item %= Monkey.relief
    to_monkey = apply_test(item)
    throw_item(to_monkey, item)
  end

  def inspect_all
    while @items.any?
      insp
    end
  end

  def throw_item(monkey, item)
    Monkey.all[monkey].catch_item(item)
  end

  def catch_item(item)
    @items << item
  end

  def apply_operation(old)
    eval(@operation)
  end

  def apply_test(item)
    item % @test == 0 ? @success_monkey : @failure_monkey
  end
end

if ARGV.empty?
  data = DATA.read
else
  data = File.read(ARGV.first)
end

data.split("\n\n").each do |monkey_data|
  Monkey.parse(monkey_data)
end

Monkey.round(10000)
p Monkey.monkey_business

__END__
Monkey 0:
  Starting items: 79, 98
  Operation: new = old * 19
  Test: divisible by 23
    If true: throw to monkey 2
    If false: throw to monkey 3

Monkey 1:
  Starting items: 54, 65, 75, 74
  Operation: new = old + 6
  Test: divisible by 19
    If true: throw to monkey 2
    If false: throw to monkey 0

Monkey 2:
  Starting items: 79, 60, 97
  Operation: new = old * old
  Test: divisible by 13
    If true: throw to monkey 1
    If false: throw to monkey 3

Monkey 3:
  Starting items: 74
  Operation: new = old + 3
  Test: divisible by 17
    If true: throw to monkey 0
    If false: throw to monkey 1