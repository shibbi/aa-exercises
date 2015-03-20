function Cat(name, owner) {
  this.name = name;
  this.owner = owner;
}

Cat.prototype.cuteStatement = function() {
  return this.owner + ' loves ' + this.name;
};

var cat1 = new Cat('markov', 'ned');
var cat2 = new Cat('curie', 'ned');

// console.log(cat1.cuteStatement());
// console.log(cat2.cuteStatement());

Cat.prototype.cuteStatement = function() {
  return 'Everyone loves ' + this.name + '!';
};

// console.log(cat1.cuteStatement());
// console.log(cat2.cuteStatement());

Cat.prototype.meow = function() {
  return 'meow';
};

cat1.meow = function() {
  return this.name + ' says meow';
};

console.log(cat1.meow());
console.log(cat2.meow());
