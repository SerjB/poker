require_relative 'hand.rb' # path for app
require_relative 'card.rb'

#
class Deck
  AVAILABLE_RUNKS = (('2'..'10').to_a << %w(J Q K A)).flatten
  AVAILABLE_SUITS = %w(H S C D).freeze

  attr_reader :deck

  def initialize
    @deck = deck_of_cards
  end

  def deck_of_cards
    cards = AVAILABLE_RUNKS.product(AVAILABLE_SUITS).map(&:join).shuffle
    cards = cards.map { |e| Card.new(e[0], e[1]) }
    cards.shuffle
  end

  def start_game
    puts 'Your cards :'
    user_cards = pick_and_remuve_card(2)
    puts user_cards
    puts 'Cards on the dask :'
    desk_cards = pick_and_remuve_card(5)
    puts desk_cards
    puts 'Win combination :'
    puts Hand.new(user_cards + desk_cards).win_combination
  end

  def pick_and_remuve_card(amount)
    picked_cards = @deck.sample(amount)
    @deck -= picked_cards
    picked_cards
  end
end

Deck.new.start_game
