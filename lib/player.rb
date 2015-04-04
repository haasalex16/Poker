require_relative 'hand'

class Player
  attr_reader :hand, :pot

  def initialize(deck, pot = 100)
    @hand = Hand.deal_hand(deck)
    @pot = pot
  end


end
