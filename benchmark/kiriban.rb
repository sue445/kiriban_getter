require "benchmark/ips"

def rand_num
  rand(1000000)
end

module KiribanBenchmark
  refine Integer do
    def digit
      digit = 1

      num = self.abs
      while num >= 10
        digit += 1
        num /= 10
      end

      digit
    end

    def kiriban_1?
      !!(self.abs.to_s =~ /^[1-9]0+$/)
    end

    def kiriban_2?
      num = self.abs
      return false if num < 10

      i = 10 ** (digit - 1)
      num % i == 0
    end

    def zorome_1?
      num = self.abs
      return false if num < 10
      num.to_s.each_char.map(&:itself).uniq.count == 1
    end

    def zorome_2?
      num = self.abs
      return false if num < 10

      # generate number which all digit is 1
      zorome1 = digit.times.inject(0) { |n| n * 10 + 1 }
      num % zorome1 == 0
    end
  end
end

Benchmark.ips do |x|
  using KiribanBenchmark

  x.config(time: 5, warmup: 2)

  x.report("kiriban_1?") { rand_num.kiriban_1? }
  x.report("kiriban_2?") { rand_num.kiriban_2? }

  x.compare!
end

Benchmark.ips do |x|
  using KiribanBenchmark

  x.config(time: 5, warmup: 2)

  x.report("zorome_1?") { rand_num.zorome_1? }
  x.report("zorome_2?") { rand_num.zorome_2? }

  x.compare!
end
