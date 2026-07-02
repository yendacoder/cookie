import 'package:cookie/features/shell/models/content_text_size.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'content_text_sizes_provider.g.dart';

typedef ContentTextSizes = ({
  ContentTextSize postCard,
  ContentTextSize postDetail,
  ContentTextSize comment,
});

@Riverpod(keepAlive: true)
class ContentTextSizesNotifier extends _$ContentTextSizesNotifier {
  static const kPostCardPrefsName = 'post_card_text_size';
  static const kPostDetailPrefsName = 'post_detail_text_size';
  static const kCommentPrefsName = 'comment_text_size';

  @override
  ContentTextSizes build() =>
      (postCard: .small, postDetail: .medium, comment: .small);

  void setPostCard(ContentTextSize size) {
    SharedPreferencesAsync().setString(kPostCardPrefsName, size.name);
    state = (
      postCard: size,
      postDetail: state.postDetail,
      comment: state.comment,
    );
  }

  void setPostDetail(ContentTextSize size) {
    SharedPreferencesAsync().setString(kPostDetailPrefsName, size.name);
    state = (
      postCard: state.postCard,
      postDetail: size,
      comment: state.comment,
    );
  }

  void setComment(ContentTextSize size) {
    SharedPreferencesAsync().setString(kCommentPrefsName, size.name);
    state = (
      postCard: state.postCard,
      postDetail: state.postDetail,
      comment: size,
    );
  }
}
