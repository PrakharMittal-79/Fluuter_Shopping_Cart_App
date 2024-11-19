import 'package:flutter/material.dart';
import 'package:login_signup_app/src/authentication/controller/cart_provider.dart';
import 'package:login_signup_app/src/home/constants/constraints.dart';
import 'package:provider/provider.dart';

class ProductDetails extends StatefulWidget {
  final Map<String, dynamic> product;
  const ProductDetails({super.key, required this.product});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  late int size;
  @override
  void initState() {
    super.initState();
    size = -1;
  }

  addProduct() {
    if (size != -1) {
      Provider.of<CartProvider>(context, listen: false).addToCart({
        'id': widget.product['id'],
        'title': widget.product['title'],
        'price': widget.product['price'],
        'image_url': widget.product['image_url'],
        'brand': widget.product['brand'],
        'size': widget.product['size'][size] as String,
      });
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Product Added Successfully!")));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Please select size first!")));
    }
    // print(Provider.of<CartProvider>(context).cart);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: const Text(
          "Details",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Column(children: [
              Text(
                widget.product['title'],
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Image.network(widget.product['image_url'] as String),
              Text(
                "Price: \$${widget.product['price']}",
                style: const TextStyle(fontSize: 20),
              ),
              Row(
                children: [
                  const Text("Available Sizes: "),
                  for (int k = 0; k < widget.product['size']?.length; k++)
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          size = k;
                        });
                      },
                      child: Chip(
                        padding: const EdgeInsets.all(5),
                        label: Text(widget.product['size'][k] as String),
                        backgroundColor:
                            size == k ? kPrimartLightColor : Colors.white,
                      ),
                    )
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              FloatingActionButton.extended(
                onPressed: addProduct,
                backgroundColor: kPrimartLightColor,
                icon: const Icon(
                  Icons.shopping_cart,
                  size: 24,
                  color: kPrimaryColor,
                ),
                label: const Text(
                  "Add to cart",
                  style: TextStyle(color: kPrimaryColor),
                ),
              )
            ]),
          )),
    ));
  }
}
