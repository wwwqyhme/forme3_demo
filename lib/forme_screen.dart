import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:forme/forme.dart';

typedef FieldBuilder = List<Widget> Function(
    BuildContext context, FormeKey key);

class FormeScreen extends StatefulWidget {
  final String title;
  final FieldBuilder builder;
  const FormeScreen({
    Key? key,
    required this.title,
    required this.builder,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _FormeScreenState();
}

class _FormeScreenState extends State<FormeScreen> {
  final FormeKey key = FormeKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Padding(
          child: Forme(
            key: key,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: widget.builder(context, key),
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20),
        ),
      ),
    );
  }
}
