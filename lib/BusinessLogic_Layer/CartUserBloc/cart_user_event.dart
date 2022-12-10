part of 'cart_user_bloc.dart';

abstract class CartUserEvent extends Equatable {
  const CartUserEvent();
  @override
  List<Object> get props => [];
}
class GetListEquipmentFromSpecificLab  extends CartUserEvent {
  final String labName ;
  const GetListEquipmentFromSpecificLab(this.labName);
  @override
  List<Object> get props => [labName];
}
