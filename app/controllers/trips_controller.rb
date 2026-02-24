class TripsController < ApplicationController
  def index
    @trips = Trip.all.order(:name)
  end

  def show
    @trip = Trip.find(params[:id])
  end
end