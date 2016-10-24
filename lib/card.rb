# Generating cards for deck with 2 fields :tunk and :suit
class Card
  attr_accessor :runk,
                :suit

  def initialize(runk, suit)
    @runk = runk
    @suit = suit
  end

  def to_s
    "#{@runk + @suit} "
  end
end
