import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
class ProductDesc extends StatelessWidget {
  final String description;
  ProductDesc(this.description);
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new ListView(
        padding: const EdgeInsets.all(14.0),
        children: <Widget>[ HtmlWidget(description)]
      ),
    );
  }
}
