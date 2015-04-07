require_relative "player"

class Game
  attr_reader :players, :turn, :pot, :deck

  def initialize
    @deck = Deck.new
    @pot = 0
    @players = []
    @turn = 0
  end

  def toggle_turn
    @turn += 1
    @turn = 0 if @turn >= @player.count
  end

  def add_player(name)
    @players << Player.new(name,@deck,@pot)
  end

  def set_up_players
    puts "How many people are playing?"
    num = gets.chomp.to_i
    num.times do |idx|
      puts "What is Player #{idx + 1}'s name?'"
      name = gets.chomp.capitalize
      add_player(name)
    end

    nil
  end

  def banks
    banks = []
    players.each do |player|
      banks << player.bank
    end

    banks
  end

  def game_over?
    banks.count(0) == players.count - 1
  end

  def deal_hands
    players.each do |player|
      player.hand = Hand.deal_hand(@deck)
    end
  end

  def first_round_decisions
    players.each do |player|
      p player.display_hand
      case player.decide(@raise_amt)
      when 'f'
        player.fold
      when 'r'
        @raise_amt = player.raise_amount
        @pot += @raise_amt
        player.place_bet(@raise_amt)
      when 's'
        player.place_bet(@raise_amt)
        @pot += @raise_amt
      end
    end

    nil
  end

  def card_exchange
    players.each do |player|
      next if player.folded
      player.discard
    end

    nil
  end

  def hand_over?
    still_in_hand = 0
    @players.each do |player|
      still_in_hand += 1 unless player.folded
    end

    still_in_hand == 1
  end

  def pay_winner
    @players.each do |player|
      unless player.folded
        player.recieve_winnings(@pot)
        puts "#{player.name} Won $#{@pot}"
        @pot = 0
      end
    end

    nil
  end

  def turn_in_hands
    @players.each do |player|
      @deck.return(player.hand.cards)
      player.hand = nil
      player.folded = false
    end

    nil
  end


  def play
    set_up_players
    until game_over?
      @deck.shuffle
      @raise_amt = 0
      deal_hands
      first_round_decisions
      pay_winner if hand_over?



      turn_in_hands
    end

  end


end

if __FILE__ == $PROGRAM_NAME
  Game.new.play


end
