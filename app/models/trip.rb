class Trip < ApplicationRecord
  validates :name, presence: true
  validates :image_url, presence: true
  validates :short_description, presence: true
  validates :long_description, presence: true

  validates :rating,
            presence: true,
            numericality: { only_integer: true },
            inclusion: { in: 1..5 }
end
