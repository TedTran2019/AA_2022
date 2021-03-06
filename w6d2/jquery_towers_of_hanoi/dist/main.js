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

/***/ "./src/game.js":
/*!*********************!*\
  !*** ./src/game.js ***!
  \*********************/
/***/ ((module) => {

eval("class Game {\n  constructor() {\n    this.towers = [[3, 2, 1], [], []];\n  }\n\n  isValidMove(startTowerIdx, endTowerIdx) {\n      const startTower = this.towers[startTowerIdx];\n      const endTower = this.towers[endTowerIdx];\n\n      if (startTower.length === 0) {\n        return false;\n      } else if (endTower.length == 0) {\n        return true;\n      } else {\n        const topStartDisc = startTower[startTower.length - 1];\n        const topEndDisc = endTower[endTower.length - 1];\n        return topStartDisc < topEndDisc;\n      }\n  }\n\n  isWon() {\n      // move all the discs to the last or second tower\n      return (this.towers[2].length == 3) || (this.towers[1].length == 3);\n  }\n\n  move(startTowerIdx, endTowerIdx) {\n      if (this.isValidMove(startTowerIdx, endTowerIdx)) {\n        this.towers[endTowerIdx].push(this.towers[startTowerIdx].pop());\n        return true;\n      } else {\n        return false;\n      }\n  }\n\n  print() {\n      console.log(JSON.stringify(this.towers));\n  }\n\n  promptMove(reader, callback) {\n      this.print();\n      reader.question(\"Enter a starting tower: \", start => {\n        const startTowerIdx = parseInt(start);\n        reader.question(\"Enter an ending tower: \", end => {\n          const endTowerIdx = parseInt(end);\n          callback(startTowerIdx, endTowerIdx);\n        });\n      });\n  }\n\n  run(reader, gameCompletionCallback) {\n      this.promptMove(reader, (startTowerIdx, endTowerIdx) => {\n        if (!this.move(startTowerIdx, endTowerIdx)) {\n          console.log(\"Invalid move!\");\n        }\n\n        if (!this.isWon()) {\n          // Continue to play!\n          this.run(reader, gameCompletionCallback);\n        } else {\n          this.print();\n          console.log(\"You win!\");\n          gameCompletionCallback();\n        }\n      });\n  }\n}\n\nmodule.exports = Game;\n\n\n//# sourceURL=webpack:///./src/game.js?");

/***/ }),

/***/ "./src/hanoiView.js":
/*!**************************!*\
  !*** ./src/hanoiView.js ***!
  \**************************/
/***/ ((module) => {

eval("class HanoiView {\n  constructor(game, $rootel) {\n    this.game = game;\n    this.$rootel = $rootel;\n    this.fromTower = null;\n    this.setupTowers();\n    this.render();\n    this.clickTower();\n  }\n\n  setupTowers() {\n    for (let i = 0; i < 3; i++) {\n      const $ul = $('<ul>');\n      $ul.addClass('tower');\n      $ul.data('tower', i);\n      $ul.data('discs', []);\n      if (i === 0) {\n        $ul.data('discs').push(3, 2, 1);\n      }\n      this.$rootel.append($ul);\n    }\n    const $uls = $('.tower');\n    $uls.hover((e) => {\n      $(e.currentTarget).addClass('blue');\n    }, (e) => {\n      $(e.currentTarget).removeClass('blue');\n    })\n  }\n\n  render() {\n    const $uls = $('.tower');\n    $uls.each((idx, ul) => {\n      const $ul = $(ul);\n      const discs = $ul.data('discs');\n      $ul.empty();\n      discs.forEach(disc => {\n        const $li = $('<li>');\n        $li.addClass('disc');\n        if (disc === 3) {\n          $li.css('width', '100%');\n        } else if (disc === 2) {\n          $li.css('width', '80%');\n        } else {\n          $li.css('width', '60%');\n        }\n        $ul.append($li);\n      });\n    });\n  }\n\n  clickTower() {\n    const $uls = $('.tower');\n    $uls.on('click', (e) => {\n      const $tower = $(e.currentTarget);\n      if (this.fromTower === null) {\n        this.fromTower = $tower\n        this.fromTower.toggleClass('selected');\n      } else {\n        const fromTowerIdx = this.fromTower.data('tower');\n        const toTowerIdx = $tower.data('tower');\n        if (this.game.move(fromTowerIdx, toTowerIdx)) {\n          let from = this.fromTower.data('discs').pop();\n          $tower.data('discs').push(from);\n          this.render();\n        } else {\n          alert('Invalid move!');\n        }\n        this.fromTower.toggleClass('selected');\n        this.fromTower = null;\n        if (this.game.isWon()) {\n          $uls.off('click');\n          $uls.off('mouseenter mouseleave');\n          $uls.css('border-color', 'black');\n          $('.disc').css('background-color', 'green');\n          alert('You win!');\n        }\n      }\n    })\n  }\n};\n\nmodule.exports = HanoiView;\n\n//# sourceURL=webpack:///./src/hanoiView.js?");

/***/ }),

/***/ "./src/index.js":
/*!**********************!*\
  !*** ./src/index.js ***!
  \**********************/
/***/ ((__unused_webpack_module, __unused_webpack_exports, __webpack_require__) => {

eval("const HanoiGame = __webpack_require__(/*! ./game.js */ \"./src/game.js\");\nconst HanoiView = __webpack_require__(/*! ./hanoiView.js */ \"./src/hanoiView.js\");\n$(() => {\n  const rootEl = $('.hanoi');\n  const game = new HanoiGame();\n  new HanoiView(game, rootEl);\n  console.log(\"hello\");\n});\n\n\n//# sourceURL=webpack:///./src/index.js?");

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