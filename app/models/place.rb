require 'elasticsearch/model'

class Place < ActiveRecord::Base
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  mapping do
      indexes :location, type: 'geo_point'
      indexes :rating,     type: 'integer'
      indexes :name,    type: 'string'
    end

  def as_indexed_json(options)
      self.as_json({
        only: [:id, :name, :rating]
        })
        .merge(location: "#{latitude.to_f}, #{longitude.to_f}")
    end

  def self.search_close_to(lat,lng)
    __elasticsearch__.search(
      {
        "query": {
          "function_score": {
            "functions": [
              {
                "gauss": {
                  "rating": {
                    "origin": "5",
                    "scale": "1"
                  }
                }
              },
              {
                "gauss": {
                  "location": {
                    "origin": "#{lat}, #{lng}",
                    "scale": "0.5km"
                  }
                }
              }
            ],
            "score_mode": "multiply"
          }
        }
      }
    )
  end
end
