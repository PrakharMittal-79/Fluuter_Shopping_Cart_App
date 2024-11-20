import 'package:flutter/material.dart';
import 'package:login_signup_app/src/cart/controller/cart_controller.dart';
import 'package:login_signup_app/src/cart/model/cart_model.dart';
// import 'package:provider/provider.dart';

class Cartpage extends StatefulWidget {
  final CartController cartManager;
  const Cartpage({super.key, required this.cartManager});

  @override
  State<Cartpage> createState() => _CartpageState();
}

class _CartpageState extends State<Cartpage> {
  @override
  Widget build(BuildContext context) {
    // final cart = Provider.of<CartProvider>(context).cart;
    return Scaffold(
      appBar: AppBar(
        title: Center(
            child: Text(
          "Your Cart",
          style: Theme.of(context).textTheme.titleMedium,
        )),
      ),
      body: Column(
        children: [
          Expanded(
              child: StreamBuilder<List<CartItem>>(
                  stream: widget.cartManager.cartStream,
                  builder: (context, snapshot) {
                    if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Center(child: Text('Your cart is empty!'));
                    }
                    final cart = snapshot.data!;
                    return ListView.builder(
                        itemCount: cart.length,
                        itemBuilder: (context, i) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListTile(
                              tileColor:
                                  const Color.fromARGB(255, 203, 198, 198),
                              leading: CircleAvatar(
                                backgroundImage: NetworkImage(cart[i].imageUrl),
                                radius: 35,
                              ),
                              title: Text(
                                cart[i].title,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text(cart[i].price.toString()),
                              trailing: IconButton(
                                onPressed: () {
                                  widget.cartManager.removefromCart(cart[i]);

                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text(
                                              "Product Deleted Successfully!")));
                                },
                                icon: const Icon(Icons.delete),
                                iconSize: 30,
                                color: Colors.red,
                              ),
                            ),
                          );
                        });
                  })),
        ],
      ),
    );
  }
}
