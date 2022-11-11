class YoutubeApiService
  def self.conn
    Faraday.new("https://www.googleapis.com/youtube/v3/search") do |f|
      f.params['key'] = ENV['youtube_api_key']
    end
  end

  def self.search(country)
    response = conn.get do |f|
      f.params['channelId'] = "UCluQ5yInbeAkkeCndNnUhpw"
      f.params['part'] = "snippet"
      f.params['maxResults'] = 1
      f.params['q'] = country
      f.params['fields'] = 'items(id/videoId,snippet/title)'
    end
    json(response)
  end
end