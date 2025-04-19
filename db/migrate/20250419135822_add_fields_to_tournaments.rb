class AddFieldsToTournaments < ActiveRecord::Migration[7.1]
  def change
    add_column :tournaments, :description, :text
    add_column :tournaments, :categories, :string
    add_column :tournaments, :registration_fee, :decimal
    add_column :tournaments, :accommodation_details, :text
    add_column :tournaments, :facilities, :text
    add_column :tournaments, :organizer_contact, :string
    add_column :tournaments, :max_teams, :integer
    add_column :tournaments, :format, :string
    add_column :tournaments, :extras, :text
    add_reference :tournaments, :user, foreign_key: true
  end
end
