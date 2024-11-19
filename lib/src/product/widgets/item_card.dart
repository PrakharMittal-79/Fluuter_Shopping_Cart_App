import 'package:flutter/material.dart';

class ItemCard extends StatelessWidget {
  final String title;
  final String brand;
  final int price;
  final int discountedPrice;
  final String image;
  final int index;

  const ItemCard({
    super.key,
    required this.title,
    required this.price,
    required this.image,
    required this.index,
    required this.brand, required this.discountedPrice,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: (index.isEven)
            ? Theme.of(context).colorScheme.secondary
            : const Color.fromARGB(255, 238, 238, 238),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 6,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10), // Optional rounding
                child: Image.network(
                  image,
                  fit: BoxFit.cover, // Ensures the image fits within the box
                  width: double.infinity, // Constrains to container width
                  height: double.infinity, // Constrains to container height
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return const CircularProgressIndicator();
                  },
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(
                      Icons.broken_image,
                      color: Colors.grey,
                      size: 48,
                    );
                  },
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  brand,
                  style: const TextStyle(
                      fontWeight: FontWeight.w900, fontSize: 20),
                  maxLines: 1, // Truncate long titles
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  title,
                  style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      color: Color.fromARGB(255, 99, 99, 99),
                      fontSize: 18),
                  maxLines: 1, // Truncate long titles
                  overflow: TextOverflow.ellipsis,
                ),
                Row(
                  children: [
                    Text('\u20B9 $price',
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w800)),
                    const SizedBox(width: 8,),
                    Text(
                      '\u20B9 $discountedPrice',
                      style: const TextStyle(
                        color: Color.fromARGB(255, 102, 100, 100),
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                          decoration: TextDecoration.lineThrough),
                    ),
                  ],
                )
              ],
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
