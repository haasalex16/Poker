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

  def fold(player)
    @deck.return(player.hand)
    player.hand = nil
    player.folded? = true
  end

  def first_round_decisions
    players.each do |player|
      p player.display_hand
      case player.decide(@raise_amt)
      when 'f'
        fold(player)
      when 'r'
        @raise_amt = player.raise_amount
        player.place_bet(@raise_amt)
      when 's'
        player.place_bet(@raise_amt)
      end
    end

    nil
  end

  def play
    set_up_players
    until game_over?
      @raise_amt = 0
      deal_hands
      first_round_decisions




    end

  end


end
