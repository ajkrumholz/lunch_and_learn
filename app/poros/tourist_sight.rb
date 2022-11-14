class TouristSight
  attr_reader :id,
              :name,
              :address,
              :place_id

  def initialize(data)
    @id = 'null'
    properties = data[:properties]
    @name = properties[:name]
    @address = properties[:formatted]
    @place_id = properties[:place_id]
  end
end