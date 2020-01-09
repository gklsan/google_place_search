# require 'lib/api_client'
require 'net/http'

class PlaceSearch
  attr_accessor :key, :latitude, :longitude, :name, :radius, :type, :keyword, :response_type

  def initialize(key:, latitude:, longitude:, radius: 100, type: '', name: '', keyword: '', response_type: 'json')
    self.key = key
    self.latitude = latitude
    self.longitude = longitude
    self.radius = radius
    self.type = type
    self.name = name
    self.keyword = keyword
    self.response_type = response_type
  end

  def results
    uri = URI.parse(url)
    res = Net::HTTP.get(uri)
    puts res
  end

  private

  def url
    [
        base_url,
        response_format,
        [
            location,
            by_radius,
            by_type,
            by_name,
            api_key
        ].compact.join('&')
    ].join
  end

  def base_url
    'https://maps.googleapis.com/maps/api/place/nearbysearch/'
  end

  def response_format
    "#{response_type}?"
  end

  def location
    "location=#{latitude},#{longitude}" if latitude && longitude
  end

  def by_radius
    "radius=#{radius}" if radius
  end

  def by_type
    "types=#{type}" if type
  end

  def by_name
    "name=#{name}" if name
  end

  def api_key
    "key=#{key}" if key
  end
end

# ps = PlaceSearch.new(key: 'API_KEY', latitude: '-33.8670522', longitude: '151.1957362')
ps = PlaceSearch.new(key: 'API_KEY', latitude: '-33.8670522', longitude: '151.1957362')
puts ps.results
