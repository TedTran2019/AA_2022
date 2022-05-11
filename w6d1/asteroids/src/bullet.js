const MovingObject = require("./moving_object");
const Util = require('./utils.js');

const Bullet = function ({ game, vel , pos}) {
  MovingObject.call(this, { game, vel, pos});
  this.radius = Bullet.RADIUS;
  this.color = Bullet.COLOR;
}
Util.inherits(Bullet, MovingObject);

Bullet.RADIUS = 5;
Bullet.COLOR = 'red';

Bullet.prototype.isWrappable = false;

module.exports = Bullet;