const DomNodeCollection = require('./dom_node_collection');

let isReady = false;
let readyCallbacks = [];

window.$1 = function(selector) {
  if (typeof selector === 'string') {
    const nodeList = document.querySelectorAll(selector);
    const nodesArray = Array.from(nodeList);
    return new DomNodeCollection(nodesArray);
  } else if (selector instanceof HTMLElement) {
    return new DomNodeCollection([selector]);
  } else if (typeof selector === 'function') {
    // window.addEventListener('DOMContentLoaded', selector); Adds too many event listeners
    if (isReady) {
      selector();
    } else {
      readyCallbacks.push(selector);
    }
  }
}

window.$1.extend = function(objA, ...objects) {
  objects.forEach(obj => {
    for (key in obj) {
      objA[key] = obj[key];
    }
  })
  return objA;
}

window.$1.ajax = function(options) {
  const defaults = {
    // async: true,
    contentType: 'application/x-www-form-urlencoded; charset=utf-8',
    data: {},
    // dataType: 'json',
    // global: true,
    // headers: {},
    // ifModified: false,
    method: 'GET',
    // processData: true,
    // statusCode: {},
    // type: 'GET',
    url: window.location.href,
    success: () => {},
    error: () => {}
  }
  options = $1.extend(defaults, options);
  const xhr = new XMLHttpRequest();
  xhr.open(options.method, options.url);
  xhr.onload = function() {
    let response = JSON.parse(xhr.response);
    if (xhr.status === 200) {
      options.success(response);
    } else {
      options.error(response);
    }
  }
  xhr.send(options.data);
}

window.addEventListener('DOMContentLoaded', () => {
  readyCallbacks.forEach(callback => callback());
  isReady = true;
})

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
// a = 'hello';
// b = document.querySelector('.test2')
// c = window.$1('.test2')
// d = $('.test2')
// window.$1('.test1').append(a)
// window.$1('.test1').append(b)
// window.$1('.test1').append(c)
// // jQuery Append moves the oject to the specified location instead of making a copy
// $('.test1').append(a)
// $('.test1').append(b)
// $('.test1').append(d)

// attr
// name = 'name';
// value = 'Steve';
// window.$1('.test1').attr(name)
// window.$1('.test1').attr(name, value)
// window.$1('.test1').attr(name)

// addClass
// window.$1('.test1').addClass('testing')

// removeClass
// window.$1('.test1').addClass('testing')
// window.$1('.test1').addClass('blargh')
// window.$1('.test1').removeClass('potato')
// window.$1('.test1').removeClass('testing')
// window.$1('.test1').addClass('testing-again')
// window.$1('.test1').removeClass()

// children
// window.$1('.test6').children()

// parent
// window.$1('.test1').parent()

// find
// window.$1('body').find('.test1')

// remove
// window.$1('.test6').remove()
// window.$1('.test6').remove('.test7')

// on
// window.$1('.test1').on('click', () => { console.log('Hello') })
// window.$1('.test1').htmlElements[0].listen.click[0]()

// off
// window.$1('.test1').on('click', () => { console.log('Hello') })
// window.$1('.test1').on('click', () => { console.log('Goodbye') })
// window.$1('.test1').on('mouseup', () => { console.log('Blargh') })
// window.$1('.test1').htmlElements[0].listen
// window.$1('.test1').off()
// window.$1('.test1').htmlElements[0].listen
// Re-setup Hello, Goodbye, Blargh
// window.$1('.test1').off('click')
// window.$1('.test1').htmlElements[0].listen
// window.$1('.test1').off('mouseup', () => { console.log('Blargh') })
// window.$1('.test1').htmlElements[0].listen

// Testing $(function)
// window.$1(() => alert("the document is ready"));

// Testing extend
// const objA = { a: "a", b: "a", c: "a" };
// const objB = { b: "b", c: "b" };
// const objC = { c: "c" };
// $l.extend(objA, objB, objC); 
// console.log(objA);

// Testing ajax
// window.$1.ajax({ success: () => { console.log('success') }, failure: () => { console.log('failure') } })