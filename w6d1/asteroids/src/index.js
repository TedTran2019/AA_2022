const MovingObject = require('./moving_object.js');
const Asteroid = require('./asteroid.js');
const GameView = require('./game_view.js');
const Game = require('./game.js');
window.MovingObject = MovingObject;

window.addEventListener('DOMContentLoaded', event => {
  const canvas = document.getElementById('game-canvas');
  const ctx = canvas.getContext('2d');
  const g= new Game();
  g.addAsteroids();
  const gv = new GameView(g, ctx);
  gv.start();
});
console.log('Webpack is working!');