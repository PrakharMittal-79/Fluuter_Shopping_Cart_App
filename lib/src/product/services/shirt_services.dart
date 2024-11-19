
import 'package:dio/dio.dart';

class ShirtServices {
  final String shirtAPI =
      "https://surgicaladdonsapi.pythonanywhere.com/postData";
  final Dio dio = Dio();

  // Method to send the POST request with the list of shirt data
  Future<List<Map<String, dynamic>>> requestShirts(
      List<Map<String, dynamic>> shirtsData) async {
    try {
      final res = await dio.post(shirtAPI, data: shirtsData);

      // Checking if the status code is successful
      if (res.statusCode == 200 || res.statusCode == 201) {
        // Decode the response data (usually the response is in JSON format)
        List<Map<String, dynamic>> responseData =
            List<Map<String, dynamic>>.from(res.data);

        // Return the decoded data
        return responseData;
      } else {
        throw Exception("Failed to load data: ${res.statusCode}");
      }
    } catch (e) {
      print("Error occurred: $e");
      throw Exception("Error occurred while fetching data.");
    }
  }
}
