const FollowToggle = require("./follow_toggle.js");

$(document).ready(function() {
  $("button.follow-toggle").each(function(idx, el) {
    new FollowToggle($(el));
  })
});
