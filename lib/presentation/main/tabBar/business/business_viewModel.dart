import 'dart:async';
import 'dart:ffi';
import 'package:news_watch/domain/usecase/business_usecase.dart';
import 'package:rxdart/rxdart.dart';
import 'package:news_watch/domain/model/model.dart';
import 'package:news_watch/presentation/base/base_viewModel.dart';
import 'package:news_watch/presentation/common/state_renderer/state_renderer.dart';
import 'package:news_watch/presentation/common/state_renderer/state_renderer_impl.dart';

class BusinessViewModel extends BaseViewModel
    with BusinessViewModelInputs, BusinessViewModelOutputs {
  StreamController businessStreamController =
      BehaviorSubject<List<ArticleData>>();

  BusinessUseCase businessUseCase;
  BusinessViewModel(this.businessUseCase);

  @override
  void dispose() {
    businessStreamController.close();
  }

  @override
  void start() {
    _getBusinessDetails();
  }

  _getBusinessDetails() async {
    inputState
        .add(LoadingState(stateRendererType: StateRendererType.LOADING_STATE));
    (await businessUseCase.execute(Void)).fold((failure) {
      inputState.add(ErrorState(
          stateRendererType: StateRendererType.FULLSCREEN_ERROR_STATE,
          message: failure.message));
    }, (details) {
      inputState.add(ContentState());
      inputBusinessDetails.add(details.article);
    });
  }

  @override
  // TODO: implement inputPopularDetails
  Sink get inputBusinessDetails => businessStreamController.sink;

  @override
  // TODO: implement outputPopularDetails
  Stream<List<ArticleData>> get outputBusinessDetails =>
      businessStreamController.stream.map((event) => event);

  @override
  void refresh() async {
    inputState
        .add(LoadingState(stateRendererType: StateRendererType.LOADING_STATE));
    (await businessUseCase.executeIn(Void)).fold((failure) {
      inputState.add(ContentState());
    }, (details) {
      inputState.add(ContentState());
      inputBusinessDetails.add(details.article);
    });
  }
}

abstract class BusinessViewModelInputs {
  void refresh();
  Sink get inputBusinessDetails;
}

abstract class BusinessViewModelOutputs {
  Stream<List<ArticleData>> get outputBusinessDetails;
}
