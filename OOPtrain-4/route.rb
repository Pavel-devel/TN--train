class Route

  attr_reader :station_all

  def initialize(primary, final)
    @primary = primary
    @final = final
    @station_all = [@primary, @final]
  end

  def add_station(station)
    @station_all.insert(@station_all.length - 1, station)
  end

  def del_station(station)
    @station_all.delete(station)
  end

  private # в интерфейсе не задан

  attr_accessor :primary, :final

  def intermediate
    @station_all[1..-2]
  end

end