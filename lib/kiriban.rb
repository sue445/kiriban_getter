require "kiriban/version"

module Kiriban
  refine Integer do
    def kiriban?
      !!(self.to_s =~ /^[1-9]0+$/)
    end

    def zorome?
      return false if self < 10
      self.to_s.each_char.map(&:itself).uniq.count == 1
    end
  end
end
