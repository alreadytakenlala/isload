class UserData {
  String avatar;
  String nickname;
  String createTime;
  UserData({
    this.avatar,
    this.nickname,
    this.createTime
  });
  Map toJson() {
    Map map = new Map();
    map["avatar"] = this.avatar;
    map["nickname"] = this.nickname;
    map["createTime"] = this.createTime;
    return map;
  }
}