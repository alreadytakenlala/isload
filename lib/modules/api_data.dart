class ApiData {
  // 基本路径
  static final baseUrl = "http://itnewdata.com:12663";
  // 基本路径
  static final baseDirectory = "/mock/29";
  // 获取用户信息
  static final getUserInfo = "/v1/passport/getPassportListByUser";
  // 获取分类列表
  static final getCategoryWithIsland = "/v1/category/getCategoryWithIsland";
  // 获取推荐提要列表
  static final getRecommendFeedList = "/v1/feed/getRecommendFeedList";
  // 通过关注获取标记列表
  static final getFeedListByFollowings = "/v1/feed/getFeedListByFollowings";
  // 获取标记分类列表
  static final getMarkCategoryList = "/v1/island/getPassportJoinedIslandListWithFeedCount";
  // 获取消息列表
  static final getMessageList = "/v1/message";
}