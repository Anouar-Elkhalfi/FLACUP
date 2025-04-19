class AddLocationToTournaments < ActiveRecord::Migration[7.2]
  def change
    add_column :tournaments, :location, :string
  end
end
