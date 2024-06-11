import 'package:flutter/material.dart';

class ShowShoppingCartScreen extends StatelessWidget {
  final List<dynamic> cartItems;

  ShowShoppingCartScreen({required this.cartItems});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('장바구니'),
      ),
      body: ListView.builder(
        itemCount: cartItems.length,
        itemBuilder: (context, index) {
          var item = cartItems[index];
          return ListTile(
            title: Text(item['product']['name']),
            subtitle: Text('수량: ${item['quantity']}'),
            trailing: Text('가격: \$${item['product']['price']}'),
          );
        },
      ),
    );
  }
}
