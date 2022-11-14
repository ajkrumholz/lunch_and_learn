class CustomSerializer
  def self.no_content
    { data: [], errors: { messages: [ "Content could not be located, try another query" ] } }
  end

  def self.errors(errors)
    { errors: error_array(errors.messages) }
  end

  def self.error_array(messages)
    messages.reduce([]) do |array, (att,msg)|
      title = att.to_s.humanize
      msgs = msg.map { |msg| title + " " + msg }
      array << { 
        source: att,
        detail: msgs
      }
    end
  end

  def self.favorite_success
    { success: "Favorite added successfully" }
  end

  def self.bad_api_key
    { errors: ["API Key could not be verified"] }
  end

  def self.no_country
    { errors: ["That doesn't seem to be a real country"] }
  end
end