require 'card'

describe Card do
  it "must have a valid value" do
    card = Card.new(:deuce, :clubs)
    expect(card.value).to eq(:deuce)
  end

  it "must have a valid suit" do
    card = Card.new(:deuce, :clubs)
    expect(card.suit).to eq(:clubs)
  end

  it "class gives access to all suits" do
    expect(Card.suits.count).to eq(4)
  end
  it "class gives access to all values" do
    expect(Card.values.count).to eq(13)
  end
end
