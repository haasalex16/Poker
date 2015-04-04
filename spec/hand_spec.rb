require 'hand'

describe Hand do
  let(:card1) {Card.new(:deuce, :clubs)}
  let(:card2) {Card.new(:three, :hearts)}
  let(:card3) {Card.new(:king, :diamonds)}
  let(:card4) {Card.new(:ace, :spades)}
  let(:card5) {Card.new(:five, :clubs)}
  let(:card6) {Card.new(:three, :clubs)}
  let(:card7) {Card.new(:four, :hearts)}
  let(:card8) {Card.new(:five, :diamonds)}
  let(:card9) {Card.new(:six, :spades)}
  let(:card10) {Card.new(:seven, :clubs)}
  let(:full_deck) {Deck.new}
  let(:fake_deck) {Deck.new([card7, card6, card1, card2, card3, card4, card5])}
  let(:test_hand) {Hand.deal_hand(fake_deck)}
  let(:test_deck) {double("deck")}



  describe "initialize" do
    it "includes 5 uniqe cards" do
      expect(test_hand.cards.count).to eq(5)
      expect(test_hand.cards).to eq(test_hand.cards.uniq)
    end
  end

  describe "#discard" do
    it "removes identified cards from hand" do
      test_hand.discard([1,3])
      expect(test_hand.cards.include?(card2)).to eq(false)
      expect(test_hand.cards.include?(card4)).to eq(false)
    end
  end

  describe "#swap" do


    it "results in a hand with 5 cards" do
      allow(test_deck).to receive(:deal).with(1) {[card6]}

      test_hand.swap([1])
      expect(test_hand.cards.count).to eq(5)
    end
    it "adds correct cards to the hand" do

      # allow(test_deck).to receive(:deal).with(2) {[card6, card7]}

      test_hand.swap([0,2])
      expect(test_hand.cards.include?(card6)).to eq(true)
      expect(test_hand.cards.include?(card7)).to eq(true)
    end
    it "removes the correct cards from the hand" do
      # allow(test_deck).to receive(:deal).with(2) {[card6, card7]}

      test_hand.swap([0,2])
      expect(test_hand.cards.include?(card5)).to eq(false)
      expect(test_hand.cards.include?(card3)).to eq(false)
    end

    it "cannot swap more than 3 cards" do
      expect do
        test_hand.swap([0,1,2,3])
      end.to raise_error("You cannot swap more than 3 cards.")
    end
  end

  describe "#straight" do
    it "properly indentifies a straight" do
      cards = full_deck.deal(5)
      hand = Hand.new(cards, full_deck)
      expect(hand.straight).to eq(14)
    end
    it "rejects a non-straight" do
      expect(test_hand.straight).to eq(nil)
    end
  end

  describe "#flush" do
    it "properly indentifies a flush" do
      cards = full_deck.deal(5)
      hand = Hand.new(cards, full_deck)
      expect(hand.flush).to eq(14)
    end
    it "rejects a non-flush" do
      expect(test_hand.flush).to eq(nil)
    end
  end

  describe "#card_count" do
    it "properly counts a hand" do
      expected_hash = {
        2 => 1,
        3 => 1,
        13 => 1,
        14 => 1,
        5 => 1
      }
      expect(test_hand.card_count).to eq(expected_hash)
    end
  end

  describe "pairs, three of a kind, full house, four of a kind" do
    it "properly identifies a pair" do
      hand = Hand.new([card5, card6, card7, card8, card9], full_deck)
      expect(hand.pair).to eq(5)
    end
    # it "properly identifies two pair"
    # it "properly identifies three of a kind"
    # it "properly identifies full house"
    # it "properly identifies four of a kind"
  end

  # describe "#compare" do
  #   it "can properly compare itself to another hand"
  #   it "can win"
  #   it "can lose"
  #   it "can draw"
  # end


  describe "returns a rank" do
    it "returns high card" do
      expect(test_hand.rank_hand).to eq([8,14])
    end

    it "returns a pair" do
      hand = Hand.new([card5, card6, card7, card8, card9], full_deck)
      expect(hand.rank_hand).to eq([7,5])
    end

    it "properly ranks straight flush" do
      hand = Hand.deal_hand(full_deck)
      expect(hand.rank_hand).to eq([0,14])
    end

    it "properly picks losing hand" do
      pair = Hand.new([card5, card6, card7, card8, card9], full_deck)
      expect(test_hand.compare_hand(pair)).to eq(:lose)
    end

    it "properly picks a winning hand" do
      royal_flush = Hand.deal_hand(full_deck)
      expect(royal_flush.compare_hand(test_hand)).to eq(:win)
    end

    it "correctly ranks a tie" do
      expect(test_hand.compare_hand(test_hand)).to eq(:tie)
    end

  end

end
