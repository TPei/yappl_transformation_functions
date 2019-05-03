// given an array of numerical values, returns the sum of all elements
function main(params) {
  let values = params.data
  let total = values.reduce((accumulator, current) => accumulator + current, 0)

  return { data: total }
}
