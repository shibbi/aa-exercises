Function.prototype.inherits = function(obj) {
  function Surrogate() {};
  Surrogate.prototype = obj.prototype;
  this.prototype = new Surrogate();
};

function Animal(name) {
  this.name = name;
}

Animal.prototype.growl = function() {
  console.log(this.name + ' growls');
};

function Cat(name) {
  Animal.call(this, name);
}

Cat.inherits(Animal);


Cat.prototype.meow = function() {
  console.log(this.name + ' is a kitty who meows');
};



function Dog(name) {
  Animal.call(this, name);
}

Dog.inherits(Animal);

Dog.prototype.bark = function() {
  console.log(this.name + ' is a doge who barks');
};


var cat = new Cat('Cat');
var dog = new Dog('Dog');
cat.growl();
dog.growl();
cat.meow();
dog.bark();
