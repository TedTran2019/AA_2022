const MovingObject = require("./moving_object");
const Ship = require("./ship");
const Util = require("./utils");
const Bullet = require('./bullet');

const Asteroid = function({pos, game}) {
  MovingObject.call(this, {pos, game});
  this.vel = Util.randomVec(10);
  this.color = Asteroid.COLOR;
  this.radius = Asteroid.RADIUS;
}

Util.inherits(Asteroid, MovingObject);

Asteroid.prototype.collideWith = function(otherObject) {
  if (otherObject instanceof Ship) {
    otherObject.relocate();
  } else if (otherObject instanceof Bullet) {
    this.game.remove(this);
    this.game.remove(otherObject);
  }
}

Asteroid.COLOR = 'gray';
Asteroid.RADIUS = 25;

module.exports = Asteroid;