def main(params)
  return { data: params['data'].map { |ele| filter(ele) } }
end

def filter(params)
  updated_params = params
  actions = params['actions']
  actions.each do |action|
    name = action.keys.first # there's only one
    field = action[name]

    if(name === 'anonymizer' && params.has_key?(field))
      updated_params[field] = anonymize(params[field])
    end
  end

  return updated_params
end

def anonymize(data)
  { data: '*' * data.length }
end
