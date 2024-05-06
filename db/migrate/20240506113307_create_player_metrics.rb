class CreatePlayerMetrics < ActiveRecord::Migration[7.0]
  def change
    create_table :player_metrics do |t|
      t.references :player, null: false, foreign_key: true
      t.references :metric, null: false, foreign_key: true
      t.references :match, null: false, foreign_key: true
      t.integer :value

      t.timestamps
    end
  end
end
