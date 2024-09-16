import 'package:equatable/equatable.dart';

abstract class GetStartedEvent extends Equatable {
  const GetStartedEvent();
  @override
  List<Object> get props => [];
}

class LoadGetStartedGifsEvent extends GetStartedEvent {}
