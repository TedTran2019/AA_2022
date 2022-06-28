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

eval("// Every method implemented will be applied to every node in the internal array.\nclass DomNodeCollection {\n  constructor(htmlElements) {\n    this.htmlElements = htmlElements;\n  }\n\n  // Empty string is false in Javascript\n  html(arg) {\n    if (arg === undefined) {\n      if (this.htmlElements.length > 0) {\n        return this.htmlElements[0].innerHTML;\n      }\n    } else {\n      this.htmlElements.forEach(el => {\n        el.innerHTML = arg;\n      });\n    }\n  }\n\n  empty() {\n    this.htmlElements.forEach(el => {\n      el.textContent = '';\n    })\n    // this.html('');\n  }\n\n  // Can copy jQuery's behavior here by not cloning the node\n  append(arg) {\n    if (arg instanceof DomNodeCollection) {\n      this.htmlElements.forEach(el => {\n        arg.htmlElements.forEach(child => {\n          el.appendChild(child.cloneNode(true));\n        });\n      });\n    } else if (arg instanceof HTMLElement) {\n      this.htmlElements.forEach(el => {\n        el.appendChild(arg.cloneNode(true));\n      })\n    } else if (typeof arg === 'string') {\n      this.htmlElements.forEach(el => {\n        // el.innerHTML += arg;\n        el.append(arg);\n      })\n    }\n  }\n\n  attr(name, value) {\n    if (value === undefined) {\n      if (this.htmlElements.length > 0) {\n        return this.htmlElements[0].getAttribute(name);\n      }\n    } else {\n      this.htmlElements.forEach(el => {\n        el.setAttribute(name, value);\n      });\n    }\n  }\n\n  addClass(className) {\n    this.htmlElements.forEach(el => {\n      el.classList.add(className);\n    })\n  }\n\n  removeClass(className) {\n    if (className === undefined) {\n      this.htmlElements.forEach(el => {\n        el.className = \"\";\n      })\n    } else {\n      this.htmlElements.forEach(el => {\n        el.classList.remove(className);\n      })\n    }\n  }\n\n  children() {\n    const children = [];\n    this.htmlElements.forEach(el => {\n      const eachChildren = el.children\n      for (let i = 0; i < eachChildren.length; i++) {\n        children.push(eachChildren[i]);\n      }\n    })\n    return new DomNodeCollection(children);\n  }\n\n  parent() {\n    const parents = []\n    this.htmlElements.forEach(el => {\n      parents.push(el.parentElement);\n    })\n    return new DomNodeCollection(parents);\n  }\n\n  find(selector) {\n    const found = [];\n    this.htmlElements.forEach(el => {\n      const foundChildren = el.querySelectorAll(selector);\n      for (let i = 0; i < foundChildren.length; i++) {\n        found.push(foundChildren[i]);\n      }\n    })\n    return new DomNodeCollection(found);\n  }\n\n  remove(selector) {\n    this.htmlElements.forEach(el => {\n      if (selector === undefined) {\n        el.remove();\n      } else {\n        const found = el.querySelectorAll(selector);\n        for (let i = 0; i < found.length; i++) {\n          found[i].remove();\n        }\n      }\n    })\n  }\n\n  on(event, handler) {\n    this.htmlElements.forEach(el => {\n      el.addEventListener(event, handler);\n      if (el.listen === undefined) {\n        el.listen = {};\n      }\n      if (el.listen[event] === undefined) {\n        el.listen[event] = [handler];\n      } else {\n        el.listen[event].push(handler);\n      }\n    })\n  }\n\n  // Handler not provided: remove all of type === event\n  // Event and handler not provided: remove all events\n  off(event, handler) {\n    if (event === undefined && handler === undefined) {\n      this.htmlElements.forEach(el => {\n        const listen = el.listen;\n        for (const elEvent in listen) {\n          listen[elEvent].forEach(elHandler => {\n            el.removeEventListener(elEvent, elHandler);\n          })\n        }\n        el.listen = undefined;\n      })\n    } else if (handler === undefined) {\n      this.htmlElements.forEach(el => {\n        const listen = el.listen;\n        listen[event].forEach(elHandler => {\n          el.removeEventListener(event, elHandler);\n        })\n        el.listen[event] = undefined;\n      })\n    } else {\n      this.htmlElements.forEach(el => {\n        const listen = el.listen;\n        const newArray = [];\n        listen[event].forEach(elHandler => {\n          if (elHandler.toString() !== handler.toString()) {\n            newArray.push(elHandler);\n          } else {\n            el.removeEventListener(event, elHandler);\n          }\n        })\n        el.listen[event] = newArray;\n      })\n    }\n  }\n}\n\nmodule.exports = DomNodeCollection;\n\n\n//# sourceURL=webpack:///./src/dom_node_collection.js?");

/***/ }),

/***/ "./src/index.js":
/*!**********************!*\
  !*** ./src/index.js ***!
  \**********************/
/***/ ((__unused_webpack_module, __unused_webpack_exports, __webpack_require__) => {

eval("const DomNodeCollection = __webpack_require__(/*! ./dom_node_collection */ \"./src/dom_node_collection.js\");\n\nlet isReady = false;\nlet readyCallbacks = [];\n\nwindow.$1 = function(selector) {\n  if (typeof selector === 'string') {\n    const nodeList = document.querySelectorAll(selector);\n    const nodesArray = Array.from(nodeList);\n    return new DomNodeCollection(nodesArray);\n  } else if (selector instanceof HTMLElement) {\n    return new DomNodeCollection([selector]);\n  } else if (typeof selector === 'function') {\n    // window.addEventListener('DOMContentLoaded', selector); Adds too many event listeners\n    if (isReady) {\n      selector();\n    } else {\n      readyCallbacks.push(selector);\n    }\n  }\n}\n\nwindow.$1.extend = function(objA, ...objects) {\n  objects.forEach(obj => {\n    for (key in obj) {\n      objA[key] = obj[key];\n    }\n  })\n  return objA;\n}\n\nwindow.$1.ajax = function(options) {\n  const defaults = {\n    // async: true,\n    contentType: 'application/x-www-form-urlencoded; charset=utf-8',\n    data: {},\n    // dataType: 'json',\n    // global: true,\n    // headers: {},\n    // ifModified: false,\n    method: 'GET',\n    // processData: true,\n    // statusCode: {},\n    // type: 'GET',\n    url: window.location.href,\n    success: () => {},\n    error: () => {}\n  }\n  options = $1.extend(defaults, options);\n  const xhr = new XMLHttpRequest();\n  xhr.open(options.method, options.url);\n  xhr.onload = function() {\n    let response = JSON.parse(xhr.response);\n    if (xhr.status === 200) {\n      options.success(response);\n    } else {\n      options.error(response);\n    }\n  }\n  xhr.send(options.data);\n}\n\nwindow.addEventListener('DOMContentLoaded', () => {\n  readyCallbacks.forEach(callback => callback());\n  isReady = true;\n})\n\n// html \n// window.$1('.test1').html()\n// window.$1('.test1').html('HELLO')\n// window.$1('.test1').html()\n// $('.test1').html()\n// $('.test1').html('GOODBYE')\n// $('.test1').html()\n\n// empty\n// window.$1('.test1').html('HELLO')\n// window.$1('.test1').empty()\n// $('.test1').html('HELLO')\n// $('.test1').empty()\n\n// append\n// a = 'hello';\n// b = document.querySelector('.test2')\n// c = window.$1('.test2')\n// d = $('.test2')\n// window.$1('.test1').append(a)\n// window.$1('.test1').append(b)\n// window.$1('.test1').append(c)\n// // jQuery Append moves the oject to the specified location instead of making a copy\n// $('.test1').append(a)\n// $('.test1').append(b)\n// $('.test1').append(d)\n\n// attr\n// name = 'name';\n// value = 'Steve';\n// window.$1('.test1').attr(name)\n// window.$1('.test1').attr(name, value)\n// window.$1('.test1').attr(name)\n\n// addClass\n// window.$1('.test1').addClass('testing')\n\n// removeClass\n// window.$1('.test1').addClass('testing')\n// window.$1('.test1').addClass('blargh')\n// window.$1('.test1').removeClass('potato')\n// window.$1('.test1').removeClass('testing')\n// window.$1('.test1').addClass('testing-again')\n// window.$1('.test1').removeClass()\n\n// children\n// window.$1('.test6').children()\n\n// parent\n// window.$1('.test1').parent()\n\n// find\n// window.$1('body').find('.test1')\n\n// remove\n// window.$1('.test6').remove()\n// window.$1('.test6').remove('.test7')\n\n// on\n// window.$1('.test1').on('click', () => { console.log('Hello') })\n// window.$1('.test1').htmlElements[0].listen.click[0]()\n\n// off\n// window.$1('.test1').on('click', () => { console.log('Hello') })\n// window.$1('.test1').on('click', () => { console.log('Goodbye') })\n// window.$1('.test1').on('mouseup', () => { console.log('Blargh') })\n// window.$1('.test1').htmlElements[0].listen\n// window.$1('.test1').off()\n// window.$1('.test1').htmlElements[0].listen\n// Re-setup Hello, Goodbye, Blargh\n// window.$1('.test1').off('click')\n// window.$1('.test1').htmlElements[0].listen\n// window.$1('.test1').off('mouseup', () => { console.log('Blargh') })\n// window.$1('.test1').htmlElements[0].listen\n\n// Testing $(function)\n// window.$1(() => alert(\"the document is ready\"));\n\n// Testing extend\n// const objA = { a: \"a\", b: \"a\", c: \"a\" };\n// const objB = { b: \"b\", c: \"b\" };\n// const objC = { c: \"c\" };\n// $l.extend(objA, objB, objC); \n// console.log(objA);\n\n// Testing ajax\n// window.$1.ajax({ success: () => { console.log('success') }, failure: () => { console.log('failure') } })\n\n//# sourceURL=webpack:///./src/index.js?");

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