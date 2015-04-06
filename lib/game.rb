require_relative "player"

class Game
  attr_reader :players, :turn, :pot

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

  


  def play
    set_up_players
    until game_over?


    end

  end


end
