part of 'filter_bloc.dart';

abstract class FilterEvent extends Equatable {
  const FilterEvent();

  @override
  List<Object?> get props => [];
}

class ChangeMinValueEvent extends FilterEvent {
  const ChangeMinValueEvent(this.minValue);
  final double minValue;

  @override
  List<Object?> get props => [minValue];
}

class ChangeMaxValueEvent extends FilterEvent {
  const ChangeMaxValueEvent(this.maxValue);
  final double maxValue;

  @override
  List<Object?> get props => [maxValue];
}

class ChangeRangeSliderEvent extends FilterEvent {
  const ChangeRangeSliderEvent(this.rangeValues);
  final RangeValues rangeValues;

  @override
  List<Object?> get props => [rangeValues];
}
