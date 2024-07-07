import 'package:flutter/material.dart';

class WeatherInfo extends StatelessWidget {
  final String title;
  final num value;
  final String unit;
  final TextStyle? style;

  const WeatherInfo({
    super.key,
    required this.title,
    required this.value,
    required this.unit,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveStyle = style ?? Theme.of(context).textTheme.bodyLarge;
    return RichText(
      text: TextSpan(
        style: effectiveStyle,
        children: [
          TextSpan(text: '$title: ', style: effectiveStyle?.copyWith(fontWeight: FontWeight.bold)),
          TextSpan(text: '$value'),
          TextSpan(text: unit, style: effectiveStyle?.copyWith(fontWeight: FontWeight.w300)),
        ],
      ),
    );
  }
}
