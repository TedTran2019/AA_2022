const APIUtils = require('./api_utils');
const FollowToggle = require('./follow_toggle');

class UsersSearch {
  constructor($el) {
    this.$el = $el;
    this.$input = this.$el.find("input[name='search-query']");
    this.$ul = this.$el.find("ul.users");
    this.handleInput();
  }

  handleInput() {
    const usersSearch = this;
    this.$input.on("input", (e) => {
      const query = e.target.value;
      APIUtils.searchUsers(query).then((users) => {
        usersSearch.renderResults(users);
      })
    });
  }

  renderResults(users) {
    this.$ul.empty();
    users.forEach((user) => {
      const $a = $("<a>");
      $a.attr("href", `/users/${user.id}`);
      $a.text(user.username);
      const $li = $('<li>');
      const $button = $('<button>');
      $button.class = "follow-toggle";
      // user.followed is from JBuilder
      new FollowToggle($button, {userId: user.id, followState: user.followed ? "followed" : "unfollowed"});
      $li.append($a);
      $li.append($button);
      this.$ul.append($li);
    });
  }
}

module.exports = UsersSearch;