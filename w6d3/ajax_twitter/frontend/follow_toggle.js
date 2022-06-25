const APIUtils = require('./api_utils');

class FollowToggle {
  constructor($el, options) {
    this.$el = $el;
    this.userId = this.$el.data("user-id") || options['userId'];
    this.followState = this.$el.data("initial-follow-state") || options['followState'];
    this.render();
    //this.handleClick();
    this.$el.on('click', this.handleClick.bind(this));
  }

  render() {
    if (this.followState === "unfollowed") {
      this.$el.text("Follow!");
      this.$el.prop('disabled', false);      
    } else if (this.followState === "followed") {
      this.$el.text("Unfollow!");
      this.$el.prop('disabled', false);
    } else {
      this.$el.prop('disabled', true);
    }
  }

  handleClick(e) {
    const followToggle = this;

    e.preventDefault();
    if (this.followState === "unfollowed") {
      this.followState = 'following';
      this.render();
      // this.followRequest();
      APIUtils.followUser(this.userId).then(() => {
        followToggle.toggleFollowState();
        followToggle.render();
      });
    } else if (this.followState === "followed") {
      this.followState = 'unfollowing';
      this.render();
      // this.unfollowRequest();
      APIUtils.unfollowUser(this.userId).then(() => {
        followToggle.toggleFollowState();
        followToggle.render();
      });
    };
  }

  // followRequest() {
  //   const that = this;
  //   $.ajax({
  //     type: 'POST',
  //     dataType: 'json',
  //     url: `/users/${this.userId}/follow`,
  //     success() {
  //       that.toggleFollowState();
  //       that.render();
  //     },
  //     error() {
  //       console.error("An error occurred.");
  //     },
  //   });
  // }

  // unfollowRequest() {
  //   const that = this;
  //   $.ajax({
  //     type: 'DELETE',
  //     dataType: 'json',
  //     url: `/users/${this.userId}/follow`,
  //     success() {
  //       that.toggleFollowState();
  //       that.render();
  //     },
  //     error() {
  //       console.error("An error occurred.");
  //     },
  //   });
  // }

  toggleFollowState() {
    if (this.followState === "following") {
      this.followState = "followed";
    } else if (this.followState === "unfollowing") {
      this.followState = "unfollowed";
    }
  }
}

module.exports = FollowToggle;
