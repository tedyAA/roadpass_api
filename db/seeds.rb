require 'json'

# Clear existing trips to avoid duplicates
Trip.destroy_all

# Load JSON file
file_path = Rails.root.join('db', 'data.json')
json_data = File.read(file_path)
data = JSON.parse(json_data)

# Create trips from JSON
data['trips'].each do |trip|
  Trip.create!(
    name: trip['name'],
    image_url: trip['image_url'],
    short_description: trip['short_description'],
    long_description: trip['long_description'],
    rating: trip['rating']
  )
end

puts "Seeded #{Trip.count} trips!"