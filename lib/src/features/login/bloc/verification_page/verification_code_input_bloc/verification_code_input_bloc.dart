import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'verification_code_input_event.dart';
part 'verification_code_input_state.dart';

class VerificationCodeBloc
    extends Bloc<VerificationCodeEvent, VerificationCodeState> {
  VerificationCodeBloc() : super(VerificationCodeInitial()) {
    on<CodeChanged>(onCodeChanged);
  }

  void onCodeChanged(
    CodeChanged event,
    Emitter<VerificationCodeState> emit,
  ) {
    if (state is VerificationCodeUpdated) {
      emit(
        VerificationCodeUpdated(
          event.code,
        ),
      );
    } else {
      emit(
        VerificationCodeUpdated(
          event.code,
        ),
      );
    }
  }
}
