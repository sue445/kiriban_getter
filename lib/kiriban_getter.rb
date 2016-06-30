require "kiriban_getter/version"

module KiribanGetter
  refine Integer do
    def kuraiban?
      num = self.abs
      return false if num < 10

      i = 10 ** (digit - 1)
      num % i == 0
    end
    alias_method :zeroban?, :kuraiban?

    def zorome?
      num = self.abs
      return false if num < 10

      # generate number which all digit is 1
      zorome1 = digit.times.inject(0) { |n| n * 10 + 1 }
      num % zorome1 == 0
    end

    alias_method :repdigit?, :zorome?
    alias_method :monodigit?, :zorome?

    def digit
      Math.log10(self.abs).to_i + 1
    rescue FloatDomainError
      # Math.log10(0).to_i
      # #=> FloatDomainError: -Infinity
      1
    end

    def kiriban?
      kuraiban? || zorome?
    end
  end
end
