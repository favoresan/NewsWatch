import 'package:flutter/material.dart';
import 'package:news_watch/presentation/common/state_renderer/state_renderer.dart';

import '../../../data/mapper/mapper.dart';
import '../../resources/string_manager.dart';

abstract class FlowState {
  StateRendererType getStateRendererType();
  String getMessage();
}

class LoadingState extends FlowState {
  StateRendererType stateRendererType;
  String message;
  LoadingState({required this.stateRendererType, String? message})
      : message = message ?? AppStrings.loading;
  @override
  String getMessage() => message;

  @override
  StateRendererType getStateRendererType() => stateRendererType;
}

class ErrorState extends FlowState {
  StateRendererType stateRendererType;
  String message;
  ErrorState({required this.stateRendererType, required this.message});

  @override
  String getMessage() => message;

  @override
  StateRendererType getStateRendererType() => stateRendererType;
}

class ContentState extends FlowState {
  ContentState();
  @override
  String getMessage() => EMPTY;

  @override
  StateRendererType getStateRendererType() =>
      StateRendererType.CONTENT_SCREEN_STATE;
}

class EmptyState extends FlowState {
  String message;
  EmptyState(this.message);
  @override
  String getMessage() => message;

  @override
  StateRendererType getStateRendererType() =>
      StateRendererType.EMPTY_SCREEN_STATE;
}

extension FlowStateExtension on FlowState {
  Widget getScreenWidget(BuildContext context, Widget contentScreenWidget,
      Function retryActionFunction) {
    switch (this.runtimeType) {
      case LoadingState:
        {
          return StateRenderer(
            retryActionFunction: retryActionFunction,
            stateRendererType: getStateRendererType(),
            message: getMessage(),
          );
        }
      case EmptyState:
        {
          return StateRenderer(
            retryActionFunction: retryActionFunction,
            stateRendererType: getStateRendererType(),
            message: getMessage(),
          );
        }
      case ErrorState:
        {
          return StateRenderer(
            retryActionFunction: retryActionFunction,
            stateRendererType: getStateRendererType(),
            message: getMessage(),
          );
        }
      case ContentState:
        {
          return contentScreenWidget;
        }
      default:
        {
          return contentScreenWidget;
        }
    }
  }
}
