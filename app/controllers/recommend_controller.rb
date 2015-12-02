class RecommendController < ApplicationController
  def close_to
    lat = params[:latitude].to_f
    lng = params[:longitude].to_f
    size = params.fetch :size, 10

    # generate 20-30 rnadom points close to (lat,lng)
    GenerateRandomPoints.call(20 + rand(10), lat, lng)

    # return {size} points with the highest score
    transaformed_result = Place.search_close_to(lat, lng, size).map do |place|
      result = place['_source']
      result['distance'] = place['sort'][1]
      result['score'] = place['_score']
      result
    end
    render json: transaformed_result
  end
end
