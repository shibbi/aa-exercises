function sum() {
  var total = 0;
  for(var i = 0; i < arguments.length; i++) {
    total += arguments[i];
  }
  return total;
}

// console.log(sum(1,2,3,4,5));


Function.prototype.myBind = function(obj) {
  var args = Array.prototype.slice.call(arguments, 1);
  var that = this;
  return function() {
    var args2 = Array.prototype.slice.call(arguments);
    args = args.concat(args2);
    that.apply(obj, args);
  };
};

var arr = [1,2,3,4];

function test() {
  console.log('Array:');
  for (var i = 0; i < this.length; i++) {
    console.log(this[i]);
  }
  console.log('Extra arguments:');
  for (var i = 0; i < arguments.length; i++) {
    console.log(arguments[i]);
  }
}

var boundTest = test.myBind(arr, 2, 3, 2);
// boundTest(3);

function curriedSum(numArgs) {
  var numbers = [];
  return function _curriedSum(num) {
    numbers.push(num);
    if (numbers.length === numArgs) {
      var sum = 0;
      for (var i = 0; i < numbers.length; i++) {
        sum += numbers[i];
      }
      return sum;
    } else {
      return _curriedSum;
    }
  };
}

// var sum = curriedSum(4);
// console.log(sum(5)(30)(20)(1));

Function.prototype.curry = function(numArgs) {
  var args = [];
  var that = this;
  return function _curry() {
    args = args.concat(Array.prototype.slice.call(arguments));
    if (args.length === numArgs) {
      return that.apply(this, args);
    } else {
      return _curry;
    }
  };
};

// var currySum = sum.curry(5);
// console.log(currySum(1, 2)(4, 3)(3));
