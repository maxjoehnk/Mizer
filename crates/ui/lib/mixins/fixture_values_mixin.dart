import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';
import 'package:mizer/api/contracts/plans.dart';
import 'package:mizer/api/plugin/ffi/plans.dart';
import 'package:mizer/protos/fixtures.pb.dart';
import 'package:provider/provider.dart';

@optionalTypeArgs
mixin FixtureValuesMixin<T extends StatefulWidget> on State<T>, TickerProvider {
  FixturesRefPointer? _fixturesPointer;
  Ticker? _fixtureValuesTicker;
  FixturesState _fixturesState = FixturesState();

  @override
  void initState() {
    super.initState();
    var plansApi = context.read<PlansApi>();
    plansApi.getFixturesPointer().then((pointer) {
      _fixturesPointer = pointer;
      _fixtureValuesTicker = this.createTicker((elapsed) {
        setState(() {
          _fixturesState = _fixturesPointer!.readStates();
        });
      });
      _fixtureValuesTicker!.start();
    });
  }

  @override
  void dispose() {
    _fixturesPointer?.dispose();
    _fixtureValuesTicker?.stop(canceled: true);
    super.dispose();
  }

  Map<FixtureId, FixtureValues> get fixtureValues {
    return this._fixturesState.fixtureStates;
  }
}
