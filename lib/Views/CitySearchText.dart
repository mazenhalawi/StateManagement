import 'package:flutter/material.dart';

class CitySearchText extends StatelessWidget {
  final dynamic source;
  final Function(String) onChanged;
  final Function onPressed;
  final Function(String) onSubmitted;

  CitySearchText(
      {@required this.source,
      @required this.onChanged,
      @required this.onPressed,
      this.onSubmitted});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: TextEditingController(text: source),
      onChanged: onChanged,
      onSubmitted: onSubmitted,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        suffixIcon: IconButton(
          icon: Icon(Icons.search),
          onPressed: onPressed,
        ),
      ),
    );
  }
}
