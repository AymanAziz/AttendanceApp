import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'cart_user_event.dart';
part 'cart_user_state.dart';

class CartUserBloc extends Bloc<CartUserEvent, CartUserState> {
  CartUserBloc() : super(CartUserInitial()) {
    on<CartUserEvent>((event, emit) {
      // TODO: implement event handler
    });


  }
}
