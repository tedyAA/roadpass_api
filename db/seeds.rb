require 'json'

file_path = Rails.root.join('db', 'data.json')
json_data = File.read(file_path)
data = JSON.parse(json_data)

unless data['trips'].is_a?(Array)
  raise "Invalid JSON format: expected 'trips' array"
end

Trip.transaction do
  data['trips'].each do |trip|
    Trip.find_or_create_by!(name: trip['name']) do |t|
      t.assign_attributes(
        image_url: trip['image_url'],
        short_description: trip['short_description'],
        long_description: trip['long_description'],
        rating: trip['rating']
      )
    end
  end
end

puts "Seeded #{Trip.count} trips!"