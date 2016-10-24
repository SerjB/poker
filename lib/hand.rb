require_relative 'card.rb'
#
class Hand
  COMBINATIONS = [:high_card, :one_pair, :two_pairs, :three_of_a_kind,
                  :straight, :flash, :full_house, :four_of_a_kind,
                  :straight_flush, :royal_flush].reverse
  RANKS_STRAIGHT = (('2'..'10').to_a << %w(J Q K A)).flatten
  RANKS_STRAIGHT.unshift('A')

  attr_accessor :cards

  def initialize(cards)
    @combo_win = []
    @cards = cards
  end

  def win_combination
    winning_combination = :high_card
    COMBINATIONS.each do |combination|
      if send(combination)
        winning_combination = combination
        puts @combo_win
        break
      end
      @combo_win = []
    end
    winning_combination
  end

  def high_card
    find_by_card_amount(1)
    true
  end

  def one_pair
    a = find_by_card_amount(2)
    a[:combo_bool]
  end

  def two_pairs
    a = find_by_card_amount(2)
    if a[:combo_bool]
      var = @combo_win
      @cards -= var
      b = find_by_card_amount(2)
      @cards += var
      b[:combo_bool]
    else
      a[:combo_bool]
    end
  end

  def three_of_a_kind
    a = find_by_card_amount(3)
    a[:combo_bool]
  end

  def straight
    RANKS_STRAIGHT.reverse.each do |r|
      if @cards.find_all { |obj| obj.rank == r }.count > 0
        @combo_win += @cards.find_all { |obj| obj.rank == r }.uniq(&:suit)
      else
        @combo_win = []
      end
      return true if @combo_win.size == 5
    end
    false
  end

  def flash
    Deck::AVAILABLE_SUITS.reverse.each do |s|
      if @cards.find_all { |obj| obj.suit == s }.count >= 5
        @combo_win = @cards.find_all { |obj| obj.suit == s }
        return true
      end
    end
    false
  end

  def full_house
    a = find_by_card_amount(3)
    if a[:combo_bool]
      var = @combo_win
      @cards -= var
      b = find_by_card_amount(2)
      @cards += var
      b[:combo_bool]
    else
      a[:combo_bool]
    end
  end

  def four_of_a_kind
    a = find_by_card_amount(4)
    a[:combo_bool]
  end

  def straight_flush
    Deck::AVAILABLE_SUITS.reverse.each do |s|
      @combo_win = []
      RANKS_STRAIGHT.reverse.each do |r|
        if @cards.find_all { |obj| obj.rank == r && obj.suit == s }.count > 0
          @combo_win += @cards.find_all { |obj| obj.rank == r && obj.suit == s }
        else
          @combo_win = []
        end
        return true if @combo_win.size == 5
      end
    end
    false
  end

  def royal_flush
    Deck::AVAILABLE_SUITS.reverse.each do |s|
      @combo_win = []
      Deck::AVAILABLE_RANKS.reverse.each do |r|
        @combo_win += @cards.find_all { |obj| obj.rank == r && obj.suit == s }
        if r == '10'
          @combo_win.size == 5 ? (return true) : break
        end
      end
    end
    false
  end

  def find_by_card_amount(amount)
    Deck::AVAILABLE_RANKS.reverse.each do |r|
      cards = @cards.find_all { |obj| obj.rank == r }
      @combo_win += cards
      return { combo_bool: true, rank: r } if cards.count == amount
      @combo_win -= cards
    end
    { combo_bool: false, rank: nil }
  end
end
