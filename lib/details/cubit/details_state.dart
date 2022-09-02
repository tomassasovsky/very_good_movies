part of 'details_cubit.dart';

/// {@template details_state}
/// The cubit state of the details.
/// {@endtemplate}
abstract class DetailsState extends Equatable {
  /// {@macro details_state}
  const DetailsState();

  bool get isInitial => this is DetailsInitial;
  bool get isAttempting => this is DetailsAttempting;
  bool get isSuccess => this is DetailsSuccess;
  bool get isFailure => this is DetailsFailure;

  @override
  List<Object> get props => [];
}

/// {@template details_initial}
/// This represent the initial state of the details feature.
/// {@endtemplate}
class DetailsInitial extends DetailsState {
  /// {@macro details_initial}
  const DetailsInitial();
}

/// {@template details_attempting}
/// This represent the attempting state of the details feature.
/// {@endtemplate}
class DetailsAttempting extends DetailsState {
  /// {@macro details_attempting}
  const DetailsAttempting();
}

/// {@template details_success}
/// This represent the state of success for the details made.
/// {@endtemplate}
class DetailsSuccess extends DetailsState {
  /// {@macro details_success}
  const DetailsSuccess(this.credits);

  final Credits credits;

  @override
  List<Object> get props => [credits];
}

/// {@template details_failure}
/// This represent the state of failure for the details made.
/// {@endtemplate}
class DetailsFailure extends DetailsState {
  /// {@macro details_failure}
  const DetailsFailure();
}
