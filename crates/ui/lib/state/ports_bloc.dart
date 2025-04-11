import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:mizer/api/contracts/ports.dart';
import 'package:mizer/protos/ports.pb.dart';

@immutable
abstract class PortsCommand {}

class FetchPorts extends PortsCommand {}

class AddPort extends PortsCommand {}

class DeletePort extends PortsCommand {
  final int id;

  DeletePort(this.id);
}

@immutable
class PortsState {
  final List<NodePort> ports;

  PortsState({required this.ports});

  NodePort? port(int id) {
    return ports.firstWhereOrNull((port) => port.id == id);
  }
}

class PortsBloc extends Bloc<PortsCommand, PortsState> {
  final PortsApi api;

  PortsBloc(this.api) : super(PortsState(ports: [])) {
    on<FetchPorts>((event, emit) async => emit(await _fetchPorts()));
    on<AddPort>((event, emit) async => emit(await _addPort(event)));
    on<DeletePort>((event, emit) async => emit(await _deletePort(event)));
    this.add(FetchPorts());
  }

  Future<PortsState> _fetchPorts() async {
    log("fetching ports", name: "PortsBloc");
    var ports = await api.getPorts();
    log("got ${ports.length} ports", name: "PortsBloc");

    return PortsState(ports: ports);
  }

  Future<PortsState> _addPort(AddPort event) async {
    log("adding port", name: "PortsBloc");
    await api.addPort();

    return await _fetchPorts();
  }

  Future<PortsState> _deletePort(DeletePort event) async {
    log("deleting port", name: "PortsBlock");
    await api.deletePort(event.id);

    return await _fetchPorts();
  }
}
