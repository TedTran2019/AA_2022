const APIUtils = require('./api_utils');

class TweetCompose {
  constructor($form) {
    this.$form = $form;
    this.$form.data('tweets-ul', '#feed');
    this.$form.submit(this.submit.bind(this)); // this in submit is the class
    // this.$form.submit(this.submit); (this in submit is the form itself)
    this.$form.find('textarea').on("input propertychange", this.countChars.bind(this));
  }

  submit(event) {
    event.preventDefault();
    const $inputs = this.$form.find(':input');
    const formContent = $inputs.serializeJSON();
    $inputs.prop('disabled', true);
    APIUtils.createTweet(formContent).then(tweet => this.handleSuccess($inputs, tweet));
  }

  clearInput() {
    this.$form[0].reset();
  }

  handleSuccess($inputs, tweet) {
    this.clearInput();
    $inputs.prop('disabled', false);
    const tweetUl = $(this.$form.data('tweets-ul'));
    const tweetData = JSON.stringify(tweet.content);
    const $li = $(`<li>${tweetData}</li>`);
    tweetUl.prepend($li);
  }

  countChars(event) {
    const $charsLeft = $(".chars-left");
    $charsLeft.text(`${140 - event.currentTarget.value.length} characters left`);
  }
}

module.exports = TweetCompose;
