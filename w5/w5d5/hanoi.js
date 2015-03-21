var readline = require('readline');

var reader = readline.createInterface( {
  input: process.stdin,
  output: process.stdout
});

Array.prototype.equals = function(diffArr) {
  if (this.length !== diffArr.length) {
    return false;
  }
  for (var i = 0; i < this.length; i++) {
    if (this[i] !== diffArr[i]) {
      return false;
    }
  }
  return true;
};

Game.WINSTACK = [3, 2, 1];

function Game () {
  this.stacks = [Game.WINSTACK, [], []];
  this.moves = 0;
}

Game.prototype.isWon = function() {
  for (var i = 1; i < this.stacks.length; i++) {
    if(this.stacks[i].equals(Game.WINSTACK)) {
      return true;
    }
  }
  return false;
};

Game.prototype.isValidMove = function(start, end) {
  if (this.stacks[start].length === 0 ||
      start < 0 || start > 2 || end < 0 || end > 2) {
    return false;
  }
  var startStack = this.stacks[start];
  var endStack = this.stacks[end];
  var startDisc = startStack[startStack.length - 1];
  var endDisc = endStack[endStack.length - 1];
  if (startDisc > endDisc) {
    return false;
  }
  return true;
};

Game.prototype.move = function(start, end) {
  if (this.isValidMove(start, end)) {
    this.stacks[end].push(this.stacks[start].pop());
    this.moves++;
    return true;
  }
  return false;
};

Game.prototype.print = function() {
  for (var i = 0; i < this.stacks.length; i++) {
    console.log(JSON.stringify(this.stacks[i]));
  }
};

Game.prototype.promptMove = function(callback) {
  this.print();
  var fromStack;
  var toStack;
  reader.question('Where do you want to move a disc from? ', function(from) {
    fromStack = parseInt(from);
    reader.question('Where do you want to move a disc to? ', function(to) {
      toStack = parseInt(to);
      callback(fromStack, toStack);
    });
  });
};

Game.prototype.run = function(completionCallback) {
  var game = this;
  this.promptMove(function(from, to) {
    if (!game.move(from, to)) {
      console.log('Invalid move yo');
    }
    if (!game.isWon()) {
      game.run(completionCallback);
    } else {
      console.log('You won in ' + game.moves + ' moves. Good job.');
      completionCallback();
    }
  });
};
// Game.prototype.
// Game.prototype.
// Game.prototype.
// Game.prototype.
// Game.prototype.

var game = new Game();
game.run(function() {
  reader.close();
  game.print();
});
