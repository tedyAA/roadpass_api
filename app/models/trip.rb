class Trip < ApplicationRecord
   validates :name, :image_url, :short_description, presence: true
  validates :rating, inclusion: { in: 1..5 }
end
