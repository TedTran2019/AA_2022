const Asteroid = require("./asteroid");
const Ship = require("./ship");
const Bullet = require('./bullet');

const Game = function() {
  this.dimX = Game.DIM_X;
  this.dimY = Game.DIM_Y;
  this.numAsteroids = Game.NUM_ASTEROIDS;
  this.asteroids = [];
  this.ship = new Ship({game: this});
  this.bullets = [];
}

Game.prototype.addAsteroids = function() {
  for (let i = 0; i < Game.NUM_ASTEROIDS; i++) {
    let rand_pos = this.randomPosition();
    let new_asteroid = new Asteroid({pos: rand_pos, game: this});
    this.asteroids.push(new_asteroid);
  }
}

Game.prototype.randomPosition = function() {
  return [Math.floor(Math.random() * Game.DIM_X), Math.floor(Math.random() * Game.DIM_Y)]
}

Game.prototype.draw = function(ctx) {
  ctx.clearRect(0, 0, Game.DIM_X, Game.DIM_Y);
  this.allObjects().forEach(obj => {
    obj.draw(ctx);
  })
}

Game.prototype.moveObjects = function() {
  this.allObjects().forEach(obj => {
    obj.move();
  })
}

Game.prototype.wrap = function(pos) {
  if (pos[0] < 0) {
    pos[0] = Game.DIM_X - pos[0];
  } else {
    pos[0] = pos[0] % Game.DIM_X;
  }
  if (pos[1] < 0) {
    pos[1] = Game.DIM_Y - pos[1];
  } else {
    pos[1] = pos[1] % Game.DIM_Y;
  }
}

Game.prototype.checkCollisions = function() {
  let allObjs = this.allObjects();
  for (let y = 0; y < allObjs.length; y++) {
    for (let x = 0; x < allObjs.length; x++ ) {
      if (y === x) {
        continue;
      }
      if (allObjs[y].isCollidedWith(allObjs[x])) {
        allObjs[y].collideWith(allObjs[x]);
      }
    }
  }
}

Game.prototype.step = function() {
  this.moveObjects();
  this.checkCollisions();
}

Game.prototype.allObjects = function() {
  return this.asteroids.concat(this.bullets).concat([this.ship]);
}

Game.prototype.add = function(obj) {
  if (obj instanceof Asteroid) {
    this.asteroids.push(obj);
  } else if (obj instanceof Bullet) {
    this.bullets.push(obj);
  }
  console.log(this.bullets);
  console.log(this.allObjects());
}

Game.prototype.remove = function(obj) {
  if (obj instanceof Asteroid) {
    this.asteroids = this.asteroids.filter(asteroid => asteroid != obj);
  } else if (obj instanceof Bullet) {
    this.bullets = this.bullets.filter(bullet => bullet != obj);
  }
}

Game.prototype.isOutOfBounds = function(pos) {
  let x, y;
  [x, y] = pos;
  return x < 0 || y < 0 || x > Game.DIM_X || y > Game.DIM_Y
}

Game.DIM_X = 1200;
Game.DIM_Y = 1200;
Game.NUM_ASTEROIDS = 1;

module.exports = Game;