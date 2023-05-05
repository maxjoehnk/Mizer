import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';
import 'package:mizer/api/contracts/programmer.dart';
import 'package:mizer/api/plugin/programmer.dart';
import 'package:provider/provider.dart';

@optionalTypeArgs
mixin ProgrammerStateMixin<T extends StatefulWidget> on State<T>, TickerProvider {
  ProgrammerStatePointer? _programmerPointer;
  Ticker? _programmerTicker;
  ProgrammerState _programmerState = ProgrammerState();

  @override
  void initState() {
    super.initState();
    var programmerApi = context.read<ProgrammerApi>();
    programmerApi.getProgrammerPointer().then((pointer) {
      _programmerPointer = pointer;
      _programmerTicker = this.createTicker((elapsed) {
        setState(() {
          _programmerState = _programmerPointer!.readState();
        });
      });
      _programmerTicker!.start();
    });
  }

  @override
  void dispose() {
    _programmerPointer?.dispose();
    _programmerTicker?.stop(canceled: true);
    super.dispose();
  }

  ProgrammerState get programmerState {
    return this._programmerState;
  }
}
