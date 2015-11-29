class RecommendController < ApplicationController
  def close_to
    lat = params[:latitude].to_f
    lng = params[:longitude].to_f

    GenerateRandomPoints.call 10, lat, lng

    recommendation = recommend lat, lng

    render json: recommendation
  end

  def recommend(lat, lng)
    Place.search_close_to(lat, lng)
  end
end
