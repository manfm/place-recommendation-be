class RecommendController < ApplicationController
  def close_to
    lat = params[:latitude].to_f
    lng = params[:longitude].to_f
    size = params.fetch :size, 10

    # generate 20-30 rnadom points close to (lat,lng)
    GenerateRandomPoints.call(20 + rand(10), lat, lng)

    # return {size} point with the highest score
    render json: Place.search_close_to(lat, lng, size)
  end
end
