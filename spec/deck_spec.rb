require 'deck'

describe Deck do
  let(:full_deck) {Deck.new}
  let(:card1) {Card.new(:deuce, :clubs)}
  let(:card2) {Card.new(:three, :hearts)}
  let(:card3) {Card.new(:king, :diamonds)}
  let(:test_deck) {Deck.new([card1,card2,card3])}

  it "creates a full deck" do
    expect(full_deck.deck.count).to eq(52)
  end

  it "has 52 unique cards" do
    expect(full_deck.deck).to eq(full_deck.deck.uniq)
  end

  it "deals the top card" do
    expect(test_deck.deal(1)).to eq([card3])
  end

  it "can deal multiple cards" do
    expect(test_deck.deal(2)).to eq([card3,card2])
  end

  it "removes dealt card from deck" do
    test_deck.deal(1)
    expect(test_deck.deck.include?(card3)).to eq(false)
  end

  it "can return cards to the deck" do
    card4 = Card.new(:ace, :spades)
    test_deck.return([card4])
    expect(test_deck.deck.include?(card4)).to eq(true)
  end


end
