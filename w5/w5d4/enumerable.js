var arr = [1, 2, 3, 4, 5];

Array.prototype.myEach = function(f) {
  for(var i = 0; i < this.length; i++) {
    f(this[i]);
  }
  return this;
};

// arr.myEach(function(el) {
//     console.log(el*2);
// });

Array.prototype.myMap = function(f) {
  var newArr = [];
  this.myEach(function(el) {
    newArr.push(f(el));
  });
  return newArr;
};

// console.log(arr.myMap(function(el) {
//   return 2 * el;
// }));

Array.prototype.myInject = function(f) {
  var sum = this[0];
  var newArr = this.slice(1);
  newArr.myEach(function(el) {
    sum = f(sum, el);
  });
  return sum;
};

console.log(arr.myInject(function(sum, el){
  return sum * el;
}));
