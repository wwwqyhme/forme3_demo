import 'package:fluent_ui/fluent_ui.dart';
import 'package:forme/forme.dart';
import 'package:url_launcher/url_launcher.dart';

typedef FieldBuilder = List<Widget> Function(
    BuildContext context, FormeKey key);

class FormeFluentScreen extends StatefulWidget {
  final String title;
  final FieldBuilder builder;
  final VoidCallback? onInitState;
  final VoidCallback? onDispose;
  final String? sourceCode;
  const FormeFluentScreen({
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

class FormeScreenState extends State<FormeFluentScreen> {
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
    return FluentTheme(
      data: FluentThemeData(),
      child: NavigationView(
        appBar: NavigationAppBar(
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
                    icon: const Icon(FluentIcons.source)),
              Expanded(
                child: Button(
                    child: Text('??'),
                    onPressed: () {
                      Navigator.of(context).popAndPushNamed('/');
                    }),
              )
            ],
          ),
        ),
        content: SingleChildScrollView(
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
      ),
    );
  }
}
