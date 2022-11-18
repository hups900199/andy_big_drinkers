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

def cutString(raw, target)
  unwanted_string_length = raw.index(target) + target.length + 1

  return raw[unwanted_string_length..]
end

# Dir["/path/to/directory/*.rb"].each {|file| require file }

raw_directory   = "animeTVimage"
inner_directory = "stats"
path            = "./db/#{raw_directory}/*"

n = 0

Dir[path].each do |sub_directory|
  anime_name = cutString(sub_directory, raw_directory)

  sub_path       = "#{sub_directory}/*.jpg"
  sub_inner_path = "#{sub_directory}/#{inner_directory}/#{anime_name}/*.jpg"

  anime_images = Dir[sub_path]

  if anime_images.count == 0
    anime_images = Dir[sub_inner_path]
  end

  anime = Anime.find_or_create_by(name: anime_name)

  if anime.valid?

    anime_images.each do |anime_image|
      image_name = cutString(anime_image, anime_name)

      if image_name.include? inner_directory
        image_name = cutString(image_name, anime_name)
        image_name[0..inner_directory.length - 1] = anime_name
      end

      new_image = anime.images.build(
        name:  image_name,
        price: rand(5000..100_000).to_i
      )

      puts "Invalid Anime #{image_name}" unless new_image&.valid?
      puts "Good #{image_name}"
      new_image.save!
    end
  else
    puts "Invalid anime #{anime} for anime #{anime_name}"
  end
end

puts "Created #{Anime.count} Animes"
puts "Created #{Image.count} Images"
