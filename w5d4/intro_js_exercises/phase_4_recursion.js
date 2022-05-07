const range = function(start, end) {
  if (start >= end) { return [] };
  if (start == end - 1) { return [start] };

  return [start].concat(range(start + 1, end));
}

console.log(range(1, 10));

const sumRec = function(arr) {
  if (arr.length == 0) { return 0 };
  if (arr.length == 1) { return arr[0] };

  return arr.pop() + sumRec(arr);
}

console.log(sumRec([1, 2, 3, 4, 5]));

const exponent = function(base, exp) {
  if (exp == 0 ) { return 1 };
  if (exp == 1) { return base };

  return base * exponent(base, exp - 1);
}

console.log(exponent(2, 0));
console.log(exponent(2, 1));
console.log(exponent(2, 2));
console.log(exponent(2, 3));

const exponentBetter = function(base, exp) {
  if (exp == 0) { return 1 };
  if (exp == 1) { return base };

  let expo_half = Math.floor(exp / 2);
  if (exp % 2 == 0) {
    let val = exponentBetter(base, expo_half);
    return val * val;
  } else {
    let val = exponentBetter(base, expo_half);
    return base * val * val;
  }
}

console.log(exponentBetter(2, 0));
console.log(exponentBetter(2, 1));
console.log(exponentBetter(2, 2));
console.log(exponentBetter(2, 3));

const fibonacci = function(n) {
  let fibo = [0, 1];
  if (n < 3) { return fibo.slice(0, n)};

  let arr = fibonacci(n - 1);
  arr.push(arr[arr.length - 1] + arr[arr.length - 2]);
  return arr;
}

console.log(fibonacci(0));
console.log(fibonacci(1));
console.log(fibonacci(2));
console.log(fibonacci(10));

const deepDup = function(arr) {
  if (!(arr instanceof Array)) { return arr };
  let dup_arr = [];
  arr.forEach((el) => {
    if (el instanceof Array) {
      dup_arr.push(deepDup(el));
    } else {
      dup_arr.push(el);
    };
  });
  return dup_arr;
}

let dup_array = [[1, 2, 3], [4, 6, [4, 9]], [1, 2], 5];
console.log(deepDup(dup_array));

const bsearch = function(arr, target) {
  if (arr.length == 0) { return -1 };

  let half = Math.floor(arr.length / 2);
  if (arr[half] > target) {
    return bsearch(arr.slice(0, half), target);
  } else if (arr[half] == target) {
    return half;
  } else { 
    let idx = bsearch(arr.slice(half + 1, arr.length), target);
    return ((idx == -1) ? -1 : idx + half + 1);
  };
}

console.log(bsearch([1, 2, 3, 4, 5], 5));
console.log(bsearch([1, 2, 3, 4, 5], 6));
console.log(bsearch([1, 2, 3, 4, 5, 6, 7, 8, 9, 10], 10));

const merge = function(left, right) {
  let merged = [];
  while ((left.length > 0) && (right.length > 0)) {
    if (left[0] < right[0]) {
      merged.push(left.shift());
    } else {
      merged.push(right.shift());
    }
  }
  merged = merged.concat(left);
  merged = merged.concat(right);
  return merged;
}

const mergesort = function(arr) {
  if (arr.length == 0 || arr.length == 1) { return arr };

  let half = Math.floor(arr.length / 2);
  let left = mergesort(arr.slice(0, half));
  let right = mergesort(arr.slice(half, arr.length));

  return merge(left, right);
}

console.log(mergesort([8, 5, 2, 0, 12, 11, 13, 4, 2, 6, 5]));

const subsets = function(arr) {
  if (arr.length == 0) { return [[]] };

  let subsets_arr = subsets(arr.slice(0, arr.length - 1));
  let len = subsets_arr.length;
  let extra = arr[arr.length - 1];
  for (let i = 0; i < len; i++) {
    let sub = subsets_arr[i].slice();
    sub.push(extra);
    subsets_arr.push(sub);
  }
  return subsets_arr;
}

console.log(subsets([1, 2]));
console.log(subsets([1, 2, 3]));