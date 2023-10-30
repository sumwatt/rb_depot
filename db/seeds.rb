# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
Product.delete_all

Product.create!(
  title: 'Sumnew Schuz',
  description: %{<p><em>Comfeee Nue Schuz</em> These are some fancy new shoes you should try on. At least one. Preferably using your biggest foot.</p>},
  image_url: 'https://dummyimage.com/600x400/000/fff.png',
  price: 24.95
)