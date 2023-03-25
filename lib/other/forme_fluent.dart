import 'package:fluent_ui/fluent_ui.dart';
import 'package:forme/forme.dart';
import 'package:forme_fluent/forme_fluent.dart';

class FormeFluent extends StatelessWidget {
  const FormeFluent({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FluentApp(
        theme: FluentThemeData(
            scaffoldBackgroundColor: Colors.white,
            accentColor: Colors.blue,
            iconTheme: const IconThemeData(size: 24)),
        darkTheme: FluentThemeData(
            scaffoldBackgroundColor: Colors.black,
            accentColor: Colors.blue,
            iconTheme: const IconThemeData(size: 24)),
        home: const FormeFluentPage());
  }
}

class FormeFluentPage extends StatefulWidget {
  const FormeFluentPage({Key? key}) : super(key: key);

  @override
  State<FormeFluentPage> createState() => _State();
}

class _State extends State<FormeFluentPage> {
  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
      content: SizedBox(
        width: double.maxFinite,
        height: double.maxFinite,
        child: Forme(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            FormeFluentTextBox(
              name: 'textBox',
              suffix: Builder(builder: (context) {
                return FormeFieldStatusListener<String>(
                    filter: (status) =>
                        status.isValueChanged || status.isValidationChanged,
                    builder: (context, status, child) {
                      if (status == null) {
                        return const SizedBox.shrink();
                      }
                      final List<Widget> children = [];
                      if (status.value.isNotEmpty) {
                        children.add(
                          IconButton(
                            icon: const Icon(FluentIcons.clear),
                            onPressed: () {
                              FormeField.of(context)!.value = '';
                            },
                          ),
                        );
                      }
                      if (status.validation ==
                          FormeFieldValidation.validating) {
                        children.add(const SizedBox(
                          width: 12,
                          height: 12,
                          child: ProgressRing(),
                        ));
                      }
                      return Row(
                        mainAxisSize: MainAxisSize.min,
                        children: children,
                      );
                    });
              }),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              asyncValidator: (f, v, valid) {
                return Future.delayed(const Duration(seconds: 1), () {
                  return 'error input';
                });
              },
              placeholder: 'Type your notes here',
              decorator: const FormeFluentFormRowDecorator(),
            ),
            FormeFluentAutoSuggestBox(
              decorator: const FormeFluentFormRowDecorator(),
              name: 'autoSuggest',
              items: [
                'Blue',
                'Green',
                'Red',
                'Yellow',
                'Grey',
              ].map((e) => AutoSuggestBoxItem(value: e, label: e)).toList(),
            )
          ],
        )),
      ),
    );
  }
}
