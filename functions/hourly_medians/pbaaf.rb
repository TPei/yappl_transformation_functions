require 'json'
require 'time'

def main(params)
  return { data: params['data'].map { |ele| filter(ele) } }
end

def filter(params)
  updated_params = params
  actions = params['actions']
  actions.each do |action|
    name = action.keys.first # there's only one
    field = action[name]

    if(name === 'hourly_medians' && params.has_key?(field))
      updated_params[field] = hourly_median(params[field])
    end
  end

  return updated_params
end

def hourly_median(params)
  hourly_measurements = group_by_hours(params['data'])
  hourly_measurements.each do |hour, values|
    values = values.sort
    if values.length.even?
      # take average of two middle elements if array has even number of entries
      upper_middle = values.length / 2
      median = values[upper_middle-1..upper_middle].inject(:+) / 2.0
    else
      median = values[values.length / 2]
    end
    hourly_measurements[hour] = median
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
