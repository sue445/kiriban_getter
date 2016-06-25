require "benchmark/ips"

def rand_num
  rand(1000000)
end

module KiribanBenchmark
  refine Integer do
    def digit_1
      digit = 1

      num = self.abs
      while num >= 10
        digit += 1
        num /= 10
      end

      digit
    end

    def digit_2
      self.abs.to_s.length
    end

    alias_method :digit, :digit_2

    def kuraiban_1?
      !!(self.abs.to_s =~ /^[1-9]0+$/)
    end

    def kuraiban_2?
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

    # via.
    # * https://github.com/osyo-manga/gem-kiriban/blob/v0.1.0/lib/kiriban/core.rb,
    # * https://github.com/osyo-manga/gem-kiriban/blob/v0.1.0/lib/kiriban/core_ext.rb
    def to_kiriban_array
      to_s.split(//)
    end

    def zeroban? top = 1
      to_kiriban_array.drop(top).all?{ |it| it.to_i == 0 }
    end

    def zoroban?
      to_kiriban_array.uniq.size == 1
    end
  end
end

Benchmark.ips do |x|
  using KiribanBenchmark

  x.config(time: 5, warmup: 2)

  x.report("digit_1 (legacy)") { rand_num.digit_1 }
  x.report("digit_2 (v0.1.0)") { rand_num.digit_2 }

  x.compare!
end

Benchmark.ips do |x|
  using KiribanBenchmark

  x.config(time: 5, warmup: 2)

  x.report("kuraiban_1? (legacy)")   { rand_num.kuraiban_1? }
  x.report("kuraiban_2? (v0.1.0)")   { rand_num.kuraiban_2? }
  x.report("zeroban? (kiriban gem)") { rand_num.zeroban? }

  x.compare!
end

Benchmark.ips do |x|
  using KiribanBenchmark

  x.config(time: 5, warmup: 2)

  x.report("zorome_1? (legacy)")     { rand_num.zorome_1? }
  x.report("zorome_2? (v0.1.0)")     { rand_num.zorome_2? }
  x.report("zoroban? (kiriban gem)") { rand_num.zoroban? }

  x.compare!
end
