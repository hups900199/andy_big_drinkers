# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

# Clear the products and categories tables.
Product.destroy_all
Image.destroy_all
Anime.destroy_all
Type.destroy_all

# Dir["/path/to/directory/*.rb"].each {|file| require file }

raw_directory = "animeTVimage"
path = "./db/#{raw_directory}/*"

n = 0

Dir[path].each do |sub_directory|
  unwanted_string_length = sub_directory.index(raw_directory) + raw_directory.length + 1
  anime_name = sub_directory[unwanted_string_length..]

  anime = Anime.find_or_create_by(name: anime_name)

  n += 1

  if anime.valid?
    new_image = anime.images.build(
      name:  "first #{n}",
      price: rand(5000..100_000).to_i
    )

    puts "Invalid Anime #{anime_name}" unless new_image&.valid?

    new_image.save!
  else
    puts "Invalid anime #{anime} for anime #{anime_name}"
  end
end

puts "Created #{Anime.count} Animes"
puts "Created #{Image.count} Images"
