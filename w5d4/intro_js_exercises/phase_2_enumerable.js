Array.prototype.myEach = function (callback) {
  for (i = 0; i < this.length; i++) {
    callback(this[i]);
  }
};

[1, 2, 3].myEach((el) => {
  console.log(el);
})

Array.prototype.myMap = function (callback) {
  let newArr = [];
  for (i = 0; i < this.length; i++) {
    newArr.push(callback(this[i]));
  }
  return newArr;
};

let a = [1, 2, 3].myMap((el) => {
  return el * 2;
});

console.log(a);

Array.prototype.myReduce = function (callback, initialValue) {
  let i = 0;
  if (!(initialValue)) {
    initialValue = this[0];
    i++;
  }
  for (; i < this.length; i++) {
    initialValue = callback(initialValue, this[i]);
  }
  return initialValue;
};

b = [1, 2, 3].myReduce(function (acc, el) {
  return acc + el;
}); // 6

c = [1, 2, 3].myReduce(function (acc, el) {
  return acc + el;
}, 25); // 31

console.log(b);
console.log(c);