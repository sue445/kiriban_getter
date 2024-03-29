describe KiribanGetter do
  describe "#kuraiban?" do
    subject { number.kuraiban? }

    using KiribanGetter

    where(:number, :expected) do
      [
        [1,    false],
        [10,   true],
        [11,   false],
        [200,  true],
        [222,  false],
        [1122, false],
        [3000, true],
        [-200, true],
        [-123, false],
      ]
    end

    with_them do
      it { should eq expected }
    end
  end

  describe "#zorome?" do
    subject { number.zorome? }

    using KiribanGetter

    where(:number, :expected) do
      [
        [1 ,   false],
        [10,   false],
        [11,   true],
        [200,  false],
        [222,  true],
        [1122, false],
        [3000, false],
        [-222, true],
        [-100, false],
      ]
    end

    with_them do
      it { should eq expected }
    end
  end

  describe "#digit" do
    subject { number.digit }

    using KiribanGetter

    where(:number, :expected) do
      [
        [0,    1],
        [1,    1],
        [10,   2],
        [11,   2],
        [200,  3],
        [222,  3],
        [1122, 4],
        [3000, 4],
        [-222, 3],
        [-100, 3],
      ]
    end

    with_them do
      it { should eq expected }
    end
  end

  describe "#kiriban?" do
    subject { number.kiriban? }

    using KiribanGetter

    where(:number, :expected) do
      [
        [1,    false],
        [10,   true],
        [11,   true],
        [200,  true],
        [222,  true],
        [1122, false],
        [3000, true],
        [-200, true],
        [-123, false],
        [-333, true],
      ]
    end

    with_them do
      it { should eq expected }
    end
  end
end
