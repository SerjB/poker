# Generating cards for deck with 2 fields :runk and :suit
class Card
  attr_accessor :rank,
                :suit

  def initialize(rank, suit)
    @rank = rank
    @suit = suit
  end

  def to_s
    "#{@rank + @suit} "
  end
end
