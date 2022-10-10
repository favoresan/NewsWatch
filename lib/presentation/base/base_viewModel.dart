import 'dart:async';

import '../common/state_renderer/state_renderer_impl.dart';

abstract class BaseViewModel extends BaseViewModelOutputs
    with BaseViewModelInputs {
  StreamController inputStreamController =
      StreamController<FlowState>.broadcast();

  @override
  Sink get inputState => inputStreamController.sink;

  @override
  Stream<FlowState> get outputState =>
      inputStreamController.stream.map((event) => event);
}

abstract class BaseViewModelInputs {
  void start();
  void dispose();
  Sink get inputState;
}

abstract class BaseViewModelOutputs {
  Stream<FlowState> get outputState;
}
