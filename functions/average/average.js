// given an array of numerical values, returns the average
function main(params) {
  let values = params.data
  let total = values.reduce((accumulator, current) => accumulator + current, 0)
  let average = total / values.length

  return { data: average }
}
