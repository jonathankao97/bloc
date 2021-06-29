import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

/// An interface for observing the behavior of [Bloc] instances.
class BlocObserver {
  /// Called whenever a [Bloc] is instantiated.
  /// In many cases, a cubit may be lazily instantiated and
  /// [onCreate] can be used to observe exactly when the cubit
  /// instance is created.
  ///
  Map<String, BlocBase> blocMap = {};

  @protected
  @mustCallSuper
  void onCreate(BlocBase bloc) {
    var id = identityHashCode(bloc).toString();
    blocMap[id] = bloc;
    postEvent('bloc:bloc_map_changed', <Object?, Object?>{});
  }

  /// Called whenever an [event] is `added` to any [bloc] with the given [bloc]
  /// and [event].
  @protected
  @mustCallSuper
  void onEvent(Bloc bloc, Object? event) {
    postEvent('bloc:bloc_map_changed', <Object?, Object?>{});
  }

  /// Called whenever a [Change] occurs in any [bloc]
  /// A [change] occurs when a new state is emitted.
  /// [onChange] is called before a bloc's state has been updated.
  @protected
  @mustCallSuper
  void onChange(BlocBase bloc, Change change) {
    postEvent('bloc:bloc_map_changed', <Object?, Object?>{});
  }

  /// Called whenever a transition occurs in any [bloc] with the given [bloc]
  /// and [transition].
  /// A [transition] occurs when a new `event` is `added` and `mapEventToState`
  /// executed.
  /// [onTransition] is called before a [bloc]'s state has been updated.
  @protected
  @mustCallSuper
  void onTransition(Bloc bloc, Transition transition) {
    postEvent('bloc:bloc_map_changed', <Object?, Object?>{});
  }

  /// Called whenever an [error] is thrown in any [Bloc] or [Cubit].
  /// The [stackTrace] argument may be [StackTrace.empty] if an error
  /// was received without a stack trace.
  @protected
  @mustCallSuper
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    postEvent('bloc:bloc_map_changed', <Object?, Object?>{});
  }

  /// Called whenever a [Bloc] is closed.
  /// [onClose] is called just before the [Bloc] is closed
  /// and indicates that the particular instance will no longer
  /// emit new states.
  @protected
  @mustCallSuper
  void onClose(BlocBase bloc) {
    var id = identityHashCode(bloc).toString();
    blocMap.remove(id);
    postEvent('bloc:bloc_map_changed', <Object?, Object?>{});
  }
}
