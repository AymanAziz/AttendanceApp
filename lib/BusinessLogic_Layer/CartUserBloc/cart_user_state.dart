part of 'cart_user_bloc.dart';

abstract class CartUserState extends Equatable {
  const CartUserState();
}

class CartUserInitial extends CartUserState {
  @override
  List<Object> get props => [];
}
