class TripsController < ApplicationController
  def index
    @trips = Trip.all

    # Search by name (case-insensitive)
    @trips = @trips.where("LOWER(name) LIKE ?", "%#{params[:search].to_s.downcase}%") if params[:search].present?

    # Filter by minimum rating
    @trips = @trips.where("rating >= ?", params[:min_rating].to_i) if params[:min_rating].present?

    # Sorting
    sort_column, sort_order = if params[:sort].present? && %w[asc desc].include?(params[:sort].downcase)
                                ['rating', params[:sort]]
                              else
                                ['name', 'asc']
                              end
    @trips = @trips.order("#{sort_column} #{sort_order}")

    # **Pagination using Kaminari**
    @trips = @trips.page(params[:page]).per(params[:per_page] || 10)  # <--- This makes it paginated

    render :index
  end
   def show
  @trip = Trip.find_by(id: params[:id])
  unless @trip
    redirect_to trips_path, alert: "Trip not found"
  end
end
end