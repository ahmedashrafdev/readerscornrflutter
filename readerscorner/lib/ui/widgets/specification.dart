import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';


class ProductDetails extends StatelessWidget {
  final String details;
  ProductDetails(this.details);
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: HtmlWidget(details)
    );
  }
}