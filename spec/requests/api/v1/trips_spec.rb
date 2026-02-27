require "rails_helper"

RSpec.describe "Trips API", type: :request do
  let!(:trip) do
    Trip.create!(
      name: "Test Trip",
      image_url: "https://example.com/image.jpg",
      short_description: "Short desc",
      long_description: "Long desc",
      rating: 4
    )
  end

  describe "GET /api/v1/trips" do
    it "returns trips" do
      get "/api/v1/trips"
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)["trips"].first["name"]).to eq(trip.name)
    end

    it "filters by search" do
      get "/api/v1/trips", params: { search: "Test" }
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)["trips"].first["name"]).to eq(trip.name)
    end

    it "filters by min_rating" do
      get "/api/v1/trips", params: { min_rating: 5 }
      expect(JSON.parse(response.body)["trips"]).to be_empty
    end

    it "sorts by rating desc" do
      Trip.create!(
        name: "Another Trip",
        image_url: "https://example.com/img.jpg",
        short_description: "Short",
        long_description: "Long",
        rating: 5
      )
      get "/api/v1/trips", params: { sort: "desc" }
      names = JSON.parse(response.body)["trips"].map { |t| t["name"] }
      expect(names.first).to eq("Another Trip")
    end
  end

  describe "GET /api/v1/trips/:id" do
    it "returns a trip" do
      get "/api/v1/trips/#{trip.id}"
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)["name"]).to eq(trip.name)
    end

    it "returns 404 for non-existent trip" do
      get "/api/v1/trips/999999"
      expect(response).to have_http_status(:not_found)
    end
  end

  describe "POST /api/v1/trips" do
    it "creates a trip with valid params" do
      post "/api/v1/trips",
           params: {
             trip: {
               name: "New Trip",
               image_url: "https://example.com/new.jpg",
               short_description: "Short",
               long_description: "Long",
               rating: 3
             }
           }
      expect(response).to have_http_status(:created)
      expect(JSON.parse(response.body)["name"]).to eq("New Trip")
    end

    it "fails with invalid params" do
      post "/api/v1/trips",
           params: {
             trip: {
               name: "",
               image_url: "",
               short_description: "",
               long_description: "",
               rating: 10
             }
           }
      expect(response).to have_http_status(:unprocessable_entity)
      expect(JSON.parse(response.body)["errors"]).not_to be_empty
    end
  end
end
