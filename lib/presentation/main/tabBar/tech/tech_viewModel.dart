import 'dart:async';
import 'dart:ffi';
import 'package:rxdart/rxdart.dart';
import 'package:news_watch/domain/model/model.dart';
import 'package:news_watch/presentation/base/base_viewModel.dart';
import 'package:news_watch/presentation/common/state_renderer/state_renderer.dart';
import 'package:news_watch/presentation/common/state_renderer/state_renderer_impl.dart';

import '../../../../domain/usecase/tech_usecase.dart';

class TechViewModel extends BaseViewModel
    with TechViewModelInputs, TechViewModelOutputs {
  StreamController techStreamController = BehaviorSubject<List<ArticleData>>();

  TechUseCase techUseCase;
  TechViewModel(this.techUseCase);

  @override
  void dispose() {
    techStreamController.close();
  }

  @override
  void start() {
    _getBusinessDetails();
  }

  _getBusinessDetails() async {
    inputState
        .add(LoadingState(stateRendererType: StateRendererType.LOADING_STATE));
    (await techUseCase.execute(Void)).fold((failure) {
      inputState.add(ErrorState(
          stateRendererType: StateRendererType.FULLSCREEN_ERROR_STATE,
          message: failure.message));
    }, (details) {
      inputState.add(ContentState());
      inputTechDetails.add(details.article);
    });
  }

  @override
  // TODO: implement inputPopularDetails
  Sink get inputTechDetails => techStreamController.sink;

  @override
  // TODO: implement outputPopularDetails
  Stream<List<ArticleData>> get outputTechDetails =>
      techStreamController.stream.map((event) => event);

  @override
  void refresh() async {
    inputState
        .add(LoadingState(stateRendererType: StateRendererType.LOADING_STATE));
    (await techUseCase.executeIn(Void)).fold((failure) {
      inputState.add(ContentState());
    }, (details) {
      inputState.add(ContentState());
      inputTechDetails.add(details.article);
    });
  }
}

abstract class TechViewModelInputs {
  void refresh();
  Sink get inputTechDetails;
}

abstract class TechViewModelOutputs {
  Stream<List<ArticleData>> get outputTechDetails;
}
