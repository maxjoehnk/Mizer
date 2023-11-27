import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mizer/protos/session.pb.dart';
import 'package:mizer/state/session_bloc.dart';
import 'package:nativeshell/nativeshell.dart';

class WindowTitleUpdater extends StatelessWidget {
  final Widget child;

  const WindowTitleUpdater({required this.child, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SessionBloc, SessionState>(builder: (context, state) {
      _updateTitle(context, state.currentSession.filePath);
      return child;
    });
  }

  void _updateTitle(BuildContext context, String? filePath) {
    if (filePath == null || filePath.isEmpty) {
      Window.of(context).setTitle("Mizer");
      return;
    }
    Window.of(context).setTitle("Mizer ($filePath)");
  }
}
