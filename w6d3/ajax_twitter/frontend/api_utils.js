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
      error() {
        console.error("An error occurred.");
      },
    });
  }
};

module.exports = APIUtils;