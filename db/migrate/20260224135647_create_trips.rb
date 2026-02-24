class CreateTrips < ActiveRecord::Migration[7.1]
  def change
    create_table :trips do |t|
      t.string :name
      t.string :image_url
      t.string :short_description
      t.text :long_description
      t.integer :rating

      t.timestamps
    end
  end
end
