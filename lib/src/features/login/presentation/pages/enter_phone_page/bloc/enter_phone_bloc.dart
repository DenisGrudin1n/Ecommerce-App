import 'package:bloc/bloc.dart';
import 'package:country_picker/country_picker.dart';
import 'package:equatable/equatable.dart';

part 'enter_phone_event.dart';
part 'enter_phone_state.dart';

class EnterPhoneBloc extends Bloc<EnterPhoneEvent, EnterPhoneState> {
  EnterPhoneBloc()
      : super(EnterPhoneUpdated('', CountryParser.parseCountryCode('UA'))) {
    on<PhoneNumberChanged>(onPhoneNumberChanged);
    on<CountryChanged>(onCountryChanged);
  }

  void onPhoneNumberChanged(
    PhoneNumberChanged event,
    Emitter<EnterPhoneState> emit,
  ) {
    if (state is EnterPhoneUpdated) {
      final currentState = state as EnterPhoneUpdated;
      emit(
        EnterPhoneUpdated(event.phoneNumber, currentState.country),
      );
    } else {
      emit(
        EnterPhoneUpdated(
          event.phoneNumber,
          CountryParser.parseCountryCode('UA'),
        ),
      );
    }
  }

  void onCountryChanged(CountryChanged event, Emitter<EnterPhoneState> emit) {
    if (state is EnterPhoneUpdated) {
      final currentState = state as EnterPhoneUpdated;
      emit(
        EnterPhoneUpdated(currentState.phoneNumber, event.country),
      );
    } else {
      emit(
        EnterPhoneUpdated('', event.country),
      );
    }
  }
}
