const MovingObject = require('./moving_object.js');
const Asteroid = require('./asteroid.js');
window.MovingObject = MovingObject;

window.addEventListener('DOMContentLoaded', event => {
  const canvas = document.getElementById('game-canvas');
  const ctx = canvas.getContext('2d');
  const mo = new MovingObject({
    pos: [30, 30],
    vel: [10, 10],
    radius: 5,
    color: "#00FF00"
  });

  const asteroid = new Asteroid({
    pos: [100, 100]
  })
  mo.draw(ctx);
  mo.move();
  mo.move();
  mo.draw(ctx);
  asteroid.draw(ctx);
  asteroid.move();
  asteroid.draw(ctx);
});
console.log('Webpack is working!');