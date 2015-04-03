require_relative 'card'

class Deck
  attr_reader :cards

  def initialize(cards = nil)
    @cards = cards || generate_full_deck
  end

  def generate_full_deck
    cards = []

    Card.suits.each do |suit|
      Card.values.each do |value|
        cards << Card.new(value,suit)
      end
    end
    cards
  end

  def deal(number)
    @cards.pop(number).reverse
  end

  def add_cards(array)
    array.each do |card|
      @cards.unshift(card)
    end

    nil
  end

end
