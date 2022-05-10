const MovingObject = require("./moving_object")
const Util = require("./utils")

const Asteroid = function({pos}) {
  MovingObject.call(this, {pos});
  this.vel = Util.randomVec(10);
  this.color = Asteroid.COLOR;
  this.radius = Asteroid.RADIUS;
}

Asteroid.COLOR = 'gray';
Asteroid.RADIUS = 25;

Util.inherits(Asteroid, MovingObject);

module.exports = Asteroid;