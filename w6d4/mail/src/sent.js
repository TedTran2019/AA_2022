const MessageStore = require('./message_store');

class Sent {
  constructor() {
    this.messageStore = new MessageStore();
  }

  render() {
    const ul = document.createElement('ul');
    ul.classList.add('messages');
    this.messageStore.getSentMessages().forEach((message) => {
      ul.appendChild(this.renderMessage(message));
    })
    return ul;
  }

  renderMessage(message) {
    const li = document.createElement('li');
    li.classList.add('message');
    li.innerHTML = `<span class="to">${message.to}</span>
                    <span class="subject">${message.subject}</span>
                    <span class="body">${message.body}</span>`;
    return li;
  }
}

module.exports = Sent;