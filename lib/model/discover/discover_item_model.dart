import 'package:diet_app_mobile/model/general/comment_model.dart';

class DiscoverItemModel {
  final String imageUrl;
  final String description;
  final int likeCount;
  final int commentCount;
  final String type;
  final List<CommentModel> comments;

  DiscoverItemModel(
      {required this.imageUrl,
      required this.description,
      required this.likeCount,
      required this.commentCount,
      required this.type,
      required this.comments});
}

/* 
class DiscoverItemModel {
  final String? title;
  final String? type; // 'video' veya 'post'
  final int? likeCount;
  final int? commentCount;
  final bool? isSaved;
  final bool? isLiked;
  final String? url;
  final UserModel? userModel;
  final CommentModel? commentModel;
  final List<CommentModel>? itemCommentList;

  DiscoverItemModel({required this.title, required this.type});
}
 */
