class RecommendController < ApplicationController
  def close_to
    lat = params[:lat].to_f
    lng = params[:lng].to_f

    render json: [
      {:name => 'place_A', :latitude => 1, :longitude => 1, :rating => 5},
      {:name => 'place_B', :latitude => 2, :longitude => 2, :rating => 4},
    ]
  end
end
