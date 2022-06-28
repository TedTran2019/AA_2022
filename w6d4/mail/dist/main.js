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

/***/ "./src/compose.js":
/*!************************!*\
  !*** ./src/compose.js ***!
  \************************/
/***/ ((module, __unused_webpack_exports, __webpack_require__) => {

eval("const MessageStore = __webpack_require__(/*! ./message_store */ \"./src/message_store.js\");\n\nclass Compose {\n  constructor() {\n    this.messageStore = new MessageStore();\n  }\n\n  render() {\n    const div = document.createElement('div');\n    div.addEventListener('submit', event => {\n      event.preventDefault();\n      this.messageStore.sendDraft();\n      window.location.hash = '#inbox';\n    })\n    div.addEventListener('change', event => {\n      this.messageStore.updateDraftField(event.target.name, event.target.value);\n    })\n    div.classList.add('new-message');\n    div.innerHTML = this.renderForm();\n    return div;\n  }\n\n  renderForm() {\n    const messageDraft = this.messageStore.getMessageDraft();\n    const form = `\n      <p class=\"new-message-header\">New Message</p>\n      <form class=\"compose-form\">\n        <input placeholder=\"Recipient\" name=\"to\" type=\"text\" value=\"${messageDraft.to}\">\n        <input placeholder=\"Subject\" name=\"subject\" type=\"text\" value=\"${messageDraft.subject}\">\n        <textarea name=\"body\" rows=\"20\">${messageDraft.body}</textarea>\n        <button type=\"submit\" class=\"btn btn-primary submit-message\">Send</button>\n      </form>\n    `\n    return form;\n  }\n}\n\nmodule.exports = Compose;\n\n//# sourceURL=webpack://mail/./src/compose.js?");

/***/ }),

/***/ "./src/inbox.js":
/*!**********************!*\
  !*** ./src/inbox.js ***!
  \**********************/
/***/ ((module, __unused_webpack_exports, __webpack_require__) => {

eval("const MessageStore = __webpack_require__(/*! ./message_store */ \"./src/message_store.js\");\n\nclass Inbox {\n  constructor() {\n    this.messageStore = new MessageStore();\n  }\n\n  render() {\n    const ul = document.createElement('ul');\n    ul.classList.add('messages');\n    this.messageStore.getInboxMessages().forEach((message) => {\n      ul.appendChild(this.renderMessage(message));\n    })\n    return ul;\n  }\n\n  renderMessage(message) {\n    const li = document.createElement('li');\n    li.classList.add('message');\n    li.innerHTML = `<span class=\"from\">${message.from}</span>\n                    <span class=\"subject\">${message.subject}</span>\n                    <span class=\"body\">${message.body}</span>`;\n    return li;\n  }\n}\n\nmodule.exports = Inbox;\n\n//# sourceURL=webpack://mail/./src/inbox.js?");

/***/ }),

/***/ "./src/index.js":
/*!**********************!*\
  !*** ./src/index.js ***!
  \**********************/
/***/ ((__unused_webpack_module, __unused_webpack_exports, __webpack_require__) => {

eval("const Router = __webpack_require__(/*! ./router */ \"./src/router.js\");\nconst Inbox = __webpack_require__(/*! ./inbox */ \"./src/inbox.js\");\nconst Sent = __webpack_require__(/*! ./sent */ \"./src/sent.js\");\nconst Compose = __webpack_require__(/*! ./compose */ \"./src/compose.js\");\n\nwindow.addEventListener('DOMContentLoaded', () => {\n  const sidebarNavLis = document.querySelectorAll('.sidebar-nav li');\n  const content = document.querySelector('.content');\n  new Router(content, routes).start();\n  window.location.hash = '#inbox';\n  sidebarNavLis.forEach((li) => {\n    li.addEventListener('click', (event) => {\n      const newUrl = event.target.innerText.toLowerCase();\n      window.location.hash = newUrl;\n    })\n  })\n})\n\nconst routes = {\n  inbox: new Inbox,\n  sent: new Sent,\n  compose: new Compose\n}\n\n\n//# sourceURL=webpack://mail/./src/index.js?");

/***/ }),

/***/ "./src/message_store.js":
/*!******************************!*\
  !*** ./src/message_store.js ***!
  \******************************/
/***/ ((module) => {

eval("let messages = {\n  sent: [\n    {\n      to: \"friend@mail.com\",\n      subject: \"Check this out\",\n      body: \"It's so cool\"\n    },\n    { to: \"person@mail.com\", subject: \"zzz\", body: \"so booring\" }\n  ],\n  inbox: [\n    {\n      from: \"grandma@mail.com\",\n      subject: \"Fwd: Fwd: Fwd: Check this out\",\n      body:\n        \"Stay at home mom discovers cure for leg cramps. Doctors hate her\"\n    },\n    {\n      from: \"person@mail.com\",\n      subject: \"Questionnaire\",\n      body: \"Take this free quiz win $1000 dollars\"\n    }\n  ]\n};\n\nclass MessageStore {\n  constructor() {\n  }\n\n  getInboxMessages() {\n    return messages.inbox;\n  }\n\n  getSentMessages() {\n    return messages.sent;\n  }\n\n  updateDraftField(field, value) {\n    messageDraft[field] = value;\n  }\n\n  sendDraft() {\n    messages.sent.push(messageDraft);\n    messageDraft = new Message(\"\", \"\", \"\", \"\");\n  }\n\n  getMessageDraft() {\n    return messageDraft;\n  }\n}\n\nclass Message {\n  constructor(from, to, subject, body) {\n    this.from = from;\n    this.to = to;\n    this.subject = subject;\n    this.body = body;\n  }\n}\n\nlet messageDraft = new Message(\"\", \"\", \"\", \"\");\n\nmodule.exports = MessageStore;\n\n\n//# sourceURL=webpack://mail/./src/message_store.js?");

/***/ }),

/***/ "./src/router.js":
/*!***********************!*\
  !*** ./src/router.js ***!
  \***********************/
/***/ ((module) => {

eval("class Router {\n  constructor(node, routes) {\n    this.node = node;\n    this.routes = routes;\n  }\n\n  start() {\n    this.render();\n    window.addEventListener('hashchange', (event) => {\n      this.render();\n    })\n  }\n\n  activeRoute() {\n    return this.routes[window.location.hash.slice(1)];\n  }\n\n  render() {\n    this.node.innerHTML = \"\";\n    const component = this.activeRoute();\n    if (component) {\n      this.node.appendChild(component.render());\n    }\n  }\n}\n\nmodule.exports = Router;\n\n//# sourceURL=webpack://mail/./src/router.js?");

/***/ }),

/***/ "./src/sent.js":
/*!*********************!*\
  !*** ./src/sent.js ***!
  \*********************/
/***/ ((module, __unused_webpack_exports, __webpack_require__) => {

eval("const MessageStore = __webpack_require__(/*! ./message_store */ \"./src/message_store.js\");\n\nclass Sent {\n  constructor() {\n    this.messageStore = new MessageStore();\n  }\n\n  render() {\n    const ul = document.createElement('ul');\n    ul.classList.add('messages');\n    this.messageStore.getSentMessages().forEach((message) => {\n      ul.appendChild(this.renderMessage(message));\n    })\n    return ul;\n  }\n\n  renderMessage(message) {\n    const li = document.createElement('li');\n    li.classList.add('message');\n    li.innerHTML = `<span class=\"to\">${message.to}</span>\n                    <span class=\"subject\">${message.subject}</span>\n                    <span class=\"body\">${message.body}</span>`;\n    return li;\n  }\n}\n\nmodule.exports = Sent;\n\n//# sourceURL=webpack://mail/./src/sent.js?");

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