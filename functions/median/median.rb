# given an array of numerical values, returns the median

def main(params)
  sorted = params['data'].sort
  len = sorted.length
  median = (sorted[(len - 1) / 2] + sorted[len / 2]) / 2.0

  { data: median }
end
