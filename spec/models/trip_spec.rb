require "rails_helper"

RSpec.describe Trip, type: :model do
  subject do
    Trip.new(
      name: "Test Trip",
      image_url: "https://example.com/image.jpg",
      short_description: "Short desc",
      long_description: "Long desc",
      rating: 4
    )
  end

  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end

  it "is invalid without a name" do
    subject.name = nil
    expect(subject).not_to be_valid
  end

  it "is invalid without an image_url" do
    subject.image_url = nil
    expect(subject).not_to be_valid
  end

  it "is invalid without a short_description" do
    subject.short_description = nil
    expect(subject).not_to be_valid
  end

  it "is invalid if rating is not between 1 and 5" do
    subject.rating = 6
    expect(subject).not_to be_valid
  end
end
