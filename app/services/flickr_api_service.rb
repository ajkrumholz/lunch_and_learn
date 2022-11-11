class FlickrApiService
  def self.conn
    Faraday.new("https://api.flickr.com/services/rest/") do |f|
      f.params['api_key'] = ENV['flickr_api_key']
      f.headers['Content-Type'] = 'application/json'
    end
  end

  def self.search(country)
    response = conn.get do |f|
      f.params['text'] = country
      f.params['per_page'] = 10
      f.params['method'] = 'flickr.photos.search'
      f.params['format'] = 'json'
      f.params['nojsoncallback'] = 1
      f.params['content_type'] = 1
      f.params['extras'] = 'url_c'
    end
    JSON.parse(response.body, symbolize_names: true)
  end
end