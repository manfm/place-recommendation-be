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

# https://www.elastic.co/guide/en/elasticsearch/reference/current/query-dsl-function-score-query.html
  def self.search_close_to(lat,lng)
    __elasticsearch__.search(
      {
        "query": {
          "function_score": {
            "functions": [
              {
                "exp": {
                  "rating": {
                    "origin": "5",
                    "scale": "2",
                    "offset": "0",
                    "decay": "0.3"
                  }
                }
                # "weight": 2 # does not work at facetflow.com server
              },
              {
                "gauss": {
                  "location": {
                    "origin": "#{lat}, #{lng}",
                    "scale": "2km",
                    "offset": "0.3km",
                    "decay": "0.5"
                  }
                }
                # "weight": 1 # does not work at facetflow.com server
              }
            ],
            "score_mode": "multiply"
          }
        }
      }
    )
  end
end

Place.import force: true
