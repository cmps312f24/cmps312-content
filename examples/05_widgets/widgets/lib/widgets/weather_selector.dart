import 'package:flutter/material.dart';
import 'package:widgets/models/weather.dart';

class WeatherSelector extends StatelessWidget {
  final Weather selectedWeather;
  final ValueChanged<Weather> onSelectionChanged;

  const WeatherSelector({
    required this.selectedWeather,
    required this.onSelectionChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SegmentedButton<Weather>(
      selected: {selectedWeather},
      onSelectionChanged: (newSelection) {
        onSelectionChanged(newSelection.first);
      },
      segments: Weather.values
          .map(
            (weather) => ButtonSegment<Weather>(
              value: weather,
              icon: Icon(weather.icon),
            ),
          )
          .toList(),
    );
  }
}
