import 'package:flutter/material.dart';
import '../../models/color_token.dart';

class TonalStrip extends StatelessWidget {
  final TonalPaletteStrip strip;

  const TonalStrip({super.key, required this.strip});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 4),
          child: Text(
            strip.name,
            style: Theme.of(context).textTheme.labelSmall,
          ),
        ),
        Row(
          children: strip.swatches.map((s) {
            final luminance = s.color.computeLuminance();
            final labelColor = luminance > 0.35 ? Colors.black87 : Colors.white70;
            return Expanded(
              child: Tooltip(
                message: 'T${s.tone}\n#${(s.argb & 0xFFFFFF).toRadixString(16).toUpperCase().padLeft(6, '0')}',
                child: Container(
                  height: 36,
                  color: s.color,
                  alignment: Alignment.center,
                  child: Text(
                    '${s.tone}',
                    style: TextStyle(fontSize: 9, color: labelColor),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
