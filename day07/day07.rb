if ARGV.empty?
  data = DATA.readlines
else
  data = File.readlines(ARGV.first)
end

cwd = []
dir_sizes = Hash.new { |h, k| h[k] = 0 }
data
  .map(&:chomp)
  .map { _1.split(' ') }
  .each do |line|
    case line
    in ['$', 'cd', '..']
      cwd.pop
    in ['$', 'cd', dir]
      cwd << dir
    in ['$', 'ls']
    in ['dir', dirname]
    in [size, filename]
      cwd.length.times do |x|
        dir_sizes[cwd[0..x]] += size.to_i
      end
    end
  end

# PART 1
p dir_sizes
    .inject(0) { |sum, (dir, size)| size <= 100000 ? sum + size : sum }

# PART 2
unused_space = 70000000 - dir_sizes[["/"]]
p space_needed = 30000000 - unused_space
p dir_sizes.sort_by { |k, v| v }.detect { _2 > space_needed}


__END__
$ cd /
$ ls
dir a
14848514 b.txt
8504156 c.dat
dir d
$ cd a
$ ls
dir e
29116 f
2557 g
62596 h.lst
$ cd e
$ ls
584 i
$ cd ..
$ cd ..
$ cd d
$ ls
4060174 j
8033020 d.log
5626152 d.ext
7214296 k