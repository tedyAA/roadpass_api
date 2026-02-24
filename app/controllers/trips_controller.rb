class TripsController < ApplicationController
  def index
    @trips = Trip.all

    if params[:search].present?
      @trips = @trips.where("LOWER(name) LIKE ?", "%#{params[:search].to_s.downcase}%")
    end

    if params[:min_rating].present?
      @trips = @trips.where("rating >= ?", params[:min_rating].to_i)
    end

    sort_column, sort_order = if params[:sort].present? && %w[asc desc].include?(params[:sort].downcase)
                               ['rating', params[:sort].downcase]
                             else
                               ['name', 'asc']
                             end

    @trips = @trips.order("#{sort_column} #{sort_order}")
                   .page(params[:page])
                   .per(params[:per_page] || 10)

    render :index
  end

  def show
    @trip = Trip.find_by(id: params[:id])
    return redirect_to trips_path, alert: "Trip not found" unless @trip
  end

  def create
    @trip = Trip.new(trip_params)

    if @trip.save
      redirect_to trips_path, notice: "Trip created successfully!"
    else
      @trips = Trip.all.page(params[:page]).per(params[:per_page] || 10)
      render :index, status: :unprocessable_entity
    end
  end

  private

  def trip_params
    params.require(:trip).permit(:name, :image_url, :short_description, :long_description, :rating)
  end
end