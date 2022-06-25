const APIUtils = require('./api_utils');

class InfiniteTweets {
  constructor($el) {
    this.$el = $el;
    this.$feed = $el.find('#feed');
    this.maxCreatedAt = null;
    this.$el.on('click', '.fetch-more', this.fetchTweets.bind(this));
  }

  fetchTweets(event) {
    event.preventDefault();
    if (this.maxCreatedAt) {
      APIUtils.fetchTweets(this.maxCreatedAt).then(tweets => {
        this.insertTweets(tweets);
      })
    } else {
      APIUtils.fetchTweets().then(tweets => {
        this.insertTweets(tweets);
      })
    }
  }

  insertTweets(tweets) {
    tweets.forEach(tweet => {
      let $li = $(`<li>${tweet.content}</li>`);
      this.$feed.append($li);
    })
    if (tweets.length > 0) {
      this.maxCreatedAt = tweets[tweets.length - 1].created_at;
    } else {
      this.$el.find('.fetch-more').remove();
      this.$el.append('No more tweets');
    }
  }
}

module.exports = InfiniteTweets;