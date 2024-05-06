class Player < ApplicationRecord
  belongs_to :team
  has_many :player_metrics
  has_many :metrics, through: :player_metrics

  def self.top_players(metric_name, team_id = nil)
    metric = Metric.find_by_name!(metric_name)

    players = Player.joins(:player_metrics).where(player_metrics: { metric: })
    players = players.where(team_id:) if team_id
    players.group(:id).order('AVG(player_metrics.value) DESC').limit(5)
  end

  def mark_metric(metric_name, match_id, value)
    metric = Metric.find_by_name!(metric_name)

    player_metric = PlayerMetric.find_or_initialize_by(player: self, metric:, match_id:)
    player_metric.value ||= 0
    player_metric.value += value
    player_metric.save!
  end

  def performed_metric_in_previous_matches?(metric_name)
    metric = Metric.find_by_name!(metric_name)
    player_metrics.joins(:match).where(matches: { id: team.matches.order(created_at: :desc).limit(5) }, metric:).exists?
  end
end
