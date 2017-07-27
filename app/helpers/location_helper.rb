module LocationHelper
  def distance(lat1, lon1, lat2, lon2)
    @ConstantR = 6371
    dLat = (lat2 - lat1) * Math::PI / 180
    dLon = (lon2 - lon1) * Math::PI / 180
    a = Math.sin(dLat / 2) * Math.sin(dLat / 2) +
        Math.cos(lat1 * Math::PI / 180) * Math.cos(lat2 * Math::PI / 180) *
        Math.sin(dLon / 2) * Math.sin(dLon / 2)
    c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a))
    d = @ConstantR * c
    if d > 1
      d.round
    elsif d <= 1
      return (d * 1000).round
    else
      d
    end
  end
end