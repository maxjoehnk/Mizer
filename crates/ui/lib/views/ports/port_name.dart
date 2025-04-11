import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mizer/state/ports_bloc.dart';

class PortName extends StatelessWidget {
  final int portId;

  const PortName({super.key, required this.portId});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PortsBloc, PortsState>(
      builder: (context, state) {
        var port = state.port(portId);
        if (port == null) {
          return Container();
        }

        return Text(
          port.name
        );
      }
    );
  }
}
