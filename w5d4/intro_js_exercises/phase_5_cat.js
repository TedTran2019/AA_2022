class Cat {
  constructor(name, owner) {
    this.name = name;
    this.owner = owner;
  }

  cuteStatement() {
    return `${this.owner} loves ${this.name}`;
  }
}

c1 = new Cat('Kitty', 'Ted');
c2 = new Cat('Not Kitty', 'Helen');
console.log(c1.cuteStatement());
console.log(c2.cuteStatement());
Cat.prototype.cuteStatement = function() {
  return `Everybody loves ${this.name}`
}
Cat.prototype.meow = function() {
  return 'Regular Meow';
}
console.log(c1.cuteStatement());
console.log(c2.cuteStatement());
c1.meow = function () {
  return 'SPECIAL SUPER MEOW';
}
console.log(c1.meow());
console.log(c2.meow());
