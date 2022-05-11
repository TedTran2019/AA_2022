/*
 * ATTENTION: The "eval" devtool has been used (maybe by default in mode: "development").
 * This devtool is neither made for production nor for readable output files.
 * It uses "eval()" calls to create a separate source file in the browser devtools.
 * If you are trying to read the output file, select a different devtool (https://webpack.js.org/configuration/devtool/)
 * or disable the default devtool with "devtool: false".
 * If you are looking for production-ready output files, see mode: "production" (https://webpack.js.org/configuration/mode/).
 */
/******/ (() => { // webpackBootstrap
/******/ 	var __webpack_modules__ = ({

/***/ "./src/asteroid.js":
/*!*************************!*\
  !*** ./src/asteroid.js ***!
  \*************************/
/***/ ((module, __unused_webpack_exports, __webpack_require__) => {

eval("const MovingObject = __webpack_require__(/*! ./moving_object */ \"./src/moving_object.js\");\nconst Ship = __webpack_require__(/*! ./ship */ \"./src/ship.js\");\nconst Util = __webpack_require__(/*! ./utils */ \"./src/utils.js\")\n\nconst Asteroid = function({pos, game}) {\n  MovingObject.call(this, {pos, game});\n  this.vel = Util.randomVec(10);\n  this.color = Asteroid.COLOR;\n  this.radius = Asteroid.RADIUS;\n}\n\nUtil.inherits(Asteroid, MovingObject);\n\nAsteroid.prototype.collideWith = function(otherObject) {\n  if (otherObject instanceof Ship) {\n    otherObject.relocate();\n  }\n}\n\nAsteroid.COLOR = 'gray';\nAsteroid.RADIUS = 25;\n\nmodule.exports = Asteroid;\n\n//# sourceURL=webpack:///./src/asteroid.js?");

/***/ }),

/***/ "./src/bullet.js":
/*!***********************!*\
  !*** ./src/bullet.js ***!
  \***********************/
/***/ ((module, __unused_webpack_exports, __webpack_require__) => {

eval("const MovingObject = __webpack_require__(/*! ./moving_object */ \"./src/moving_object.js\");\nconst Util = __webpack_require__(/*! ./utils.js */ \"./src/utils.js\");\n\nconst Bullet = function ({ game, vel , pos}) {\n  MovingObject.call(this, { game, vel, pos});\n  this.radius = Bullet.RADIUS;\n  this.color = Bullet.COLOR;\n}\nUtil.inherits(Bullet, MovingObject);\n\nBullet.RADIUS = 5;\nBullet.COLOR = 'red';\n\nmodule.exports = Bullet;\n\n//# sourceURL=webpack:///./src/bullet.js?");

/***/ }),

/***/ "./src/game.js":
/*!*********************!*\
  !*** ./src/game.js ***!
  \*********************/
/***/ ((module, __unused_webpack_exports, __webpack_require__) => {

eval("const Asteroid = __webpack_require__(/*! ./asteroid */ \"./src/asteroid.js\");\nconst Ship = __webpack_require__(/*! ./ship */ \"./src/ship.js\");\nconst Bullet = __webpack_require__(/*! ./bullet */ \"./src/bullet.js\");\n\nconst Game = function() {\n  this.dimX = Game.DIM_X;\n  this.dimY = Game.DIM_Y;\n  this.numAsteroids = Game.NUM_ASTEROIDS;\n  this.asteroids = [];\n  this.ship = new Ship({game: this});\n  this.bullets = [];\n}\n\nGame.prototype.addAsteroids = function() {\n  for (let i = 0; i < Game.NUM_ASTEROIDS; i++) {\n    let rand_pos = this.randomPosition();\n    let new_asteroid = new Asteroid({pos: rand_pos, game: this});\n    this.asteroids.push(new_asteroid);\n  }\n}\n\nGame.prototype.randomPosition = function() {\n  return [Math.floor(Math.random() * Game.DIM_X), Math.floor(Math.random() * Game.DIM_Y)]\n}\n\nGame.prototype.draw = function(ctx) {\n  ctx.clearRect(0, 0, Game.DIM_X, Game.DIM_Y);\n  this.allObjects().forEach(obj => {\n    obj.draw(ctx);\n  })\n}\n\nGame.prototype.moveObjects = function() {\n  this.allObjects().forEach(obj => {\n    obj.move();\n  })\n}\n\nGame.prototype.wrap = function(pos) {\n  if (pos[0] < 0) {\n    pos[0] = Game.DIM_X - pos[0];\n  } else {\n    pos[0] = pos[0] % Game.DIM_X;\n  }\n  if (pos[1] < 0) {\n    pos[1] = Game.DIM_Y - pos[1];\n  } else {\n    pos[1] = pos[1] % Game.DIM_Y;\n  }\n}\n\nGame.prototype.checkCollisions = function() {\n  let allObjs = this.allObjects();\n  for (let y = 0; y < allObjs.length; y++) {\n    for (let x = 0; x < allObjs.length; x++ ) {\n      if (y === x) {\n        continue;\n      }\n      if (allObjs[y].isCollidedWith(allObjs[x])) {\n        allObjs[y].collideWith(allObjs[x]);\n      }\n    }\n  }\n}\n\nGame.prototype.step = function() {\n  this.moveObjects();\n  this.checkCollisions();\n}\n\nGame.prototype.allObjects = function() {\n  return this.asteroids.concat(this.bullets).concat([this.ship]);\n}\n\nGame.prototype.add = function(obj) {\n  if (obj instanceof Asteroid) {\n    this.asteroids.push(obj);\n  } else if (obj instanceof Bullet) {\n    this.bullets.push(obj);\n  }\n  console.log(this.bullets);\n  console.log(this.allObjects());\n}\n\nGame.prototype.remove = function(obj) {\n  if (obj instanceof Asteroid) {\n    this.asteroids = this.asteroids.filter(asteroid => asteroid != obj);\n  } else if (obj instanceof Bullet) {\n    this.bullets = this.bullets.filter(bullet => bullet != obj);\n  }\n}\n\nGame.DIM_X = 1200;\nGame.DIM_Y = 1200;\nGame.NUM_ASTEROIDS = 1;\n\nmodule.exports = Game;\n\n//# sourceURL=webpack:///./src/game.js?");

/***/ }),

/***/ "./src/game_view.js":
/*!**************************!*\
  !*** ./src/game_view.js ***!
  \**************************/
/***/ ((module, __unused_webpack_exports, __webpack_require__) => {

eval("const Game = __webpack_require__(/*! ./game */ \"./src/game.js\");\n\nconst GameView = function(game, ctx) {\n  this.game = game;\n  this.ctx = ctx;\n}\n\nGameView.prototype.start = function() {\n  this.bindKeyHandlers();\n  this.animate();\n}\n\nGameView.prototype.animate = function() {\n  requestAnimationFrame(() => {\n    this.game.step();\n    this.game.draw(this.ctx);\n    this.animate();\n  })\n}\n\nGameView.prototype.bindKeyHandlers = function() {\n  key('d', () => { this.game.ship.power([1, 0]) });\n  key('a', () => { this.game.ship.power([-1, 0]) });\n  key('w', () => { this.game.ship.power([0, -1]) });\n  key('s', () => { this.game.ship.power([0, 1]) });\n  key('space', () => { this.game.ship.fireBullet() });\n}\n\nmodule.exports = GameView;\n\n//# sourceURL=webpack:///./src/game_view.js?");

/***/ }),

/***/ "./src/index.js":
/*!**********************!*\
  !*** ./src/index.js ***!
  \**********************/
/***/ ((__unused_webpack_module, __unused_webpack_exports, __webpack_require__) => {

eval("const MovingObject = __webpack_require__(/*! ./moving_object.js */ \"./src/moving_object.js\");\nconst Asteroid = __webpack_require__(/*! ./asteroid.js */ \"./src/asteroid.js\");\nconst GameView = __webpack_require__(/*! ./game_view.js */ \"./src/game_view.js\");\nconst Game = __webpack_require__(/*! ./game.js */ \"./src/game.js\");\nwindow.MovingObject = MovingObject;\n\nwindow.addEventListener('DOMContentLoaded', event => {\n  const canvas = document.getElementById('game-canvas');\n  const ctx = canvas.getContext('2d');\n  const g= new Game();\n  g.addAsteroids();\n  const gv = new GameView(g, ctx);\n  gv.start();\n});\nconsole.log('Webpack is working!');\n\n//# sourceURL=webpack:///./src/index.js?");

/***/ }),

/***/ "./src/moving_object.js":
/*!******************************!*\
  !*** ./src/moving_object.js ***!
  \******************************/
/***/ ((module, __unused_webpack_exports, __webpack_require__) => {

eval("const Util = __webpack_require__(/*! ./utils */ \"./src/utils.js\");\n\nconst MovingObject = function({pos, vel, radius, color, game}) {\n  this.pos = pos;\n  this.vel = vel;\n  this.radius = radius;\n  this.color = color;\n  this.game = game;\n}\n\nMovingObject.prototype.draw = function(ctx) {\n  ctx.beginPath();\n  ctx.arc(this.pos[0], this.pos[1], this.radius, 0, 2 * Math.PI);\n  ctx.stroke();\n  ctx.fillStyle = this.color;\n  ctx.fill();\n}\n\nMovingObject.prototype.move = function() {\n  this.pos[0] += this.vel[0];\n  this.pos[1] += this.vel[1];\n  this.game.wrap(this.pos);\n}\n\nMovingObject.prototype.isCollidedWith = function(otherObject) {\n  let radiiSum = this.radius + otherObject.radius;\n  let distance = Util.distance(this.pos, otherObject.pos);\n  return distance < radiiSum;\n}\n\nMovingObject.prototype.collideWith = function(otherObject) {\n  // this.game.remove(this);\n  // this.game.remove(otherObject);\n}\n\nmodule.exports = MovingObject;\n\n//# sourceURL=webpack:///./src/moving_object.js?");

/***/ }),

/***/ "./src/ship.js":
/*!*********************!*\
  !*** ./src/ship.js ***!
  \*********************/
/***/ ((module, __unused_webpack_exports, __webpack_require__) => {

eval("const Bullet = __webpack_require__(/*! ./bullet */ \"./src/bullet.js\");\nconst MovingObject = __webpack_require__(/*! ./moving_object */ \"./src/moving_object.js\")\nconst Util = __webpack_require__(/*! ./utils */ \"./src/utils.js\")\n\nconst Ship = function({game}) {\n  MovingObject.call(this, {game});\n  this.pos = this.game.randomPosition();\n  this.radius = Ship.RADIUS;\n  this.color = Ship.COLOR;\n  this.vel = [0, 0];\n}\nUtil.inherits(Ship, MovingObject);\n\nShip.prototype.relocate = function() {\n  this.pos = this.game.randomPosition();\n  this.vel = [0, 0];\n}\n\nShip.prototype.power = function(impulse) {\n  this.vel[0] += impulse[0];\n  this.vel[1] += impulse[1];\n}\n\nShip.prototype.fireBullet = function() {\n  let bullet_velocity = [...this.vel];\n  bullet_velocity[0] *= 2;\n  bullet_velocity[1] *= 2;\n  let bullet = new Bullet({game: this.game, vel: bullet_velocity, pos: this.pos.slice()});\n  this.game.add(bullet);\n}\n\nShip.RADIUS = 10;\nShip.COLOR = 'red';\n\nmodule.exports = Ship;\n\n//# sourceURL=webpack:///./src/ship.js?");

/***/ }),

/***/ "./src/utils.js":
/*!**********************!*\
  !*** ./src/utils.js ***!
  \**********************/
/***/ ((module) => {

eval("const Util = {\n  inherits: function inherits(childClass, parentClass) {\n    childClass.prototype = Object.create(parentClass.prototype);\n    childClass.prototype.constructor = childClass;\n  },\n\n  randomVec: function randomVec(length) {\n    const deg = 2 * Math.PI * Math.random();\n    return Util.scale([Math.sin(deg), Math.cos(deg)], length);\n  },\n\n  scale: function scale(vec, m) {\n    return [vec[0] * m, vec[1] * m];\n  },\n\n  distance: function distance(pos1, pos2) {\n    let x = pos1[0] - pos2[0];\n    let y = pos1[1] - pos2[1];\n    return Math.sqrt((x * x) + (y * y))\n  }\n}\n\nmodule.exports = Util;\n\n//# sourceURL=webpack:///./src/utils.js?");

/***/ })

/******/ 	});
/************************************************************************/
/******/ 	// The module cache
/******/ 	var __webpack_module_cache__ = {};
/******/ 	
/******/ 	// The require function
/******/ 	function __webpack_require__(moduleId) {
/******/ 		// Check if module is in cache
/******/ 		var cachedModule = __webpack_module_cache__[moduleId];
/******/ 		if (cachedModule !== undefined) {
/******/ 			return cachedModule.exports;
/******/ 		}
/******/ 		// Create a new module (and put it into the cache)
/******/ 		var module = __webpack_module_cache__[moduleId] = {
/******/ 			// no module.id needed
/******/ 			// no module.loaded needed
/******/ 			exports: {}
/******/ 		};
/******/ 	
/******/ 		// Execute the module function
/******/ 		__webpack_modules__[moduleId](module, module.exports, __webpack_require__);
/******/ 	
/******/ 		// Return the exports of the module
/******/ 		return module.exports;
/******/ 	}
/******/ 	
/************************************************************************/
/******/ 	
/******/ 	// startup
/******/ 	// Load entry module and return exports
/******/ 	// This entry module can't be inlined because the eval devtool is used.
/******/ 	var __webpack_exports__ = __webpack_require__("./src/index.js");
/******/ 	
/******/ })()
;