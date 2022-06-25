const FollowToggle = require("./follow_toggle.js");
const UsersSearch = require("./users_search.js");
const TweetCompose = require("./tweet_compose.js");

$(document).ready(function() {
  $("button.follow-toggle").each(function(idx, el) {
    new FollowToggle($(el));
  })

  $("nav.users-search").each(function(idx, el) {
    new UsersSearch($(el));
  })

  $("form.tweet-compose").each(function(idx, el) {
    new TweetCompose($(el));
  })
});
