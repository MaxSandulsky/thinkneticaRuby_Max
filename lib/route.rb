class Route
  attr_reader :stations
  def initialize(*stations)
    @stations = stations
  end
  
end
