require 'rails_helper'

RSpec.describe Metric, type: :model do
  describe '.find_by_name!' do
    let!(:metric1) { create(:metric, name: 'Metric 1') }
    let!(:metric2) { create(:metric, name: 'Metric 2') }

    it 'returns the metric with the specified name' do
      expect(Metric.find_by_name!('Metric 1')).to eq(metric1)
    end

    it 'raises an error if the metric with the specified name does not exist' do
      expect { Metric.find_by_name!('Non-existent Metric') }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end

