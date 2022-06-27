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

/***/ "./src/dom_node_collection.js":
/*!************************************!*\
  !*** ./src/dom_node_collection.js ***!
  \************************************/
/***/ ((module) => {

eval("// Every method implemented will be applied to every node in the internal array.\nclass DomNodeCollection {\n  constructor(htmlElements) {\n    this.htmlElements = htmlElements;\n  }\n\n  // Empty string is false in Javascript\n  html(arg) {\n    if (arg === undefined) {\n      if (this.htmlElements.length === 1) {\n        return this.htmlElements[0].innerHTML;\n      }\n    } else {\n      this.htmlElements.forEach(el => {\n        el.innerHTML = arg;\n      });\n    }\n  }\n\n  empty() {\n    this.htmlElements.forEach(el => {\n      el.textContent = '';\n    })\n    // this.html('');\n  }\n\n  // Can copy jQuery's behavior here by not cloning the node\n  append(arg) {\n    if (arg instanceof DomNodeCollection) {\n      this.htmlElements.forEach(el => {\n        arg.htmlElements.forEach(child => {\n          el.appendChild(child.cloneNode(true));\n        });\n      });\n    } else if (arg instanceof HTMLElement) {\n      this.htmlElements.forEach(el => {\n        el.appendChild(arg.cloneNode(true));\n      })\n    } else if (typeof arg === 'string') {\n      this.htmlElements.forEach(el => {\n        // el.innerHTML += arg;\n        el.append(arg);\n      })\n    }\n  }\n\n  attr() {\n\n  }\n\n  addClass() {\n\n  }\n\n  removeClass() {\n\n  }\n\n  children() {\n\n  }\n\n  parent() {\n\n  }\n\n  find() {\n\n  }\n\n  remove() {\n\n  }\n\n  on() {\n\n  }\n\n  off() {\n\n  }\n}\n\nmodule.exports = DomNodeCollection;\n\n\n//# sourceURL=webpack:///./src/dom_node_collection.js?");

/***/ }),

/***/ "./src/index.js":
/*!**********************!*\
  !*** ./src/index.js ***!
  \**********************/
/***/ ((__unused_webpack_module, __unused_webpack_exports, __webpack_require__) => {

eval("const DomNodeCollection = __webpack_require__(/*! ./dom_node_collection */ \"./src/dom_node_collection.js\");\n\nwindow.$1 = function(selector) {\n  if (typeof selector === 'string') {\n    const nodeList = document.querySelectorAll(selector);\n    const nodesArray = Array.from(nodeList);\n    return new DomNodeCollection(nodesArray);\n  } else if (selector instanceof HTMLElement) {\n    return new DomNodeCollection([selector]);\n  } else if (typeof selector === 'function') {\n    window.addEventListener('DOMContentLoaded', selector);\n  }\n}\n\n// html \n// window.$1('.test1').html()\n// window.$1('.test1').html('HELLO')\n// window.$1('.test1').html()\n// $('.test1').html()\n// $('.test1').html('GOODBYE')\n// $('.test1').html()\n\n// empty\n// window.$1('.test1').html('HELLO')\n// window.$1('.test1').empty()\n// $('.test1').html('HELLO')\n// $('.test1').empty()\n\n// append\na = 'hello';\nb = document.querySelector('.test2')\nc = window.$1('.test2')\nd = $('.test2')\nwindow.$1('.test1').append(a)\nwindow.$1('.test1').append(b)\nwindow.$1('.test1').append(c)\n// jQuery Append moves the oject to the specified location instead of making a copy\n$('.test1').append(a)\n$('.test1').append(b)\n$('.test1').append(d)\n\n//# sourceURL=webpack:///./src/index.js?");

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