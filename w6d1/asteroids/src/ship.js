const Bullet = require("./bullet");
const MovingObject = require("./moving_object")
const Util = require("./utils")

const Ship = function({game}) {
  MovingObject.call(this, {game});
  this.pos = this.game.randomPosition();
  this.radius = Ship.RADIUS;
  this.color = Ship.COLOR;
  this.vel = [0, 0];
}
Util.inherits(Ship, MovingObject);

Ship.prototype.relocate = function() {
  this.pos = this.game.randomPosition();
  this.vel = [0, 0];
}

Ship.prototype.power = function(impulse) {
  this.vel[0] += impulse[0];
  this.vel[1] += impulse[1];
}

Ship.prototype.fireBullet = function() {
  let bullet_velocity = [...this.vel];
  bullet_velocity[0] *= 2;
  bullet_velocity[1] *= 2;
  let bullet = new Bullet({game: this.game, vel: bullet_velocity, pos: this.pos.slice()});
  this.game.add(bullet);
}

Ship.RADIUS = 10;
Ship.COLOR = 'red';

module.exports = Ship;