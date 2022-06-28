const Router = require('./router');
const Inbox = require('./inbox');
const Sent = require('./sent');
const Compose = require('./compose');

window.addEventListener('DOMContentLoaded', () => {
  const sidebarNavLis = document.querySelectorAll('.sidebar-nav li');
  const content = document.querySelector('.content');
  new Router(content, routes).start();
  window.location.hash = '#inbox';
  sidebarNavLis.forEach((li) => {
    li.addEventListener('click', (event) => {
      const newUrl = event.target.innerText.toLowerCase();
      window.location.hash = newUrl;
    })
  })
})

const routes = {
  inbox: new Inbox,
  sent: new Sent,
  compose: new Compose
}
