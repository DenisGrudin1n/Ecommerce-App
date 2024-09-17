import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'filter_event.dart';
part 'filter_state.dart';

class FilterBloc extends Bloc<FilterEvent, FilterState> {
  FilterBloc() : super(const FilterState()) {
    on<ChangeMinValueEvent>(_onMinValueChanged);
    on<ChangeMaxValueEvent>(_onMaxValueChanged);
    on<ChangeRangeSliderEvent>(_onRangeSliderChanged);
  }

  void _onMinValueChanged(
    ChangeMinValueEvent event,
    Emitter<FilterState> emit,
  ) {
    final minValue = event.minValue;
    final maxValue = state.maxValue >= minValue ? state.maxValue : minValue;

    emit(
      state.copyWith(
        minValue: minValue,
        maxValue: maxValue,
        rangeValues: RangeValues(minValue, maxValue),
      ),
    );
  }

  void _onMaxValueChanged(
    ChangeMaxValueEvent event,
    Emitter<FilterState> emit,
  ) {
    final maxValue = event.maxValue;
    final minValue = state.minValue <= maxValue ? state.minValue : maxValue;

    emit(
      state.copyWith(
        maxValue: maxValue,
        minValue: minValue,
        rangeValues: RangeValues(minValue, maxValue),
      ),
    );
  }

  void _onRangeSliderChanged(
    ChangeRangeSliderEvent event,
    Emitter<FilterState> emit,
  ) {
    final rangeValues = event.rangeValues;
    final minValue = rangeValues.start;
    final maxValue = rangeValues.end;

    emit(
      state.copyWith(
        rangeValues: rangeValues,
        minValue: minValue,
        maxValue: maxValue,
      ),
    );
  }
}
