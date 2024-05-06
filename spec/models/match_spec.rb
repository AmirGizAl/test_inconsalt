require 'rails_helper'

RSpec.describe Match, type: :model do
  describe '.create_with_teams' do
    let(:team1) { create(:team) }
    let(:team2) { create(:team) }

    it 'creates a match with the given teams' do
      match = Match.create_with_teams(team1, team2)
      expect(match).to be_valid
      expect(match.teams).to include(team1, team2)
    end

    it 'associates teams with the match' do
      expect { Match.create_with_teams(team1, team2) }.to change { Match.count }.by(1)
      expect(team1.matches.count).to eq(1)
      expect(team2.matches.count).to eq(1)
    end
  end
end

