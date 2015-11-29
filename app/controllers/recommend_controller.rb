class RecommendController < ApplicationController
  def close_to
    lat = params[:lat].to_f
    lng = params[:lng].to_f

    GenerateRandomPoints.call 10, lat, lng

    recommendation = recommend lat, lng

    render json: recommendation
  end

  def recommend(_lat, _lng)
    Place.all
  end
end
