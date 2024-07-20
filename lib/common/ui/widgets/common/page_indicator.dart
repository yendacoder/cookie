import 'package:flutter/material.dart';

class PageIndicator extends StatelessWidget {
  const PageIndicator(
      {super.key,
        required this.pagesCount,
        required this.currentPage,
        this.onPageTap,
        this.pageController})
      : assert(onPageTap == null || pageController == null);

  final int pagesCount;
  final int currentPage;
  final void Function(int)? onPageTap;
  final PageController? pageController;

  @override
  Widget build(BuildContext context) {
    const baseColor = Colors.white;
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      for (int i = 0; i < pagesCount; i++)
        GestureDetector(
          onTap: () => onPageTap != null
              ? onPageTap?.call(i)
              : pageController?.animateToPage(i,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOutQuad),
          child: Container(
            width: 6.0,
            height: 6.0,
            margin: const EdgeInsets.symmetric(horizontal: 2.0),
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: currentPage == i ? baseColor : baseColor.withAlpha(128)),
          ),
        )
    ]);
  }
}
