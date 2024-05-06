class Metric < ApplicationRecord
  has_many :player_metrics
  has_many :players, through: :player_metrics

  scope :find_by_name!, ->(name) { where(name:).first! }
end
