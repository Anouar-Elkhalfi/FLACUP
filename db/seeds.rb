puts "⚽ Création d'un tournoi TEST avec 48 équipes pour les phases de poule..."

# Créer un utilisateur si aucun n'existe
user = User.first_or_create!(
  email: "organizer@example.com",
  password: "password123",
  password_confirmation: "password123"
)

tournament = Tournament.create!(
  title: "Coupe Test",
  description: "Tournoi démo avec 6 poules de 8 équipes",
  location: "Paris",
  start_date: Date.today + 1,
  end_date: Date.today + 10,
  categories: "Senior",
  registration_fee: 0.0,
  accommodation_details: "Aucun",
  facilities: "Terrain + Vestiaires",
  organizer_contact: "contact@flacup.test",
  max_teams: 48,
  format: "Poule + Élimination",
  extras: "Tournoi test",
  user_id: user.id
)

# Générer 48 équipes
48.times do |i|
  tournament.teams.create!(name: "Équipe #{i + 1}")
end

puts "✅ Tournoi test créé avec #{tournament.teams.count} équipes (id: #{tournament.id})"
