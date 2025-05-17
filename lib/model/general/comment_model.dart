class CommentModel {
  final String? userProfileUrl;
  final String? userName;
  final String? date;
  final String? likeCount;
  final String? comment;

  CommentModel(
      {required this.userProfileUrl,
      required this.userName,
      required this.date,
      required this.likeCount,
      required this.comment});
}
