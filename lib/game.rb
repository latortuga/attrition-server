class Game
  attr_reader :players
  
  def initialize players
    @players = players
  end
  
  def play
    playing = alive
    armies = players.map(&:score)
    
    playing.each{|p| p.get_move(armies)}
    
    by_bet = playing.sort_by{|p| 0-p.move}
    winner = by_bet[0]
    
    remaining = winner.move - by_bet[1].move

    bonus = remaining
    by_bet[1..-1].each do |player|
      bonus += [remaining, player.move].min
    end
    
    winner.increment(bonus)
  end
  
  def round
    players.first.moves.size
  end
  
  def sorted
    players.sort_by{|p| 0-p.moves.size}.sort_by{|p| 0-p.score}
  end
  
  def alive
    players.select(&:alive?)
  end
end
