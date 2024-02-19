import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:music_api/utils/model/apimodel.dart';
import '../global.dart';

class ApiHelper {
  ApiHelper._();

  static final ApiHelper apiHelper = ApiHelper._();

  Future<List<Apimodel>> fetchData() async {
    String apiPoint = "https://storage.googleapis.com/uamp/catalog.json";
    http.Response response = await http.get(Uri.parse(apiPoint));
    log("${response.statusCode}");
    if (response.statusCode == 200) {
      Map decodedData = jsonDecode(response.body);
      List allProduct = decodedData['music'];
      allProdyct = decodedData['music'];
      List<Apimodel> apiModel = allProduct
          .map(
            (e) => Apimodel.fromapi(data: e),
          )
          .toList();

      return apiModel;
    } else {
      throw Exception('Failed to load data');
    }
  }
}
