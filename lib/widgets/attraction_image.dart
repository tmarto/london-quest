import 'package:flutter/material.dart';

class AttractionImage extends StatelessWidget {
  final String imageUrl;
  final String fallbackEmoji;
  final double height;

  const AttractionImage({
    super.key,
    required this.imageUrl,
    required this.fallbackEmoji,
    this.height = 180,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(14),
      child: SizedBox(
        height: height,
        width: double.infinity,
        child: Image.network(
          imageUrl,
          fit: BoxFit.cover,
          loadingBuilder: (ctx, child, progress) {
            if (progress == null) return child;
            return Container(
              color: Colors.white.withOpacity(0.05),
              child: Center(
                child: CircularProgressIndicator(
                  value: progress.expectedTotalBytes != null
                      ? progress.cumulativeBytesLoaded /
                          progress.expectedTotalBytes!
                      : null,
                  color: const Color(0xFFDC143C),
                  strokeWidth: 3,
                ),
              ),
            );
          },
          errorBuilder: (ctx, error, stack) {
            return Container(
              color: Colors.white.withOpacity(0.05),
              child: Center(
                child: Text(
                  fallbackEmoji,
                  style: const TextStyle(fontSize: 64),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
