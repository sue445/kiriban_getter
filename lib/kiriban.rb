require "kiriban/version"

module Kiriban
  refine Integer do
    def kiriban?
      !!(self.to_s =~ /^[1-9]0+$/)
    end
  end
end
