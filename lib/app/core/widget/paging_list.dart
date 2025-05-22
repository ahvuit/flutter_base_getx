import 'package:flutter/material.dart';

class PagingList<T> extends StatelessWidget {
  final List<T> items;
  final Widget Function(BuildContext, T) itemBuilder;
  final VoidCallback? onLoadMore;
  final bool isLoading;

  const PagingList({
    super.key,
    required this.items,
    required this.itemBuilder,
    this.onLoadMore,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (scrollInfo) {
        if (scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent &&
            !isLoading) {
          onLoadMore?.call();
        }
        return true;
      },
      child: ListView.builder(
        itemCount: items.length + (isLoading ? 1 : 0),
        itemBuilder: (context, index) {
          if (index == items.length && isLoading) {
            return Padding(
              padding: EdgeInsets.all(16),
              child: const Center(child: CircularProgressIndicator()),
            );
          }
          return itemBuilder(context, items[index]);
        },
      ),
    );
  }
}
