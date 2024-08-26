import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'resend_code_event.dart';
part 'resend_code_state.dart';

class ResendCodeBloc extends Bloc<ResendCodeEvent, ResendCodeState> {
  ResendCodeBloc() : super(ResendCodeInitial()) {
    on<ResendCodeUpdated>((event, emit) {
      emit(ResendCodeLoaded(event.verificationId));
    });
  }
}
