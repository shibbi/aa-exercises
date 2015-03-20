var range = function(start, end) {
  if (end < start) {
    return [];
  }
  return [start].concat(range(start + 1, end));
};

// console.log(range(1, 5));

var sum = function(array) {
  if (array.length === 0) {
    return 0;
  }
  return array[0] + sum(array.slice(1));
};

// console.log(sum([4, 2, 3, 5, 4]));

var exp1 = function(base, pow) {
  if (pow === 0) {
    return 1;
  }
  return base * exp1(base, pow - 1);
};

var exp2 = function(base, pow) {
  if (pow === 0) {
    return 1;
  }
  if (pow === base) {
    return base;
  }
  if (pow % 2 === 0) {
    var factor = exp2(base, pow / 2);
    return factor * factor;
  }
  else {
    var factor = exp2(base, (pow - 1)/ 2);
    return base * factor * factor;
  }
};

// console.log(exp1(2, 6));
// console.log(exp2(2, 6));

var fibonacci = function(n) {
  if (n === 0) {
    return [];
  }
  if (n === 1) {
    return [1];
  }
  if (n === 2) {
    return [1, 1];
  }
  var prevFib = fibonacci(n - 1);
  var length = prevFib.length;
  return prevFib.concat([prevFib[length - 1] + prevFib[length - 2]]);
};

// console.log(fibonacci(5));

var bsearch = function(array, target) {
  if (array.length === 0) {
    return -1;
  }
  if (array.length === 1) {
    if (array[0] === target) {
      return 0;
    } else {
      return -1;
    }
  }
  var midpoint = Math.floor(array.length / 2);
  var leftFound = bsearch(array.slice(0, midpoint), target);
  if (leftFound > -1) {
    return leftFound;
  } else {
    var rightFound = bsearch(array.slice(midpoint), target);
    if (rightFound > -1) {
      return midpoint + rightFound;
    }
  }
  return -1;
};

// console.log(bsearch([1, 2, 3], 1));
// console.log(bsearch([2, 3, 4, 5], 3));
// console.log(bsearch([2, 4, 6, 8, 10], 6));
// console.log(bsearch([1, 3, 4, 5, 9], 5));
// console.log(bsearch([1, 2, 3, 4, 5, 6], 6));
// console.log(bsearch([1, 2, 3, 4, 5, 6], 0));
// console.log(bsearch([1, 2, 3, 4, 5, 7], 6));

var makeChange = function(total, coins) {
  if (total === 0) {
    return [];
  }
  var leastCoins = [];
  for (var i = 0; i < coins.length; i++) {
    var currentCoins = [];
    if (total >= coins[i]) {
      currentCoins.push(coins[i]);
      currentCoins = currentCoins.concat(makeChange(total - coins[i], coins));
      if (leastCoins.length === 0 || currentCoins.length < leastCoins.length) {
        leastCoins = currentCoins;
      }
    }
  }
  return leastCoins;
};

// console.log(makeChange(33, [15, 10, 5, 1]));

var mergeSort = function(array) {
  if (array.length < 2) {
    return array;
  }
  var pivot = Math.floor(array.length / 2);
  var leftSorted = mergeSort(array.slice(0, pivot));
  var rightSorted = mergeSort(array.slice(pivot));
  return merge(leftSorted, rightSorted);
};

var merge = function(left, right) {
  var sortedArr = [];
  while (left.length > 0 && right.length > 0) {
    if (left[0] < right[0]) {
      sortedArr.push(left[0]);
      left = left.slice(1);
    } else {
      sortedArr.push(right[0]);
      right = right.slice(1);
    }
  }
  return sortedArr.concat(left.concat(right));
};

// console.log(mergeSort([3, 4, -1, 5, 6, 1]));

var subsets = function(array) {
  if (array.length < 1) {
    return [[]];
  }
  var smallerSubsets = subsets(array.slice(0, array.length - 1));
  var newSubsets = [].concat(smallerSubsets);
  for (var i = 0; i < smallerSubsets.length; i++) {
    var smallerSubset = smallerSubsets[i].slice(0);
    smallerSubset.push(array[array.length - 1]);
    newSubsets.push(smallerSubset);
  }
  return newSubsets;
};

// console.log(subsets([]));
// console.log(subsets([1]));
// console.log(subsets([1, 2]));
// console.log(subsets([1, 2, 3]));
