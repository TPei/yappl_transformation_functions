require 'json'
require 'time'

def main(params)
  hourly_measurements = group_by_hours(params['data'])
  hourly_measurements.each do |hour, values|
    hourly_measurements[hour] = values.inject(:+) / values.size.to_f
  end
end

def group_by_hours(data)
  hourly_measurements = {}
  data.each do |entry|
    time = entry.keys.first # should only have one value
    value = entry[time]
    hour = Time.parse(time).strftime("%Y-%m-%dT%H:00")
    if hourly_measurements[hour]
      hourly_measurements[hour] << value
    else
      hourly_measurements[hour] = [value]
    end
  end
  return hourly_measurements
end
