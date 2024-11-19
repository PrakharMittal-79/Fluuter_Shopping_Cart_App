import 'package:flutter/material.dart';

class Profilepage extends StatefulWidget {
  const Profilepage({super.key});

  @override
  State<Profilepage> createState() => _ProfilepageState();
}

class _ProfilepageState extends State<Profilepage> {
  // final ShirtServices _shirtServices = ShirtServices();
  // late Future futurePost;
  @override
  // void initState() {
  //   super.initState();
  //   futurePost = _shirtServices.requestShirts(requestData);
  // }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      // appBar: AppBar(
      //     title: const Text(
      //   "Men's Shirt",
      // )),
      // body: FutureBuilder(
      //   future: futurePost,
      //   builder: (context, snapshot) {
      //     if (snapshot.connectionState == ConnectionState.waiting) {
      //       return const Center(child: CircularProgressIndicator());
      //     } else if (snapshot.hasError) {
      //       return Center(child: Text('Error: ${snapshot.error}'));
      //     } else if (snapshot.hasData) {
      //       return const Center(child: Text('Data successfully Fetched!'));
      //     } else {
      //       return const Center(child: Text('Failed to Fetch data.'));
      //     }
      //   },
      // ),
    );
  }
}
