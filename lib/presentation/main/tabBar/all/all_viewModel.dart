import 'dart:async';
import 'dart:ffi';
import 'package:rxdart/rxdart.dart';
import 'package:news_watch/domain/model/model.dart';
import 'package:news_watch/presentation/base/base_viewModel.dart';
import 'package:news_watch/presentation/common/state_renderer/state_renderer.dart';
import 'package:news_watch/presentation/common/state_renderer/state_renderer_impl.dart';

import '../../../../domain/usecase/all_usecase.dart';

class AllViewModel extends BaseViewModel
    with AllViewModelInputs, AllViewModelOutputs {
  StreamController allStreamController = BehaviorSubject<List<ArticleData>>();

  AllUseCase _allUseCase;
  AllViewModel(this._allUseCase);

  @override
  void dispose() {
    allStreamController.close();
  }

  @override
  void start() {
    _getAllDetails();
  }

  _getAllDetails() async {
    inputState
        .add(LoadingState(stateRendererType: StateRendererType.LOADING_STATE));
    (await _allUseCase.execute(Void)).fold((failure) {
      inputState.add(ErrorState(
          stateRendererType: StateRendererType.FULLSCREEN_ERROR_STATE,
          message: failure.message));
    }, (details) {
      inputState.add(ContentState());
      inputAllDetails.add(details.article);
    });
  }

  @override
  // TODO: implement inputPopularDetails
  Sink get inputAllDetails => allStreamController.sink;

  @override
  // TODO: implement outputPopularDetails
  Stream<List<ArticleData>> get outputAllDetails =>
      allStreamController.stream.map((event) => event);

  @override
  void refresh() async {
    inputState
        .add(LoadingState(stateRendererType: StateRendererType.LOADING_STATE));
    (await _allUseCase.executeIn(Void)).fold((failure) {
      inputState.add(ContentState());
    }, (details) {
      inputState.add(ContentState());
      inputAllDetails.add(details.article);
    });
  }
}

abstract class AllViewModelInputs {
  void refresh();
  Sink get inputAllDetails;
}

abstract class AllViewModelOutputs {
  Stream<List<ArticleData>> get outputAllDetails;
}
