import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:ecommerce_app/src/features/home/models/product_model.dart';
import 'package:ecommerce_app/src/repositories/database/database_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'favorite_event.dart';
part 'favorite_state.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  FavoriteBloc({required this.firestoreRepository})
      : super(const FavoriteState()) {
    on<AddToFavoriteEvent>(_onAddToFavorites);
    on<RemoveFromFavoriteEvent>(_onRemoveFromFavorites);
    on<LoadFavoriteProductsEvent>(_onLoadFavoriteProducts);
  }

  final DatabaseRepository firestoreRepository;
  final String userId = FirebaseAuth.instance.currentUser!.uid;

  Future<void> _onAddToFavorites(
    AddToFavoriteEvent event,
    Emitter<FavoriteState> emit,
  ) async {
    await firestoreRepository.addFavorite(userId, event.product.id);
  }

  Future<void> _onRemoveFromFavorites(
    RemoveFromFavoriteEvent event,
    Emitter<FavoriteState> emit,
  ) async {
    await firestoreRepository.removeFavorite(userId, event.product.id);
  }

  Future<void> _onLoadFavoriteProducts(
    LoadFavoriteProductsEvent event,
    Emitter<FavoriteState> emit,
  ) async {
    await emit.forEach<List<int>>(
      firestoreRepository.fetchCollectionStream(
        collectionPath: 'favorites/$userId/products',
        fromSnapshot: (snapshot) => snapshot.get('productId') as int,
      ),
      onData: (favoriteIds) {
        return state.copyWith(favoriteProductsIds: favoriteIds);
      },
      onError: (error, stackTrace) {
        log('Error loading favorites: $error');
        return state;
      },
    );
  }
}
