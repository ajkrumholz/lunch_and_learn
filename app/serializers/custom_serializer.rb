class CustomSerializer
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

  def self.no_record
    { errors: "Sorry, that record could not be found" }
  end

  def self.favorite_success
    { success: "Favorite added successfully" }
  end

  def self.bad_api_key
    { errors: ["API Key could not be verified"] }
  end

  def self.no_auth
    { errors: "Your email or password does not match our records, please try again" }
  end

  def self.no_country
    { errors: "That doesn't seem to be an official country name. Try another spelling or the official name of the country you had in mind." }
  end
end