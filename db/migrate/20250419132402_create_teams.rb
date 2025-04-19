class CreateTeams < ActiveRecord::Migration[7.2]
  def change
    create_table :teams do |t|
      t.string :name
      t.references :tournament, null: false, foreign_key: true
      t.string :group

      t.timestamps
    end
  end
end
