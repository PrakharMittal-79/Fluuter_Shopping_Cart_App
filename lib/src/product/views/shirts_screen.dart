import 'package:flutter/material.dart';
import 'package:login_signup_app/src/product/constants/product_shirt_data.dart';
import 'package:login_signup_app/src/product/widgets/item_card.dart';
import 'package:login_signup_app/src/product/views/product_detail_screen.dart';
import 'package:login_signup_app/src/product/services/shirt_services.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<Homepage> {
  final List<String> filter = const [
    'All',
    'Allen Solly',
    'Raymond',
    'U.S. POLO',
    'Tommy Hilfiger'
  ];
  late String selectedFilter;
  final ShirtServices _shirtServices = ShirtServices();
  late Future futurePost;

  @override
  void initState() {
    super.initState();
    selectedFilter = filter.first;
    futurePost = _shirtServices.requestShirts(requestData);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    const border = OutlineInputBorder(
      borderRadius: BorderRadius.horizontal(left: Radius.circular(50)),
    );
    return Scaffold(
      body: Column(children: [
        const Row(
          children: [
            Padding(
              padding: EdgeInsets.all(20),
              child: Text(
                "Shirt\nCollection",
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.w900),
              ),
            ),
            Expanded(
              child: TextField(
                  decoration: InputDecoration(
                hintText: "Search",
                prefixIcon: Icon(Icons.search),
                enabledBorder: border,
                focusedBorder: border,
              )),
            ),
          ],
        ),
        SizedBox(
          height: size.height * 0.1,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: filter.length,
              itemBuilder: (context, i) {
                final shirt = filter[i];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedFilter = shirt;
                      });
                    },
                    child: Chip(
                      label: Text(
                        shirt,
                        style: TextStyle(
                            color: selectedFilter == shirt
                                ? Colors.white
                                : Colors.black),
                      ),
                      labelStyle: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w600),
                      side: const BorderSide(
                        color: Color.fromRGBO(245, 247, 249, 1),
                      ),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                      shadowColor: const Color.fromARGB(255, 228, 228, 228),
                      elevation: 6,
                      backgroundColor: selectedFilter == shirt
                          ? Theme.of(context).colorScheme.primary
                          : Theme.of(context).colorScheme.secondary,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 15),
                    ),
                  ),
                );
              }),
        ),
        FutureBuilder(
          future: futurePost,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (snapshot.hasData) {
              final shirts = snapshot.data!;
              return Expanded(
                child: GridView.builder(
                    itemCount: shirts.length,
                    padding:const EdgeInsets.all(8),
                    gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 3,
                        mainAxisSpacing: 8,
                        childAspectRatio: 0.55
                        ),
                    itemBuilder: (context, i) {
                      return GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>
                                    ProductDetails(product: shirts[i])));
                          },
                          child: ItemCard(
                              title: shirts[i]['title'] as String,
                              brand: shirts[i]['brand'] as String,
                              price: shirts[i]['price'],
                              discountedPrice: shirts[i]['discounted_price'],
                              image: shirts[i]['image_url'] as String,
                              index: i),

                      );
                    }),
              );
            } else {
              return const Center(child: Text('Failed to Fetch data.'));
            }
          },
        ),
      ]),
    );
  }
}
