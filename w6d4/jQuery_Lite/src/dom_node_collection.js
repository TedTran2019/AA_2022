// Every method implemented will be applied to every node in the internal array.
class DomNodeCollection {
  constructor(htmlElements) {
    this.htmlElements = htmlElements;
  }

  // Empty string is false in Javascript
  html(arg) {
    if (arg === undefined) {
      if (this.htmlElements.length === 1) {
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

  attr() {

  }

  addClass() {

  }

  removeClass() {

  }

  children() {

  }

  parent() {

  }

  find() {

  }

  remove() {

  }

  on() {

  }

  off() {

  }
}

module.exports = DomNodeCollection;
