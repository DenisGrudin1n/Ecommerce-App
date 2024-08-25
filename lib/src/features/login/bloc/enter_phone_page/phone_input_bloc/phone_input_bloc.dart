import 'package:bloc/bloc.dart';
import 'package:country_picker/country_picker.dart';
import 'package:equatable/equatable.dart';

part 'phone_input_event.dart';
part 'phone_input_state.dart';

class PhoneInputBloc extends Bloc<PhoneInputEvent, PhoneInputState> {
  PhoneInputBloc() : super(PhoneInputInitial()) {
    on<PhoneNumberChanged>(onPhoneNumberChanged);
    on<CountryChanged>(onCountryChanged);
  }

  void onPhoneNumberChanged(
    PhoneNumberChanged event,
    Emitter<PhoneInputState> emit,
  ) {
    if (state is PhoneInputUpdated) {
      final currentState = state as PhoneInputUpdated;
      emit(
        PhoneInputUpdated(event.phoneNumber, currentState.country),
      );
    } else {
      emit(
        PhoneInputUpdated(
          event.phoneNumber,
          CountryParser.parseCountryCode('UA'),
        ),
      );
    }
  }

  void onCountryChanged(CountryChanged event, Emitter<PhoneInputState> emit) {
    if (state is PhoneInputUpdated) {
      final currentState = state as PhoneInputUpdated;
      emit(
        PhoneInputUpdated(currentState.phoneNumber, event.country),
      );
    } else {
      emit(
        PhoneInputUpdated('', event.country),
      );
    }
  }
}
