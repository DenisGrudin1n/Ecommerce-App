part of 'filter_bloc.dart';

class FilterState extends Equatable {
  const FilterState({
    this.minValue = 0.0,
    this.maxValue = 5000.0,
    this.rangeValues = const RangeValues(0, 5000),
  });

  final double minValue;
  final double maxValue;
  final RangeValues rangeValues;

  FilterState copyWith({
    double? minValue,
    double? maxValue,
    RangeValues? rangeValues,
  }) {
    return FilterState(
      minValue: minValue ?? this.minValue,
      maxValue: maxValue ?? this.maxValue,
      rangeValues: rangeValues ?? this.rangeValues,
    );
  }

  @override
  List<Object?> get props => [minValue, maxValue, rangeValues];
}
