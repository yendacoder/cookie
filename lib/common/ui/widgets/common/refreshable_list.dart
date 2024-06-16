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
      this.scrollController,
      this.needsOverlapInjector = false})
      : super(key: key);

  final VoidCallback refreshRequest;
  final VoidCallback? nextPageRequest;
  final bool isLoading;
  final NullableIndexedWidgetBuilder itemBuilder;
  final NullableIndexedWidgetBuilder? dividerBuilder;
  final int itemCount;
  final EdgeInsets padding;
  final ScrollController? scrollController;
  final bool needsOverlapInjector;

  @override
  State<StatefulWidget> createState() => _RefreshableListState();
}

class _RefreshableListState extends State<RefreshableList> {
  Completer<void>? _refreshCompleter;
  late final ScrollController? _scrollController;

  @override
  void initState() {
    if (widget.needsOverlapInjector) {
      // for overlap injector to work,
      // the scroll controller for the list must be the primary scroll
      // controller. So, with injector, we need to skip creating
      // the scroll controller here.
      _scrollController = widget.scrollController;
    } else {
      _scrollController = widget.scrollController ?? ScrollController();
    }
    super.initState();
  }

  @override
  void dispose() {
    if (widget.scrollController == null) {
      _scrollController?.dispose();
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
              if (_scrollController == null) {
                // this can probably be a bit more elegant
                // need to find which position belongs to the current list
                if (PrimaryScrollController.of(context).positions.any(
                    (pos) => pos.extentAfter < kDefaultTappableItemHeight)) {
                  widget.nextPageRequest?.call();
                }
              } else {
                if (_scrollController!.position.extentAfter <
                    kDefaultTappableItemHeight) {
                  widget.nextPageRequest?.call();
                }
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
        if (widget.needsOverlapInjector)
          SliverOverlapInjector(
            handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
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
