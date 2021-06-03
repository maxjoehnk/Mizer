import 'dart:async';
import 'dart:developer';

import 'contracts/nodes.dart';

class PreviewHandler {
  final NodesApi nodesApi;
  bool isScheduled = false;
  List<QueuedHistoryTask> tasks = [];

  PreviewHandler(this.nodesApi);

  Future<List<double>> getNodeHistory(String path) {
    var task = QueuedHistoryTask(path: path);
    tasks.add(task);
    _scheduleQuery();
    
    return task.asFuture();
  }

  _scheduleQuery() {
    if (isScheduled) {
      return;
    }
    scheduleMicrotask(_runQuery);
    isScheduled = true;
  }

  _runQuery() {
    var tasks = this.tasks;
    log("batched ${tasks.length} history queries");
    this.tasks = [];
    isScheduled = false;
    nodesApi
      .getNodeHistories(tasks.map((task) => task.path).toList())
      .then((histories) {
        for (var task in tasks) {
          task.complete(histories[task.path]);
        }
      });
  }
}

class QueuedHistoryTask {
  final String path;
  final Completer<List<double>> _completer;

  QueuedHistoryTask({this.path}) : _completer = Completer();

  Future<List<double>> asFuture() {
    return _completer.future;
  }

  void complete(List<double> values) {
    _completer.complete(values);
  }
}
