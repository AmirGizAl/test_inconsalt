RSpec.describe Player, type: :model do
  describe '.top_players' do
    let(:team) { create(:team) }
    let(:metric) { create(:metric) }
    let(:player1) { create(:player, team:) }
    let(:player2) { create(:player, team:) }

    it 'returns top players by metric' do
      create(:player_metric, player: player1, metric:, value: 10)
      create(:player_metric, player: player2, metric:, value: 15)

      top_players = described_class.top_players(metric.name)

      expect(top_players).to include(player2)
      expect(top_players.size).to eq(2)
    end

    it 'returns top players by metric for a specific team' do
      team2 = create(:team)
      player3 = create(:player, team: team2)
      create(:player_metric, player: player3, metric:, value: 20)

      top_players = described_class.top_players(metric.name, team2.id)

      expect(top_players).to include(player3)
      expect(top_players.size).to eq(1)
    end
  end

  describe '#mark_metric' do
    let(:team) { create(:team) }
    let(:player) { create(:player, team:) }
    let(:match) { create(:match) }
    let(:metric) { create(:metric) }

    context 'when PlayerMetric record does not exist' do
      it 'creates a new record in PlayerMetric with the specified value' do
        expect do
          player.mark_metric(metric.name, match.id, 10)
        end.to change(PlayerMetric, :count).by(1)

        player_metric = PlayerMetric.last
        expect(player_metric.player).to eq(player)
        expect(player_metric.match).to eq(match)
        expect(player_metric.metric).to eq(metric)
        expect(player_metric.value).to eq(10)
      end
    end

    context 'when PlayerMetric record already exists' do
      before do
        create(:player_metric, player:, match:, metric:, value: 5)
      end

      it 'updates the existing record in PlayerMetric with the specified value' do
        expect do
          player.mark_metric(metric.name, match.id, 15)
        end.to_not change(PlayerMetric, :count)

        player_metric = PlayerMetric.last
        expect(player_metric.player).to eq(player)
        expect(player_metric.match).to eq(match)
        expect(player_metric.metric).to eq(metric)
        expect(player_metric.value).to eq(20) # 5 (initial value) + 15 (new value)
      end
    end
  end

  describe '#performed_metric_in_previous_matches?' do
    let(:team1) { create(:team) }
    let(:player) { create(:player, team: team1) }
    let(:metric) { create(:metric) }

    context 'when there are no previous matches for the team' do
      it 'returns false' do
        expect(player.performed_metric_in_previous_matches?(metric.name)).to eq(false)
      end
    end

    context 'when the metric exists in previous matches of the team' do
      let(:team2) { create(:team) }
      let(:match) { Match.create_with_teams(team1, team2) }

      before do
        create_list(:match, 5) do |match|
          Match.create_with_teams(team1, team2)
        end
        create(:player_metric, player:, match:, metric:, value: 10)
      end

      it 'returns true' do
        expect(player.performed_metric_in_previous_matches?(metric.name)).to eq(true)
      end
    end
  end
end


