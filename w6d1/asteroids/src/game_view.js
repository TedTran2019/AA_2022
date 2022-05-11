const Game = require("./game");

const GameView = function(game, ctx) {
  this.game = game;
  this.ctx = ctx;
}

GameView.prototype.start = function() {
  this.bindKeyHandlers();
  this.animate();
}

GameView.prototype.animate = function() {
  requestAnimationFrame(() => {
    this.game.step();
    this.game.draw(this.ctx);
    this.animate();
  })
}

GameView.prototype.bindKeyHandlers = function() {
  key('d', () => { this.game.ship.power([1, 0]) });
  key('a', () => { this.game.ship.power([-1, 0]) });
  key('w', () => { this.game.ship.power([0, -1]) });
  key('s', () => { this.game.ship.power([0, 1]) });
  key('space', () => { this.game.ship.fireBullet() });
}

module.exports = GameView;