import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_test_application/models/models.dart';
import 'package:flutter_test_application/models/wishList_model.dart';
import 'dart:async';
part 'wishlist_event.dart';
part 'wishlist_state.dart';

class WishlistBloc extends Bloc<WishlistEvent, WishlistState> {
  WishlistBloc() : super(WishlistLoading()) {
    on<StartWishList>((event, emit) async {});
  }
  @override
  Stream<WishlistState> mapEventToState(
    WishlistEvent event,
  ) async* {
    if (event is StartWishList) {
      yield* _mapStartWishlistToState();
    } else if (event is AddWishListProduct) {
      yield* _mapAddWishlistProductToState(event, state);
    } else if (event is RemoveWishListProduct) {
      yield* _mapRemoveWishlistProductToState(event, state);
    }
  }

  Stream<WishlistState> _mapStartWishlistToState() async* {
    yield WishlistLoading();
    try {
      await Future<void>.delayed(const Duration(seconds: 1));
      yield const WishlistLoaded();
    } catch (_) {}
  }

  Stream<WishlistState> _mapAddWishlistProductToState(
      AddWishListProduct event, WishlistState state) async* {
    if (state is WishlistLoaded) {
      try {
        yield WishlistLoaded(
            wishList: WishList(
                products: List.from(state.wishList.products)
                  ..add(event.product)));
      } catch (_) {}
    }
  }

  Stream<WishlistState> _mapRemoveWishlistProductToState(
      RemoveWishListProduct event, WishlistState state) async* {
    if (state is WishlistLoaded) {
      try {
        yield WishlistLoaded(
            wishList: WishList(
                products: List.from(state.wishList.products)
                  ..remove(event.product)));
      } catch (_) {}
    }
  }

  @override
  void onTransition(Transition<WishlistEvent, WishlistState> transition) {
    super.onTransition(transition);
    print(transition);
  }
}
