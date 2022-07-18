import 'package:flutter/material.dart';
import 'package:forme/forme.dart';
import 'package:url_launcher/url_launcher.dart';

typedef FieldBuilder = List<Widget> Function(
    BuildContext context, FormeKey key);

class FormeScreen extends StatefulWidget {
  final String title;
  final FieldBuilder builder;
  final VoidCallback? onInitState;
  final VoidCallback? onDispose;
  final String? sourceCode;
  const FormeScreen({
    Key? key,
    required this.title,
    required this.builder,
    this.onDispose,
    this.onInitState,
    this.sourceCode,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => FormeScreenState();
}

class FormeScreenState extends State<FormeScreen> {
  final FormeKey key = FormeKey();

  @override
  void initState() {
    super.initState();
    widget.onInitState?.call();
  }

  @override
  void dispose() {
    widget.onDispose?.call();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            if (widget.sourceCode != null)
              IconButton(
                  onPressed: () {
                    launchUrl(Uri.parse(
                        'https://github.com/wwwqyhme/forme3_demo/blob/main/lib/${widget.sourceCode!}.dart'));
                  },
                  icon: const Icon(Icons.source)),
            Expanded(
              child: Text(widget.title),
            )
          ],
        ),
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
