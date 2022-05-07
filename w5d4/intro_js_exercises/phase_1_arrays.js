// Using arrow function vs regular functions
Array.prototype.uniq = function() {
  let uniq_arr = [];
  let dict = {};
  this.forEach(function(el) {
    if (dict[el] === undefined) {
      uniq_arr.push(el);
      dict[el] = true;
    }
  });
  return uniq_arr;
}
console.log(([1, 2, 2, 3, 3, 3].uniq()));

// Where numbers are unique
Array.prototype.twoSum = function() {
  let pairs = [];
  let dict = {};
  this.forEach(function(el, idx) {
    if (dict[el] === undefined) {
      dict[0 - el] = idx;
    } else {
      start_idx = dict[el];
      pairs.push([start_idx, idx]);
    };
  });
  return pairs;
};

console.log(([1, 2, 3, -4, 4, -1, -2, -3].twoSum()));

Array.prototype.transpose = function() {
  let transposed = [];

  for(y = 0; y < this[0].length; y++) {
    let new_arr = [];
    for (x = 0; x < this.length; x++) {
      new_arr.push(this[x][y]);
    }
    transposed.push(new_arr);
  }
  return transposed;
}

let array = [[1, 2, 3], [4, 5, 6]]
console.log(array.transpose());