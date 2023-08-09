import 'package:flutter/material.dart';
import 'package:mizer/api/mobile/provider.dart';
import 'package:mizer/app.dart';
import 'package:mizer/i18n.dart';
import 'package:mizer/widgets/panel.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await MizerI18n.loadTranslations();
  runApp(MizerMobileUi());
}

class MizerMobileUi extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MizerApp(child: MobileApiProvider(child: FixtureList()));
  }
}

class FixtureList extends StatelessWidget {
  const FixtureList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mizer'),
      ),
      body: Panel(
        label: 'Fixtures',
        actions: [
          PanelActionModel(label: "Highlight"),
          PanelActionModel(label: "Select All"),
          PanelActionModel(label: "Clear"),
          PanelActionModel(label: "Prev"),
          PanelActionModel(label: "Next"),
        ],
        child: ListView(children: [])
      ),
    );
  }
}

