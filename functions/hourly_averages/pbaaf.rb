require 'json'
require 'time'

def main(params)
  return { data: params.data.map { |ele| filter(ele) } }
end

def filter(params)
  updated_params = params
  actions = params.actions
  actions.each do |action|
    name = action.keys.first # there's only one
    field = action[name]

    if(name === 'hourly_averages' && params.has_key?(field))
      updated_params[field] = hourly_average(params[field])
    end
  end

  return updated_params
end

def hourly_average(params)
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
