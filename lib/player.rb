require_relative 'hand'

class Player
  attr_reader :hand, :pot, :bank, :name

  def initialize(name, deck, pot)
    @name = name
    @hand = nil #Hand.deal_hand(deck)
    @pot = pot
    @bank = 200
  end

  def discard
    puts "What cards would you like to discard? (up to 3)"
    card_indices = gets.chomp.split(",").map(&:to_i)
  end

  def decide
    puts "Would you like to (f)old, (s)ee, or (r)aise?"
    result = gets.chomp.downcase
  end

  def raise_amount
    puts "How much do you want to raise?"
    result = gets.chomp.to_i
    raise "You do not have that much money" if result > @bank
    result
  end

end
