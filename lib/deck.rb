require_relative 'card'

class Deck
  attr_reader :deck

  def initialize(cards = Deck.generate_full_deck)
    @deck = cards
  end

  def self.generate_full_deck
    cards = []

    Card.suits.each do |suit|
      Card.values.each do |value|
        cards << Card.new(value,suit)
      end
    end
    cards
  end

  def count
    @deck.count
  end

  def deal(number)
    @deck.pop(number).reverse
  end

  def return(cards)
    cards.each do |card|
      @deck.unshift(card)
    end

    nil
  end

  def shuffle
    raise "Not enough cards in the deck" if count != 52
    @deck.shuffle!
  end

end
