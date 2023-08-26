import 'dart:async';

import 'package:cookie/settings/consts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RefreshableList extends StatefulWidget {
  const RefreshableList(
      {Key? key,
      required this.refreshRequest,
      required this.itemBuilder,
      required this.itemCount,
      required this.isLoading,
      this.nextPageRequest,
      this.dividerBuilder,
      this.padding = EdgeInsets.zero,
      this.scrollController})
      : super(key: key);

  final VoidCallback refreshRequest;
  final VoidCallback? nextPageRequest;
  final bool isLoading;
  final NullableIndexedWidgetBuilder itemBuilder;
  final NullableIndexedWidgetBuilder? dividerBuilder;
  final int itemCount;
  final EdgeInsets padding;
  final ScrollController? scrollController;

  @override
  State<StatefulWidget> createState() => _RefreshableListState();
}

class _RefreshableListState extends State<RefreshableList> {
  Completer<void>? _refreshCompleter;
  late final ScrollController _scrollController;

  @override
  void initState() {
    _scrollController = widget.scrollController ?? ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    if (widget.scrollController == null) {
      _scrollController.dispose();
    }
    super.dispose();
  }

  Widget _buildListWrapper(BuildContext context) {
    final Widget list;
    if (Theme.of(context).platform == TargetPlatform.iOS) {
      list = _buildList(context);
    } else {
      list = RefreshIndicator(
          onRefresh: () {
            widget.refreshRequest();
            _refreshCompleter = Completer();
            return _refreshCompleter!.future;
          },
          child: _buildList(context));
    }
    if (widget.nextPageRequest != null && !widget.isLoading) {
      return NotificationListener<ScrollNotification>(
          onNotification: (ScrollNotification notification) {
            if (notification is ScrollEndNotification) {
              if (_scrollController.position.extentAfter <
                  kDefaultTappableItemHeight) {
                widget.nextPageRequest?.call();
              }
            }
            return false;
          },
          child: list);
    } else {
      return list;
    }
  }

  Widget _buildList(BuildContext context) {
    return CustomScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      controller: _scrollController,
      slivers: [
        if (Theme.of(context).platform == TargetPlatform.iOS)
          CupertinoSliverRefreshControl(
            onRefresh: () {
              widget.refreshRequest();
              _refreshCompleter = Completer();
              return _refreshCompleter!.future;
            },
          ),
        SliverPadding(
            padding: widget.padding,
            sliver: SliverList(delegate: _getSliverListDelegate())),
      ],
    );
  }

  SliverChildDelegate _getSliverListDelegate() {
    return SliverChildBuilderDelegate(
      (context, index) {
        if (widget.dividerBuilder == null) {
          return widget.itemBuilder(context, index);
        } else {
          if (index.isEven) {
            return widget.itemBuilder(context, index ~/ 2);
          } else {
            return widget.dividerBuilder!(context, index ~/ 2);
          }
        }
      },
      childCount: widget.dividerBuilder == null
          ? widget.itemCount
          : widget.itemCount * 2 - 1,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.isLoading) {
      _refreshCompleter?.complete();
      _refreshCompleter = null;
    }
    return _buildListWrapper(context);
  }
}
