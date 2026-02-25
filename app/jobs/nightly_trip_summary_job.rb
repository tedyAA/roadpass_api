class NightlyTripSummaryJob < ApplicationJob
  queue_as :default

  def perform(*args)
    trips = Trip.all
    average_rating = trips.average(:rating)&.round(2) || 0

    Rails.logger.info "Nightly Trip Summary - Average Rating: #{average_rating}"
    Rails.logger.info "Nightly summary job completed at #{Time.current}"
  end
end