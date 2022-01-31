import 'package:flutter/widgets.dart';
import 'package:mizer/api/plugin/provider.dart';
import 'package:mizer/app.dart';
import 'package:mizer/platform/integrated/platform.dart';
import 'package:mizer/platform/platform.dart';
import 'package:mizer/state/provider.dart';
import 'package:provider/provider.dart';

class BaseWindowState extends StatelessWidget {
  final Widget child;

  const BaseWindowState({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MizerApp(
      child: Provider<Platform>(
          create: (_) => IntegratedPlatform(),
          child: PluginApiProvider(child: StateProvider(child: child))),
    );
  }
}
