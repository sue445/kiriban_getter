require "benchmark/ips"

def rand_num
  rand(-10_000_000..10_000_000)
end

module KiribanBenchmark
  refine Integer do
    # legacy
    def digit_1
      digit = 1

      num = self.abs
      while num >= 10
        digit += 1
        num /= 10
      end

      digit
    end

    # v0.1.0
    def digit_2
      self.abs.to_s.length
    end

    def digit_3
      return 1 if self.zero?
      Math.log10(self.abs).to_i + 1
    end

    # v0.1.1
    def digit_4
      Math.log10(self.abs).to_i + 1
    rescue FloatDomainError
      # Math.log10(0).to_i
      # #=> FloatDomainError: -Infinity
      1
    end

    if Gem::Version.create(RUBY_VERSION) >= Gem::Version.create("2.4.0")
      # ruby2.4+
      def digit_5
        self.abs.digits.count
      end
    end

    alias_method :digit, :digit_4

    # legacy
    def kuraiban_1?
      !!(self.abs.to_s =~ /^[1-9]0+$/)
    end

    # v0.1.0
    def kuraiban_2?
      num = self.abs
      return false if num < 10

      i = 10 ** (digit - 1)
      num % i == 0
    end

    # legacy
    def zorome_1?
      num = self.abs
      return false if num < 10
      num.to_s.each_char.map(&:itself).uniq.count == 1
    end

    # v0.1.0
    def zorome_2?
      num = self.abs
      return false if num < 10

      # generate number which all digit is 1
      zorome1 = digit.times.inject(0) { |n| n * 10 + 1 }
      num % zorome1 == 0
    end

    if Gem::Version.create(RUBY_VERSION) >= Gem::Version.create("2.4.0")
      def zorome_3?
        self.abs.digits.uniq.count == 1
      end
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

  x.report("digit_1 (legacy)")   { rand_num.digit_1 }
  x.report("digit_2 (v0.1.0)")   { rand_num.digit_2 }
  x.report("digit_3")            { rand_num.digit_3 }
  x.report("digit_4 (v0.1.1)")   { rand_num.digit_4 }
  x.report("digit_5 (ruby2.4+)") { rand_num.digit_5 }

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
  x.report("zorome_3? (ruby2.4+)")   { rand_num.zorome_3? }
  x.report("zoroban? (kiriban gem)") { rand_num.zoroban? }

  x.compare!
end
