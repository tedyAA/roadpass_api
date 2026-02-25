class Api::V1::TripsController < ApplicationController
  def index
    trips = Trip.all
    trips = trips.where("LOWER(name) LIKE ?", "%#{params[:search].to_s.downcase}%") if params[:search].present?
    trips = trips.where("rating >= ?", params[:min_rating].to_i) if params[:min_rating].present?
    trips = trips.order(params[:sort] == "desc" ? "rating desc" : "name asc")
    trips = trips.page(params[:page]).per(params[:per_page] || 10)

    if stale?(etag: trips, last_modified: trips.maximum(:updated_at))
      render json: {
        trips: TripSerializer.new(trips).serializable_hash[:data].map { |t| t[:attributes] },
        meta: {
          current_page: trips.current_page,
          total_pages: trips.total_pages,
          total_count: trips.total_count
        }
      }
    end
  end

  def show
    trip = Trip.find(params[:id])
    render json: TripSerializer.new(trip).serializable_hash[:data][:attributes]
  rescue ActiveRecord::RecordNotFound
    render json: { error: "Trip not found" }, status: :not_found
  end

 def create
    trip = Trip.new(trip_params)

    if trip.save
      render json: TripSerializer.new(trip).serializable_hash[:data][:attributes], status: :created
    else
      render json: { errors: trip.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def trip_params
    params.require(:trip).permit(
      :name,
      :image_url,
      :short_description,
      :long_description,
      :rating
    )
  end
end