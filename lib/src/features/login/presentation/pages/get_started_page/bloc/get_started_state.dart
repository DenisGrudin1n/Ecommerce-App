import 'package:ecommerce_app/src/features/login/models/get_started_gif_model.dart';
import 'package:equatable/equatable.dart';

class GetStartedState extends Equatable {
  const GetStartedState({
    this.gifs = const [],
    this.isLoadingGifs = false,
    this.gifsErrorMessage = '',
  });

  final List<GetStartedGifModel> gifs;

  final bool isLoadingGifs;

  final String gifsErrorMessage;

  GetStartedState copyWith({
    List<GetStartedGifModel>? gifs,
    bool? isLoadingGifs,
    String? gifsErrorMessage,
  }) {
    return GetStartedState(
      gifs: gifs ?? this.gifs,
      isLoadingGifs: isLoadingGifs ?? this.isLoadingGifs,
      gifsErrorMessage: gifsErrorMessage ?? this.gifsErrorMessage,
    );
  }

  @override
  List<Object> get props => [
        gifs,
        isLoadingGifs,
        gifsErrorMessage,
      ];
}
