class TripsController < ApplicationController
  before_action :set_trip, only: [:show]

  def index
    @trips = Trip.all
    @trips = apply_filters(@trips)
    @trips = apply_sort(@trips)
    @trips = @trips.page(params[:page]).per(params[:per_page] || 10)
  end

  def show
    unless @trip
      flash[:alert] = "Trip not found"
      redirect_to trips_path
    end
  end

  def create
    @trip = Trip.new(trip_params)

    if @trip.save
      flash[:notice] = "Trip created successfully!"
      redirect_to trips_path
    else
      flash.now[:alert] = @trip.errors.full_messages.join(", ")
      @trips = Trip.all
      @trips = apply_filters(@trips)
      @trips = apply_sort(@trips)
      @trips = @trips.page(params[:page]).per(params[:per_page] || 10)
      render :index, status: :unprocessable_entity
    end
  end

  private

  def set_trip
    @trip = Trip.find_by(id: params[:id])
  end

  def trip_params
    params.require(:trip).permit(
      :name,
      :image_url,
      :short_description,
      :long_description,
      :rating
    )
  end

  def apply_filters(scope)
    filtered = scope
    filtered =
      filtered.where(
        "LOWER(name) LIKE ?",
        "%#{params[:search].to_s.downcase}%"
      ) if params[:search].present?
    filtered =
      filtered.where("rating >= ?", params[:min_rating].to_i) if params[
      :min_rating
    ].present?
    filtered
  end

  def apply_sort(scope)
    case params[:sort]&.downcase
    when "asc"
      scope.order(rating: :asc)
    when "desc"
      scope.order(rating: :desc)
    when "name_desc"
      scope.order(name: :desc)
    else
      scope.order(name: :asc)
    end
  end
end
