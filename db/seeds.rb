puts "⚽ Création d'un tournoi TEST avec 8 équipes pour les phases de poule..."

# Assurez-vous d'avoir la variable users disponible ici :
users = User.all

tournament = Tournament.create!(
  title: "Coupe Test",
  description: "Tournoi démo avec phases de poule et éliminatoires",
  location: "Paris",
  start_date: Date.today + 1,
  end_date: Date.today + 10,
  categories: "Senior",
  registration_fee: 0.0,
  accommodation_details: "Aucun",
  facilities: "Terrain + Vestiaires",
  organizer_contact: "contact@flacup.test",
  max_teams: 8,
  format: "Poule + Élimination",
  extras: "Tournoi test",
  user_id: users.where(role: 'organizer').sample&.id || users.sample.id
)

team_names = [
  "Red Falcons", "Blue Hawks", "Green Giants", "Yellow Stars",
  "Black Panthers", "White Wolves", "Golden Eagles", "Silver Sharks"
]

team_names.each do |name|
  tournament.teams.create!(name: name)
end

puts "✅ Tournoi test créé avec #{tournament.teams.count} équipes (id: #{tournament.id})"
