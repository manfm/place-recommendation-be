class GenerateRandomPoints
  def self.call(n, lat, lng)
    Place.__elasticsearch__.create_index! force: true

    Place.delete_all

    n.times.map.each do |i|
      place = Place.new
      place.name = "Place #{i + 1}"
      place.latitude = randomize_point(lat)
      place.longitude = randomize_point(lng)
      place.rating = rand(5) + 1 # 1*-5*
      place.save
    end

    Place.__elasticsearch__.refresh_index!
  end

  private

  def self.randomize_point(point)
    negative_or_positive = (rand > 0.5) ? -1 : 1
    random_number = 5 * (rand / 100); # 3 * 0.00xxxx

    point + (random_number * negative_or_positive)
  end
end
