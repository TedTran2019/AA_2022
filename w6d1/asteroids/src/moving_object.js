const Util = require("./utils");

const MovingObject = function({pos, vel, radius, color, game}) {
  this.pos = pos;
  this.vel = vel;
  this.radius = radius;
  this.color = color;
  this.game = game;
}

MovingObject.prototype.draw = function(ctx) {
  ctx.beginPath();
  ctx.arc(this.pos[0], this.pos[1], this.radius, 0, 2 * Math.PI);
  ctx.stroke();
  ctx.fillStyle = this.color;
  ctx.fill();
}

MovingObject.prototype.move = function() {
  this.pos[0] += this.vel[0];
  this.pos[1] += this.vel[1];
  if ((!this.isWrappable) && this.game.isOutOfBounds(this.pos)) {
    this.game.remove(this);
  } else {
    this.game.wrap(this.pos);
  }
}

MovingObject.prototype.isCollidedWith = function(otherObject) {
  let radiiSum = this.radius + otherObject.radius;
  let distance = Util.distance(this.pos, otherObject.pos);
  return distance < radiiSum;
}

MovingObject.prototype.collideWith = function(otherObject) {
  // this.game.remove(this);
  // this.game.remove(otherObject);
}

MovingObject.prototype.isWrappable = true;

module.exports = MovingObject;