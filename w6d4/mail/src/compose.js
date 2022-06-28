const MessageStore = require('./message_store');

class Compose {
  constructor() {
    this.messageStore = new MessageStore();
  }

  render() {
    const div = document.createElement('div');
    div.addEventListener('submit', event => {
      event.preventDefault();
      this.messageStore.sendDraft();
      window.location.hash = '#inbox';
    })
    div.addEventListener('change', event => {
      this.messageStore.updateDraftField(event.target.name, event.target.value);
    })
    div.classList.add('new-message');
    div.innerHTML = this.renderForm();
    return div;
  }

  renderForm() {
    const messageDraft = this.messageStore.getMessageDraft();
    const form = `
      <p class="new-message-header">New Message</p>
      <form class="compose-form">
        <input placeholder="Recipient" name="to" type="text" value="${messageDraft.to}">
        <input placeholder="Subject" name="subject" type="text" value="${messageDraft.subject}">
        <textarea name="body" rows="20">${messageDraft.body}</textarea>
        <button type="submit" class="btn btn-primary submit-message">Send</button>
      </form>
    `
    return form;
  }
}

module.exports = Compose;