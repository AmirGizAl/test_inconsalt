class CreateJoinTableMatchesTeams < ActiveRecord::Migration[7.0]
  def change
    create_join_table :matches, :teams do |t|
      t.index [:match_id, :team_id]
      t.index [:team_id, :match_id]
    end
  end
end
