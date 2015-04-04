require 'player'

describe Player do
  let(:full_deck) {Deck.new}
  let(:pot) {300}
  let(:player) {Player.new(full_deck, pot)}
  it "must have a hand of 5 cards" do
    expect(player.hand.cards.count).to eq(5)
  end
  it "must have a pot" do
    expect(player.pot).to eq(300)
  end

  it "must have a bank of 200" do
    expect(player.bank).to eq(200)
  end

  it "raises an error if they bet more than is in their bank" do
    expect do
      allow(player.raise_amount).to recieve(:gets).and_return("400")
      player.raise_amount

    end.to raise_error("You do not have that much money")

  end



end
