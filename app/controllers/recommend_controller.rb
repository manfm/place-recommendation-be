class RecommendController < ApplicationController
  def close_to
    lat = params[:lat].to_f
    lng = params[:lng].to_f

    GenerateRandomPoints.call 10, lat, lng

    recommendation = recommend lat, lng

    render json: recommendation
  end

  def recommend(lat, lng)
    Place.search_close_to(lat, lng)
  end
end
