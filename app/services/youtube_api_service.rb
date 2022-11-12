class YoutubeApiService
  
  def self.conn
    Faraday.new("https://www.googleapis.com/youtube/v3/search") do |f|
      f.params['key'] = ENV['youtube_api_key']
    end
  end

  def self.search(country)
    response = search_uncached(country)
    JSON.parse(response.body, symbolize_names: true)
  end

  def self.search_uncached(country)
    Rails.cache.fetch("youtube_#{country}", expires_in: 7.days) do
      conn.get do |f|
        f.params['channelId'] = "UCluQ5yInbeAkkeCndNnUhpw"
        f.params['part'] = "snippet"
        f.params['maxResults'] = 1
        f.params['q'] = country
        f.params['fields'] = 'items(id/videoId,snippet/title)'
      end
    end
  end
end