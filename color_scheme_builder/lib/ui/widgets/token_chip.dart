import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../models/color_token.dart';

class TokenChip extends StatelessWidget {
  final ColorToken token;

  const TokenChip({super.key, required this.token});

  @override
  Widget build(BuildContext context) {
    final luminance = token.color.computeLuminance();
    final textColor = luminance > 0.35 ? Colors.black87 : Colors.white;

    return Tooltip(
      message: 'Tap to copy hex',
      child: InkWell(
        onTap: () {
          Clipboard.setData(ClipboardData(text: token.hex));
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Copied ${token.hex}'),
              duration: const Duration(seconds: 1),
              behavior: SnackBarBehavior.floating,
              width: 200,
            ),
          );
        },
        borderRadius: BorderRadius.circular(8),
        child: Container(
          height: 64,
          decoration: BoxDecoration(
            color: token.color,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: Colors.black.withValues(alpha: 0.08),
              width: 0.5,
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                token.name,
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  color: textColor,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                token.hex,
                style: TextStyle(fontSize: 10, color: textColor.withValues(alpha: 0.8)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
