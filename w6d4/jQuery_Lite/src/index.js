const DomNodeCollection = require('./dom_node_collection');

window.$1 = function(selector) {
  if (typeof selector === 'string') {
    const nodeList = document.querySelectorAll(selector);
    const nodesArray = Array.from(nodeList);
    return new DomNodeCollection(nodesArray);
  } else if (selector instanceof HTMLElement) {
    return new DomNodeCollection([selector]);
  } else if (typeof selector === 'function') {
    window.addEventListener('DOMContentLoaded', selector);
  }
}

// html 
// window.$1('.test1').html()
// window.$1('.test1').html('HELLO')
// window.$1('.test1').html()
// $('.test1').html()
// $('.test1').html('GOODBYE')
// $('.test1').html()

// empty
// window.$1('.test1').html('HELLO')
// window.$1('.test1').empty()
// $('.test1').html('HELLO')
// $('.test1').empty()

// append
a = 'hello';
b = document.querySelector('.test2')
c = window.$1('.test2')
d = $('.test2')
window.$1('.test1').append(a)
window.$1('.test1').append(b)
window.$1('.test1').append(c)
// jQuery Append moves the oject to the specified location instead of making a copy
$('.test1').append(a)
$('.test1').append(b)
$('.test1').append(d)