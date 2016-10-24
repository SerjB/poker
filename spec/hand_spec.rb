require_relative '../lib/deck.rb'

describe Hand do
  describe '.one_pair' do
    context 'Given AD, AS' do
      it 'return true' do
        a = Hand.new([Card.new('A', 'D'), Card.new('A', 'S')])
        expect(a.one_pair).to eql(true)
      end
    end
    context 'Given AD, KS' do
      it 'return false' do
        a = Hand.new([Card.new('A', 'D'), Card.new('K', 'S')])
        expect(a.one_pair).to eql(false)
      end
    end
  end

  describe '.two_pairs' do
    context 'Given AD, AS, KS, KD' do
      it 'return true' do
        a = Hand.new([Card.new('A', 'D'), Card.new('A', 'S'),
                      Card.new('K', 'S'), Card.new('K', 'D')])
        expect(a.two_pairs).to eql(true)
      end
    end
    context 'Given AD, KS, KD, QS' do
      it 'return false' do
        a = Hand.new([Card.new('A', 'D'), Card.new('K', 'S'),
                      Card.new('Q', 'S'), Card.new('K', 'D')])
        expect(a.two_pairs).to eql(false)
      end
    end
  end

  describe '.three_of_a_kind' do
    context 'Given AD, AS, AC' do
      it 'return true' do
        a = Hand.new([Card.new('A', 'D'), Card.new('A', 'S'),
                      Card.new('A', 'C')])
        expect(a.three_of_a_kind).to eql(true)
      end
    end
    context 'Given AD, KS, KD' do
      it 'return false' do
        a = Hand.new([Card.new('A', 'D'), Card.new('K', 'S'),
                      Card.new('K', 'D')])
        expect(a.three_of_a_kind).to eql(false)
      end
    end
  end

  describe '.straight' do
    context 'Given AH, JD, QC, KS, 10S, 2C, 2D' do
      it 'return true' do
        a = Hand.new([Card.new('A', 'H'), Card.new('K', 'S'),
                      Card.new('Q', 'C'), Card.new('J', 'D'),
                      Card.new('10', 'S'), Card.new('2', 'C'),
                      Card.new('2', 'D')])
        expect(a.straight).to eql(true)
      end
    end
    context 'Given AD, AS, AC, KS, QD' do
      it 'return false' do
        a = Hand.new([Card.new('A', 'H'), Card.new('K', 'S'),
                      Card.new('Q', 'C'), Card.new('J', 'D'),
                      Card.new('9', 'S'), Card.new('2', 'C'),
                      Card.new('2', 'D')])
        expect(a.straight).to eql(false)
      end
    end
  end

  describe '.flash' do
    context 'Given AD, 2D, JD, 10D, KD' do
      it 'return true' do
        a = Hand.new([Card.new('A', 'D'), Card.new('10', 'D'),
                      Card.new('2', 'D'), Card.new('K', 'D'),
                      Card.new('J', 'D')])
        expect(a.flash).to eql(true)
      end
    end
    context 'Given AD, QD, KD, 10S, 2C' do
      it 'return false' do
        a = Hand.new([Card.new('A', 'D'), Card.new('10', 'S'),
                      Card.new('2', 'C'), Card.new('K', 'D'),
                      Card.new('Q', 'D')])
        expect(a.flash).to eql(false)
      end
    end
  end

  describe '.full_house' do
    context 'Given AD, AS, AC, KS, KD' do
      it 'return true' do
        a = Hand.new([Card.new('A', 'D'), Card.new('A', 'S'),
                      Card.new('A', 'C'), Card.new('K', 'S'),
                      Card.new('K', 'D')])
        expect(a.full_house).to eql(true)
      end
    end
    context 'Given AD, AS, AC, KS, QD' do
      it 'return false' do
        a = Hand.new([Card.new('A', 'D'), Card.new('A', 'S'),
                      Card.new('A', 'C'), Card.new('K', 'S'),
                      Card.new('Q', 'D')])
        expect(a.full_house).to eql(false)
      end
    end
  end

  describe '.four_of_a_kind' do
    context 'Given AD, AS, AC, AH, KD' do
      it 'return true' do
        a = Hand.new([Card.new('A', 'D'), Card.new('A', 'S'),
                      Card.new('A', 'C'), Card.new('A', 'H'),
                      Card.new('K', 'D')])
        expect(a.four_of_a_kind).to eql(true)
      end
    end
    context 'Given AD, AS, AC, KS, QD' do
      it 'return false' do
        a = Hand.new([Card.new('A', 'D'), Card.new('A', 'S'),
                      Card.new('A', 'C'), Card.new('K', 'S'),
                      Card.new('Q', 'D')])
        expect(a.four_of_a_kind).to eql(false)
      end
    end
  end

  describe '.straight_flush' do
    context 'Given AD, 2D, 3D, 4D, 5D, 6D, 7D' do
      it 'return true' do
        a = Hand.new([Card.new('A', 'D'), Card.new('2', 'D'),
                      Card.new('3', 'D'), Card.new('5', 'D'),
                      Card.new('6', 'D'), Card.new('4', 'D'),
                      Card.new('7', 'D')])
        expect(a.straight_flush).to eql(true)
      end
    end
    context 'Given AD, 2D, 3D, 4D, 5D, 9D, 8D' do
      it 'return false' do
        a = Hand.new([Card.new('A', 'D'), Card.new('2', 'D'),
                      Card.new('3', 'D'), Card.new('5', 'D'),
                      Card.new('9', 'D'), Card.new('4', 'D'),
                      Card.new('8', 'D')])
        expect(a.straight_flush).to eql(false)
      end
    end
  end

  describe '.royal_flush' do
    context 'Given AD, KD, QD, JD, 10D, 3D, 6D' do
      it 'return true' do
        a = Hand.new([Card.new('A', 'D'), Card.new('K', 'D'),
                      Card.new('3', 'D'), Card.new('Q', 'D'),
                      Card.new('6', 'D'), Card.new('J', 'D'),
                      Card.new('10', 'D')])
        expect(a.royal_flush).to eql(true)
      end
    end
    context 'Given AD, 2D, 3D, 4D, 5D, 9D, 8D' do
      it 'return false' do
        a = Hand.new([Card.new('A', 'D'), Card.new('2', 'D'),
                      Card.new('3', 'D'), Card.new('5', 'D'),
                      Card.new('9', 'D'), Card.new('4', 'D'),
                      Card.new('8', 'D')])
        expect(a.royal_flush).to eql(false)
      end
    end
  end
end
