var bubbleSort = function(arr) {
  var sorted = false;
  while (!sorted) {
    sorted = true;
    for (var i = 0; i < arr.length - 1; i++) {
      if (arr[i] > arr[i + 1]) {
        var temp = arr[i];
        arr[i] = arr[i + 1];
        arr[i + 1] = temp;
        sorted = false;
      }
    }
  }
  return arr;
};

// var arr = [1, 5, -3, -4, 100, 1, 2];
// console.log(bubbleSort(arr));

var substrings = function(str) {
  var subs = [];
  for (var i = 0; i < str.length; i++) {
    for (var j = i; j < str.length; j++) {
      subs.push(str.substring(i, j + 1));
    }
  }
  return subs;
};

// console.log(substrings("cat"));
