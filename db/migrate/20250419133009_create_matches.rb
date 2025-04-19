class CreateMatches < ActiveRecord::Migration[7.1]
  def change
    create_table :matches do |t|
      t.references :tournament, null: false, foreign_key: true
      t.references :team_a, null: false, foreign_key: { to_table: :teams }
      t.references :team_b, null: false, foreign_key: { to_table: :teams }
      t.string :round
      t.string :group
      t.integer :score_a
      t.integer :score_b

      t.timestamps
    end
  end
end
