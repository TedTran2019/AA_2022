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