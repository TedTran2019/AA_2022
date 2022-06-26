/******/ (() => { // webpackBootstrap
/******/ 	var __webpack_modules__ = ({

/***/ "./frontend/api_utils.js":
/*!*******************************!*\
  !*** ./frontend/api_utils.js ***!
  \*******************************/
/***/ ((module) => {

const APIUtils = {
  followUser: id => { return APIUtils.changeFollowStatus(id, "POST") },
  unfollowUser: id => { return APIUtils.changeFollowStatus(id, "DELETE") },

  changeFollowStatus: (id, method) => {
    return $.ajax({
      type: method,
      dataType: 'json',
      url: `/users/${id}/follow`,
      success() {
        console.log('Success');
      },
      error(e) {
        console.error(e);
      },
    });
  },

  searchUsers(queryVal) {
    return $.ajax({
      type: "GET",
      dataType: 'json',
      url: `/users/search`,
      data: { query: queryVal },
      success() {
        console.log('Success');
      },
      error(e) {
        console.error(e);
      }
    }); 
  },

  createTweet(data) {
    return $.ajax({
      type: "POST",
      dataType: 'json',
      url: `/tweets`,
      data: data,
      success() {
        console.log('Success');
      },
      error(e) {
        console.error(e);
      }
    }); 
  },

  fetchTweets(data) {
    return $.ajax({
      type: "GET",
      dataType: 'json',
      url: `/feed`,
      data: { max_created_at: data },
      success() {
        console.log('Success');
      },
      error(e) {
        console.error(e);
      }
    });   
  }
};

module.exports = APIUtils;

/***/ }),

/***/ "./frontend/follow_toggle.js":
/*!***********************************!*\
  !*** ./frontend/follow_toggle.js ***!
  \***********************************/
/***/ ((module, __unused_webpack_exports, __webpack_require__) => {

const APIUtils = __webpack_require__(/*! ./api_utils */ "./frontend/api_utils.js");

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


/***/ }),

/***/ "./frontend/infinite_tweets.js":
/*!*************************************!*\
  !*** ./frontend/infinite_tweets.js ***!
  \*************************************/
/***/ ((module, __unused_webpack_exports, __webpack_require__) => {

const APIUtils = __webpack_require__(/*! ./api_utils */ "./frontend/api_utils.js");

class InfiniteTweets {
  constructor($el) {
    this.$el = $el;
    this.$feed = $el.find('#feed');
    this.maxCreatedAt = null;
    this.$el.on('click', '.fetch-more', this.fetchTweets.bind(this));
    this.$el.on("insert-tweet", this.insertTweet.bind(this));
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

  insertTweet(event, tweet) {
    const $li = $(`<li>${tweet.content}</li>`);
    this.$feed.append($li);
    if (this.maxCreatedAt === null) {
      this.maxCreatedAt = tweet.created_at;
    }
  }
}

module.exports = InfiniteTweets;

/***/ }),

/***/ "./frontend/tweet_compose.js":
/*!***********************************!*\
  !*** ./frontend/tweet_compose.js ***!
  \***********************************/
/***/ ((module, __unused_webpack_exports, __webpack_require__) => {

const APIUtils = __webpack_require__(/*! ./api_utils */ "./frontend/api_utils.js");

class TweetCompose {
  constructor($form) {
    this.$form = $form;
    this.$form.data('tweets-ul', '#feed');
    this.$form.submit(this.submit.bind(this)); // this in submit is the class
    // this.$form.submit(this.submit); (this in submit is the form itself)
    this.$textarea = this.$form.find('textarea');
    this.$textarea.on("input propertychange", this.countChars.bind(this));
    this.newUserSelect();
    $('.tweet-mentions').on('click', '.remove-mentioned-user', this.removeMentionedUser.bind(this));
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
    // const tweetData = JSON.stringify(tweet.content);
    tweetUl.trigger('insert-tweet', tweet);
    // const $li = $(`<li>${tweetData}</li>`);
    // tweetUl.prepend($li);
    this.countChars();
    this.$form.find('.tweet-mentions').empty();
  }

  countChars(event) {
    const $charsLeft = $(".chars-left");
    $charsLeft.text(`${140 - this.$textarea.val().length} characters left`);
    // $charsLeft.text(`${140 - event.currentTarget.value.length} characters left`);
  }

  newUserSelect() {
    console.log(window.users);
    const $tweetMentions = this.$form.find('.tweet-mentions');
    const $mention = $tweetMentions.find('.tweet-mention');
    const $addMentionBtn = $("<button>Add Mention</button>");
    this.$form.append($addMentionBtn);
    $tweetMentions.empty();
    $addMentionBtn.on('click', event => {
      event.preventDefault();
      $tweetMentions.append($mention.clone());
    })
  }

  removeMentionedUser(event) {
    event.preventDefault();
    $(event.currentTarget).parent().remove();
  }
}

module.exports = TweetCompose;


/***/ }),

/***/ "./frontend/users_search.js":
/*!**********************************!*\
  !*** ./frontend/users_search.js ***!
  \**********************************/
/***/ ((module, __unused_webpack_exports, __webpack_require__) => {

const APIUtils = __webpack_require__(/*! ./api_utils */ "./frontend/api_utils.js");
const FollowToggle = __webpack_require__(/*! ./follow_toggle */ "./frontend/follow_toggle.js");

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

/***/ })

/******/ 	});
/************************************************************************/
/******/ 	// The module cache
/******/ 	var __webpack_module_cache__ = {};
/******/ 	
/******/ 	// The require function
/******/ 	function __webpack_require__(moduleId) {
/******/ 		// Check if module is in cache
/******/ 		var cachedModule = __webpack_module_cache__[moduleId];
/******/ 		if (cachedModule !== undefined) {
/******/ 			return cachedModule.exports;
/******/ 		}
/******/ 		// Create a new module (and put it into the cache)
/******/ 		var module = __webpack_module_cache__[moduleId] = {
/******/ 			// no module.id needed
/******/ 			// no module.loaded needed
/******/ 			exports: {}
/******/ 		};
/******/ 	
/******/ 		// Execute the module function
/******/ 		__webpack_modules__[moduleId](module, module.exports, __webpack_require__);
/******/ 	
/******/ 		// Return the exports of the module
/******/ 		return module.exports;
/******/ 	}
/******/ 	
/************************************************************************/
var __webpack_exports__ = {};
// This entry need to be wrapped in an IIFE because it need to be isolated against other modules in the chunk.
(() => {
/*!*****************************!*\
  !*** ./frontend/twitter.js ***!
  \*****************************/
const FollowToggle = __webpack_require__(/*! ./follow_toggle.js */ "./frontend/follow_toggle.js");
const UsersSearch = __webpack_require__(/*! ./users_search.js */ "./frontend/users_search.js");
const TweetCompose = __webpack_require__(/*! ./tweet_compose.js */ "./frontend/tweet_compose.js");
const InfiniteTweets = __webpack_require__(/*! ./infinite_tweets.js */ "./frontend/infinite_tweets.js");

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

  $("ul.infinite-tweets").each(function(idx, el) {
    new InfiniteTweets($(el));
  })
});

})();

/******/ })()
;
//# sourceMappingURL=bundle.js.map