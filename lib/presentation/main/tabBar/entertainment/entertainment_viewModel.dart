import 'dart:async';
import 'dart:ffi';
import 'package:news_watch/domain/usecase/entertainment_usecase.dart';
import 'package:rxdart/rxdart.dart';
import 'package:news_watch/domain/model/model.dart';
import 'package:news_watch/presentation/base/base_viewModel.dart';
import 'package:news_watch/presentation/common/state_renderer/state_renderer.dart';
import 'package:news_watch/presentation/common/state_renderer/state_renderer_impl.dart';

class EntertainmentViewModel extends BaseViewModel
    with EntertainmentViewModelInputs, EntertainmentViewModelOutputs {
  StreamController entertainmentStreamController =
      BehaviorSubject<List<ArticleData>>();

  EntertainmentUseCase entertainmentUseCase;
  EntertainmentViewModel(this.entertainmentUseCase);

  @override
  void dispose() {
    entertainmentStreamController.close();
  }

  @override
  void start() {
    _getBusinessDetails();
  }

  _getBusinessDetails() async {
    inputState
        .add(LoadingState(stateRendererType: StateRendererType.LOADING_STATE));
    (await entertainmentUseCase.execute(Void)).fold((failure) {
      inputState.add(ErrorState(
          stateRendererType: StateRendererType.FULLSCREEN_ERROR_STATE,
          message: failure.message));
    }, (details) {
      inputState.add(ContentState());
      inputEntertainmentDetails.add(details.article);
    });
  }

  @override
  // TODO: implement inputPopularDetails
  Sink get inputEntertainmentDetails => entertainmentStreamController.sink;

  @override
  // TODO: implement outputPopularDetails
  Stream<List<ArticleData>> get outputEntertainmentDetails =>
      entertainmentStreamController.stream.map((event) => event);

  @override
  void refresh() async {
    inputState
        .add(LoadingState(stateRendererType: StateRendererType.LOADING_STATE));
    (await entertainmentUseCase.executeIn(Void)).fold((failure) {
      inputState.add(ContentState());
    }, (details) {
      inputState.add(ContentState());
      inputEntertainmentDetails.add(details.article);
    });
  }
}

abstract class EntertainmentViewModelInputs {
  void refresh();
  Sink get inputEntertainmentDetails;
}

abstract class EntertainmentViewModelOutputs {
  Stream<List<ArticleData>> get outputEntertainmentDetails;
}
