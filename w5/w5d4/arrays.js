var uniq = function(array) {
  var uniqArr = [];
  for (var i = 0; i < array.length; i++) {
    if(uniqArr.indexOf(array[i]) === -1) {
      uniqArr.push(array[i]);
    }
  }
  return uniqArr;
};

// console.log(uniq([1,1,3,1,4]));

var twosum = function(array) {
  var sums = [];
  for (var i = 0; i < array.length - 1; i++) {
    for (var j = i + 1; j < array.length; j++) {
      if (array[i] + array[j] === 0) {
        sums.push([i, j]);
      }
    }
  }
  return sums;
};

// console.log(twosum([-1, 0, 2, -2, 1]));

var myTranspose = function(matrix) {
  var transposedMatrix = [];
  for (var i = 0; i < matrix.length; i++) {
    transposedMatrix.push([]);
    for (var j = 0; j < matrix[0].length; j++) {
      transposedMatrix[i].push(matrix[j][i]);
    }
  }
  return transposedMatrix;
};

console.log(myTranspose([
    [0, 1, 2],
    [3, 4, 5],
    [6, 7, 8]
  ]));
