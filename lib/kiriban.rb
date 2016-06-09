require "kiriban/version"

module Kiriban
  refine Integer do
    def kiriban?
      !!(self.abs.to_s =~ /^[1-9]0+$/)
    end

    def zorome?
      return false if self.abs < 10
      self.abs.to_s.each_char.map(&:itself).uniq.count == 1
    end
  end
end
