part of 'details_cubit.dart';

abstract class DetailsState extends Equatable {
  const DetailsState();

  bool get isInitial => this is DetailsInitial;
  bool get isAttempting => this is DetailsAttempting;
  bool get isSuccess => this is DetailsSuccess;
  bool get isFailure => this is DetailsFailure;

  @override
  List<Object> get props => [];
}

class DetailsInitial extends DetailsState {
  const DetailsInitial();
}

class DetailsAttempting extends DetailsState {
  const DetailsAttempting();
}

class DetailsSuccess extends DetailsState {
  const DetailsSuccess(this.credits);

  final Credits credits;

  @override
  List<Object> get props => [credits];
}

class DetailsFailure extends DetailsState {
  const DetailsFailure();
}
