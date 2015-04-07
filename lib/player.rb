require_relative 'hand'

class Player
  attr_reader :pot, :bank, :name
  attr_accessor :hand, :folded

  def initialize(name, deck, pot)
    @name = name
    @hand = nil #Hand.deal_hand(deck)
    @pot = pot
    @bank = 200
    @folded = false
  end

  def discard
    puts "What cards would you like to discard? (up to 3)"
    card_indices = gets.chomp.split(",").map(&:to_i)
  end

  def decide(raise_amt)
    puts "The current raise is $#{raise_amt}"
    puts "Would you like to (f)old, (s)ee, or (r)aise?"
    result = gets.chomp.downcase
  end

  def raise_amount
    puts "How much do you want to raise?"
    result = gets.chomp.to_i
    raise "You do not have that much money" if result > @bank
    result
  end

  def fold
    folded = true
  end

  def display_hand
    cards = ["#{name} has $#{bank} "]
    hand.cards.each do |card|
      cards << card.to_s
    end

    cards.join("|")
  end

  def place_bet(amount)
    @pot += amount
    @bank -= amount
  end

end
