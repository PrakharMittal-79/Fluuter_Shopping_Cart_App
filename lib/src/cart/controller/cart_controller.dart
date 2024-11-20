import 'dart:async';

import 'package:flutter/material.dart';
import 'package:login_signup_app/src/cart/model/cart_model.dart';

//Provider
class CartProvider extends ChangeNotifier {
  List<Map<String, dynamic>> cart = [];

  void addToCart(Map<String, dynamic> product) {
    cart.add(product);
    notifyListeners();
  }

  void removeFromCart(Map<String, dynamic> product) {
    cart.remove(product);
    notifyListeners();
  }
}

//StreamBuilder
class CartController {
  final _cartController = StreamController<List<CartItem>>.broadcast();
  final List<CartItem> cartItems = [];
  Stream<List<CartItem>> get cartStream => _cartController.stream;

  void addToCart(CartItem item) {
    final existingItem = cartItems.firstWhere(
      (cartItem) => cartItem.id == item.id,
      orElse: () => CartItem(
          id: '', title: '', price: 0, quantity: 0, imageUrl: ""), // Dummy item
    );
    if (existingItem.id == '') {
      cartItems.add(item);
    } else {
      existingItem.quantity += item.quantity;
    }
    _cartController.sink.add(List.unmodifiable(cartItems));
  }

  void removefromCart(CartItem item) {
    cartItems.removeWhere((cartItem) {
      return cartItem.id == item.id;
    });
    _cartController.sink.add(List.unmodifiable(cartItems));
  }

  void clearCart() {
    cartItems.clear();
    _cartController.sink.add(List.unmodifiable(cartItems));
  }
}
