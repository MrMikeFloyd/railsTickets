#---
# Seeding data for the Claim Companion application.
# Encoding: UTF-8
#---

# Users
puts '-- removing User data.'
User.delete_all
puts '-- seeding User data.'
User.create!(name:  "Mike Floyd",
             email: "mike@mail.com",
             password:              "password",
             password_confirmation: "password",
             admin:     true,
             activated: true,
             activated_at: Time.zone.now)

User.create!(name:  "Administrator",
             email: "admin@mail.com",
             password:              "password",
             password_confirmation: "password",
             admin:     true,
             activated: true,
             activated_at: Time.zone.now)

5.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@mail.com"
  password = "password"
  User.create!(name:  name,
               email: email,
               password:              password,
               password_confirmation: password,
               activated: true,
               activated_at: Time.zone.now)
end

# Claim Types
puts '-- removing Claim Type data.'
ClaimType.delete_all
puts '-- seeding Claim Type data.'
ClaimType.create!(
             name: "Overshipment Box",
             description: "Eine zu große Menge einer Box wurde angeliefert."
)
ClaimType.create!(
    name: "Damaged Box",
    description: "Eine Box wurde beschädigt angeliefert."
)

# Claims
puts '-- removing Claim data.'
Claim.delete_all
puts '-- seeding Claim data.'
Claim.create!(
    status: "In Bearbeitung",
    description: "Zu viel Ware versendet.",
    insert_user: "seeder@railsTicket.app",
    claim_type: ClaimType.first,
)
Claim.create!(
    status: "In Bearbeitung",
    description: "Ware defekt.",
    insert_user: "seeder@railsTicket.app",
    claim_type: ClaimType.second,
)
Claim.create!(
    status: "Abgeschlossen",
    description: "Kaputte Ware am Zielort.",
    insert_user: "seeder@railsTicket.app",
    claim_type: ClaimType.second,
)
Claim.create!(
    status: "Neu",
    description: "Überversand von 4 Kartons!",
    insert_user: "seeder@railsTicket.app",
    claim_type: ClaimType.first,
)
Claim.create!(
    status: "Neu",
    description: "8 Kartons zu viel",
    insert_user: "seeder@railsTicket.app",
    claim_type: ClaimType.first,
)
Claim.create!(
    status: "Neu",
    description: "Warenverpackung beschädigt",
    insert_user: "seeder@railsTicket.app",
    claim_type: ClaimType.second,
)
Claim.create!(
    status: "Neu",
    description: "Karton ohne Ware!?",
    insert_user: "seeder@railsTicket.app",
    claim_type: ClaimType.second,
)
Claim.create!(
    status: "Neu",
    description: "Ware ohne Karton!?",
    insert_user: "seeder@railsTicket.app",
    claim_type: ClaimType.second,
)
Claim.create!(
    status: "Neu",
    description: "Kaputte Drucker",
    insert_user: "seeder@railsTicket.app",
    claim_type: ClaimType.second,
)
Claim.create!(
    status: "Neu",
    description: "Ware ohne Palette auf den Hof gestellt",
    insert_user: "seeder@railsTicket.app",
    claim_type: ClaimType.second,
)
Claim.create!(
    status: "Neu",
    description: "Überhaupt keine Ware bekommen!?",
    insert_user: "seeder@railsTicket.app",
    claim_type: ClaimType.second,
)
