// Every method implemented will be applied to every node in the internal array.
class DomNodeCollection {
  constructor(htmlElements) {
    this.htmlElements = htmlElements;
  }

  // Empty string is false in Javascript
  html(arg) {
    if (arg === undefined) {
      if (this.htmlElements.length > 0) {
        return this.htmlElements[0].innerHTML;
      }
    } else {
      this.htmlElements.forEach(el => {
        el.innerHTML = arg;
      });
    }
  }

  empty() {
    this.htmlElements.forEach(el => {
      el.textContent = '';
    })
    // this.html('');
  }

  // Can copy jQuery's behavior here by not cloning the node
  append(arg) {
    if (arg instanceof DomNodeCollection) {
      this.htmlElements.forEach(el => {
        arg.htmlElements.forEach(child => {
          el.appendChild(child.cloneNode(true));
        });
      });
    } else if (arg instanceof HTMLElement) {
      this.htmlElements.forEach(el => {
        el.appendChild(arg.cloneNode(true));
      })
    } else if (typeof arg === 'string') {
      this.htmlElements.forEach(el => {
        // el.innerHTML += arg;
        el.append(arg);
      })
    }
  }

  attr(name, value) {
    if (value === undefined) {
      if (this.htmlElements.length > 0) {
        return this.htmlElements[0].getAttribute(name);
      }
    } else {
      this.htmlElements.forEach(el => {
        el.setAttribute(name, value);
      });
    }
  }

  addClass(className) {
    this.htmlElements.forEach(el => {
      el.classList.add(className);
    })
  }

  removeClass(className) {
    if (className === undefined) {
      this.htmlElements.forEach(el => {
        el.className = "";
      })
    } else {
      this.htmlElements.forEach(el => {
        el.classList.remove(className);
      })
    }
  }

  children() {
    const children = [];
    this.htmlElements.forEach(el => {
      const eachChildren = el.children
      for (let i = 0; i < eachChildren.length; i++) {
        children.push(eachChildren[i]);
      }
    })
    return new DomNodeCollection(children);
  }

  parent() {
    const parents = []
    this.htmlElements.forEach(el => {
      parents.push(el.parentElement);
    })
    return new DomNodeCollection(parents);
  }

  find(selector) {
    const found = [];
    this.htmlElements.forEach(el => {
      const foundChildren = el.querySelectorAll(selector);
      for (let i = 0; i < foundChildren.length; i++) {
        found.push(foundChildren[i]);
      }
    })
    return new DomNodeCollection(found);
  }

  remove(selector) {
    this.htmlElements.forEach(el => {
      if (selector === undefined) {
        el.remove();
      } else {
        const found = el.querySelectorAll(selector);
        for (let i = 0; i < found.length; i++) {
          found[i].remove();
        }
      }
    })
  }

  on(event, handler) {
    this.htmlElements.forEach(el => {
      el.addEventListener(event, handler);
      if (el.listen === undefined) {
        el.listen = {};
      }
      if (el.listen[event] === undefined) {
        el.listen[event] = [handler];
      } else {
        el.listen[event].push(handler);
      }
    })
  }

  // Handler not provided: remove all of type === event
  // Event and handler not provided: remove all events
  off(event, handler) {
    if (event === undefined && handler === undefined) {
      this.htmlElements.forEach(el => {
        const listen = el.listen;
        for (const elEvent in listen) {
          listen[elEvent].forEach(elHandler => {
            el.removeEventListener(elEvent, elHandler);
          })
        }
        el.listen = undefined;
      })
    } else if (handler === undefined) {
      this.htmlElements.forEach(el => {
        const listen = el.listen;
        listen[event].forEach(elHandler => {
          el.removeEventListener(event, elHandler);
        })
        el.listen[event] = undefined;
      })
    } else {
      this.htmlElements.forEach(el => {
        const listen = el.listen;
        const newArray = [];
        listen[event].forEach(elHandler => {
          if (elHandler.toString() !== handler.toString()) {
            newArray.push(elHandler);
          } else {
            el.removeEventListener(event, elHandler);
          }
        })
        el.listen[event] = newArray;
      })
    }
  }
}

module.exports = DomNodeCollection;
