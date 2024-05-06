class PlayerMetric < ApplicationRecord
  belongs_to :player
  belongs_to :metric
  belongs_to :match
end
