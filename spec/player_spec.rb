require 'player'

describe Player do
  let(:full_deck) {Deck.new}
  let(:player) {Player.new(full_deck, 200)}
  it "must have a hand of 5 cards" do
    expect(player.hand.cards.count).to eq(5)
  end
  it "must have a pot" do
    expect(player.pot).to eq(200)
  end

  it "asks which cards the player wants to discard"
  it "asks if the player wants to fold"
  it "asks if the player wants to see the bet"
  it "asks if the player wants to raise"



end
