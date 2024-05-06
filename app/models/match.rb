class Match < ApplicationRecord
  has_and_belongs_to_many :teams
  has_many :player_metrics

  def self.create_with_teams(team1, team2)
    match = new
    match.teams << [team1, team2]
    match.save
    match
  end
end
