import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class RefreshableScrollView extends StatelessWidget {
  const RefreshableScrollView({
    required this.refreshController,
    required this.onRefresh,
    super.key,
    this.slivers = const [],
    this.child,
  });

  final RefreshController refreshController;
  final Future<void> Function() onRefresh;
  final List<Widget> slivers;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      controller: refreshController,
      onRefresh: onRefresh,
      child: child ?? CustomScrollView(slivers: slivers),
    );
  }
}
