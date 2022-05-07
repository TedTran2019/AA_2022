Array.prototype.bubbleSort = function() {
  let sorted = false
  while (!sorted) {
    sorted = true;
    for(let i = 0; i < this.length - 1; i++) {
      if (this[i] > this[i + 1]) {
        sorted = false;
        [this[i], this[i + 1]] = [this[i + 1], this[i]];
      }
    }
  }
  return this;
}

console.log([3, 5, 1, 2, 7, 9, 8].bubbleSort());

String.prototype.substrings = function() {
  let substringsArr = [];
  for (let y = 0; y < this.length; y++) {
    for (let x = y; x < this.length; x++) {
      substringsArr.push(this.slice(y, x + 1));
    }
  }
  return substringsArr;
}

console.log('Cats'.substrings());