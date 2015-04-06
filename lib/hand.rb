require_relative 'deck'

class Hand

  HAND_RANKS = [
    :straight_flush,
    :four_of_a_kind,
    :full_house,
    :flush,
    :straight,
    :three_of_a_kind,
    :two_pair,
    :pair,
    :high_card
  ]

  attr_reader :cards

  def self.deal_hand(deck)
    Hand.new(deck.deal(5), deck)
  end

  def initialize(cards)
    @deck = deck
    @cards = cards
  end

  def swap(card_indices)
    raise "You cannot swap more than 3 cards." if card_indices.count > 3
    discard(card_indices)
    replace(card_indices.count)
    cards.compact!
  end

  def replace(number)
    cards.concat(@deck.deal(number))
  end

  def discard(card_indices)
    discarded_cards = []
    card_indices.each do |index|
      discarded_cards << cards[index]
      cards[index] = nil
    end
    discarded_cards
  end

  def card_count
    counts = Hash.new(0)
    cards.each do |card|
      counts[card.poker_value] += 1
    end

    counts
  end

  def straight
    values = []
    cards.each do |card|
      values << card.poker_value
    end
    values.sort!

    if values == values.uniq && values.last - values.first == 4
      values.max
    else
      nil
    end

  end

  def flush
    suits = []
    values = []
    cards.each do |card|
      suits << card.suit
      values << card.poker_value
    end

    if suits.uniq.count == 1
      values.max
    else
      nil
    end
  end

  def straight_flush
    if straight && flush
      straight
    else
      nil
    end
  end

  def pair
    card_count.key(2)
  end

  def two_pair
    pair_vals = []
    card_count.each do |value, number|
      pair_vals << value if number == 2
    end

    if pair_vals.count == 2
      pair_vals.max
    else
      nil
    end
  end

  def three_of_a_kind
    card_count.key(3)
  end

  def full_house
    if pair && three_of_a_kind
      three_of_a_kind
    else
      nil
    end
  end

  def four_of_a_kind
    card_count.key(4)
  end

  def high_card
    values = []
    cards.each do |card|
      values << card.poker_value
    end

    values.max
  end


  def rank_hand
    HAND_RANKS.each_with_index do |rank, index|
      if self.send(rank)
        return [index, self.send(rank)]
      end
    end
  end

  def compare_hand(other_hand)
    if self.rank_hand.first < other_hand.rank_hand.first
      return :win
    elsif self.rank_hand.first > other_hand.rank_hand.first
      return :lose
    else
      if self.rank_hand.first > other_hand.rank_hand.first
        return :win
      elsif self.rank_hand.first < other_hand.rank_hand.first
        return :lose
      else
        return :tie
      end
    end
  end
end
