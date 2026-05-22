import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class Avatar extends StatelessWidget {
  const Avatar({
    super.key,
    required this.fallback,
    required this.radius,
    this.imageUrl,
  });

  final String? imageUrl;
  final String fallback;
  final double radius;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final initial = fallback.isNotEmpty ? fallback[0].toUpperCase() : '?';
    final size = radius * 2;
    return CircleAvatar(
      radius: radius,
      backgroundColor: colorScheme.primaryContainer,
      child: imageUrl != null
          ? ClipOval(
              child: CachedNetworkImage(
                imageUrl: imageUrl!,
                width: size,
                height: size,
                fit: .cover,
                placeholder: (_, _) => const SizedBox.shrink(),
                errorWidget: (_, _, _) => _Initials(
                  initial: initial,
                  radius: radius,
                  colorScheme: colorScheme,
                ),
              ),
            )
          : _Initials(
              initial: initial,
              radius: radius,
              colorScheme: colorScheme,
            ),
    );
  }
}

class _Initials extends StatelessWidget {
  const _Initials({
    required this.initial,
    required this.radius,
    required this.colorScheme,
  });

  final String initial;
  final double radius;
  final ColorScheme colorScheme;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: radius * 2,
      height: radius * 2,
      alignment: .center,
      child: Text(
        initial,
        style: TextStyle(
          fontSize: radius * 0.9,
          color: colorScheme.onPrimaryContainer,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
