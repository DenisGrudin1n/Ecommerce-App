import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:country_picker/country_picker.dart';
import 'package:ecommerce_app/src/features/login/data/repositories/auth_repository.dart';
import 'package:equatable/equatable.dart';

part 'enter_phone_event.dart';
part 'enter_phone_state.dart';

class EnterPhoneBloc extends Bloc<EnterPhoneEvent, EnterPhoneState> {
  EnterPhoneBloc({required this.authRepository})
      : super(
          EnterPhoneUpdated(
            phoneNumber: '',
            country: CountryParser.parseCountryCode('UA'),
          ),
        ) {
    on<PhoneNumberChanged>(onPhoneNumberChanged);
    on<CountryChanged>(onCountryChanged);
    on<VerifyPhoneNumber>(onVerifyPhoneNumber);
  }
  final AuthRepository authRepository;

  void onPhoneNumberChanged(
    PhoneNumberChanged event,
    Emitter<EnterPhoneState> emit,
  ) {
    emit(
      EnterPhoneUpdated(
        phoneNumber: event.phoneNumber,
        country: state.country,
      ),
    );
  }

  void onCountryChanged(
    CountryChanged event,
    Emitter<EnterPhoneState> emit,
  ) {
    emit(
      EnterPhoneUpdated(
        phoneNumber: state.phoneNumber,
        country: event.country,
      ),
    );
  }

  Future<void> onVerifyPhoneNumber(
    VerifyPhoneNumber event,
    Emitter<EnterPhoneState> emit,
  ) async {
    if (state is EnterPhoneUpdated) {
      final currentState = state as EnterPhoneUpdated;
      final fullPhoneNumber =
          '+${currentState.country.phoneCode}${currentState.phoneNumber}';
      try {
        await authRepository.verifyPhoneNumber(
          phoneNumber: fullPhoneNumber,
          verificationCompleted: event.verificationCompleted,
          verificationFailed: event.verificationFailed,
          codeSent: event.codeSent,
          codeAutoRetrievalTimeout: event.codeAutoRetrievalTimeout,
        );
      } catch (e) {
        log(
          e.toString(),
        );
      }
    }
  }
}
