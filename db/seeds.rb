require "csv"

# Clear the products and categories tables.
AdminUser.destroy_all
Product.destroy_all
Image.destroy_all
Anime.destroy_all
Type.destroy_all

# Remove unwanted string.
def shorten_string(raw, target)
  unwanted_string_length = raw.index(target) + target.length + 1

  raw[unwanted_string_length..]
end

type_list = {
  "Water-Cup" => rand(5000..100_000).to_i,
  "T-Shirt"  => rand(5000..100_000).to_i
}

format_list = {
  /Mirai_Nikki_TV/                                          => "Mirai Nikki (TV): Ura Mirai Nikki",
  /__/                                                      => ": ",
  /_/                                                       => " ",
  / TV/                                                     => " (TV)",
  / 2011/                                                   => " (2011)",
  /Fate Zero/                                               => "Fate/Zero",
  /Steins Gate/                                             => "Steins;Gate",
  /Dr Stone/                                                => "Dr. Stone",
  /%E2%98%85/                                               => "★",
  /Haikyuu/                                                 => "Haikyuu!!",
  /Re Zero/                                                 => "Re:Zero",
  /Angel Beats/                                             => "Angel Beats!",
  /Chuunibyou demo Koi ga Shitai/                           => "Chuunibyou demo Koi ga Shitai!",
  /Kaichou wa Maid-sama/                                    => "Kaichou wa Maid-sama!",
  /Ano Hi Mita Hana no Namae wo Bokutachi wa Mada Shiranai/ => "Ano Hi Mita Hana no Namae wo Bokutachi wa Mada Shiranai.",
  /тИЪA/                                                    => "√A",
  /Hataraku Maou-sama/                                      => "Hataraku Maou-sama!",
  /Durarara/                                                => "Durarara!!",
  /Kimi no Na wa/                                           => "Kimi no Na wa.",
  /Akame ga Kill/                                           => "Akame ga Kill!",
  /Kono Subarashii Sekai ni Shukufuku wo/                   => "Kono Subarashii Sekai ni Shukufuku wo!",
  /Toradora/                                                => "Toradora!",
  /Yahari Ore no Seishun Love Comedy wa Machigatteiru/      => "Yahari Ore no Seishun Love Comedy wa Machigatteiru."
}

# Loop through the rows of first CSV file.
csv_file = Rails.root.join("db/anime_with_synopsis_shorten.csv")
csv_data = File.read(csv_file)

animes = CSV.parse(csv_data, headers: true)

animes.each do |anime|
  new_anime = Anime.find_or_create_by(name: anime["Name"])
  new_anime.description = anime["sypnopsis"]
  new_anime.save!
end

raw_directory   = "animeTVimage"
inner_directory = "stats"
path            = "./db/#{raw_directory}/*"

Dir[path].each do |sub_directory|
  anime_name = shorten_string(sub_directory, raw_directory)

  reformat_anime_name = anime_name

  # Loop through format list to get proper anime name.
  format_list.each do |shape, sides|
    reformat_anime_name = reformat_anime_name.gsub(shape, sides)
  end

  sub_path       = "#{sub_directory}/*.jpg"
  sub_inner_path = "#{sub_directory}/#{inner_directory}/#{anime_name}/*.jpg"

  anime_images = Dir[sub_path]

  anime_images = Dir[sub_inner_path] if anime_images.count.zero?

  anime = Anime.find_or_create_by(name: reformat_anime_name)

  if anime&.valid?

    anime_images.each do |anime_image|
      image_name = shorten_string(anime_image, anime_name)

      if image_name.include? inner_directory
        image_name = shorten_string(image_name, anime_name)
        image_name[0..inner_directory.length - 1] = anime_name
      end

      # Remove .jpg on image name.
      # image_name[0...-4]

      new_image = anime.images.build(
        name:  image_name[0...-4],
        price: rand(5000..100_000).to_i
      )

      puts "Invalid Anime #{image_name[0...-4]}" unless new_image&.valid?
      # puts "Good #{image_name}"
      new_image.save!

      # Attach image
      new_image.image.attach(io: File.open(anime_image), filename: image_name)
      sleep(1)
    end
  else
    puts "Invalid anime category #{reformat_anime_name}."
  end
end

images = Image.all

# Loop through type list to get product types.
type_list.each do |shape, sides|
  new_type = Type.find_or_create_by(name: shape)
  new_type.description = Faker::Company.bs
  new_type.price = sides
  new_type.save!

  random_image_name = shape

  if shape.include? "-"
    separate_point = shape.index("-")
    part_one = shape[0..separate_point - 1]
    part_two = shape[separate_point + 1..shape.length]
    random_image_name = [part_one, part_two].join(",")
  end

  # Attach image
  query = URI.encode_www_form_component(random_image_name)
  downloaded_image = URI.open("https://source.unsplash.com/600x600/?#{query}")
  new_type.image.attach(io: downloaded_image, filename: "m-#{shape}.jpg")
  sleep(1)

  images.each do |each_image|
    Product.create(
      name: new_type.name + ' - ' + each_image.name,
      type: new_type,
      image: each_image,
      stock: 10
    )
  end
end

puts "Created #{Anime.count} Animes"
puts "Created #{Image.count} Images"
puts "Created #{Type.count} Types"
puts "Created #{Product.count} Products"

AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?