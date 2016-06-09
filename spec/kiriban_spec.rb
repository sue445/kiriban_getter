describe Kiriban do
  describe "#kiriban?" do
    subject { number.kiriban? }

    using Kiriban
    using RSpec::Parameterized::TableSyntax

    where(:number, :expected) do
      1    | false
      10   | true
      11   | false
      200  | true
      222  | false
      1122 | false
      3000 | true
    end

    with_them do
      it { should eq expected }
    end
  end
end
