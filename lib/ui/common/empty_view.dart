import 'package:booking_app/common/text_style_extension.dart';
import 'package:flutter/material.dart';

class EmptyView extends StatelessWidget {
  final String? message;

  const EmptyView({Key? key, this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        message ?? 'Something went wrong!',
        style: Theme.of(context).textTheme.text22(),
      ),
    );
  }
}
