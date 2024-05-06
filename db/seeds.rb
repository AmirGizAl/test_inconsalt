# Создаем команды
team1 = Team.create(name: 'Team 1')
team2 = Team.create(name: 'Team 2')

# Создаем игроков для каждой команды
player1 = Player.create(name: 'Player 1', team: team1)
player2 = Player.create(name: 'Player 2', team: team1)
player3 = Player.create(name: 'Player 3', team: team1)
player4 = Player.create(name: 'Player 4', team: team2)
player5 = Player.create(name: 'Player 5', team: team2)
player6 = Player.create(name: 'Player 6', team: team2)

# Создаем показатели
metric1 = Metric.create(name: 'Total run')
metric2 = Metric.create(name: 'Accurate passes')

# Создаем матчи для каждой команды
match1 = Match.create_with_teams(team1, team2)
match2 = Match.create_with_teams(team1, team2)
match3 = Match.create_with_teams(team1, team2)

# Создаем записи о показателях игроков в матчах
player_metrics = [
  { match: match1, player: player1, metric: metric1, value: 10 },
  { match: match1, player: player2, metric: metric2, value: 5 },
  { match: match1, player: player3, metric: metric1, value: 10 },
  { match: match2, player: player4, metric: metric2, value: 5 },
  { match: match2, player: player5, metric: metric1, value: 10 },
  { match: match2, player: player1, metric: metric2, value: 5 },
  { match: match3, player: player1, metric: metric1, value: 10 },
  { match: match3, player: player2, metric: metric2, value: 5 },
  { match: match3, player: player3, metric: metric2, value: 5 }
]
PlayerMetric.create(player_metrics)
