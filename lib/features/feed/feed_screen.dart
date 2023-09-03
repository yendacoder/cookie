import 'package:auto_route/auto_route.dart';
import 'package:cookie/api/model/enums.dart';
import 'package:cookie/common/controller/initial_controller.dart';
import 'package:cookie/common/repository/post_repository.dart';
import 'package:cookie/common/util/common_util.dart';
import 'package:cookie/features/feed/feed_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

@RoutePage()
class FeedScreen extends StatelessWidget {
  const FeedScreen(
      {super.key,
      this.feedType,
      this.communityId});

  final String? feedType;
  final String? communityId;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => FeedController(
            PostRepository(Provider.of<InitialController>(context, listen: false)),
            feedType?.toEnumOrNull(FeedType.values),
            communityId),
        child: const AutoRouter());
  }
}
