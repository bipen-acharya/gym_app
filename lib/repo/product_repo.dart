import 'dart:convert';
import 'dart:developer';
import 'package:gym_app/models/product_history.dart';
import 'package:gym_app/models/products.dart';
import 'package:gym_app/utils/storage_keys.dart';
import 'package:http/http.dart' as http;
import '../utils/apis.dart';

class ProductRepo {
  static Future<void> getProducts({
    required Function(List<Products> product) onSuccess,
    required Function(String message) onError,
  }) async {
    try {
      var token = StorageHelper.getUser()!.token;

      print(token.toString());
      var headers = {
        "Accept": "application/json",
        "Authorization": "Bearer ${token.toString()}",
      };

      http.Response response = await http.get(
        Uri.parse(Api.products),
        headers: headers,
      );
      dynamic data = json.decode(response.body);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        List<Products> product = productFromJson(data["data"]);
        onSuccess(product);
      } else {
        onError(data['message']);
      }
    } catch (e) {
      log(e.toString());
      onError("Sorry! something went wrong");
    }
  }

  static Future<void> postOrder({
    required var items,
    required Function() onSuccess,
    required Function(String message) onError,
  }) async {
    try {
      var token = StorageHelper.getUser()!.token;

      var headers = {
        "Accept": "application/json",
        "Authorization": "Bearer ${token.toString()}",
        "Content-Type": "application/json"
      };

      var body = json.encode(items);
      log('--------json enconded ---------$body');
      http.Response response =
          await http.post(Uri.parse(Api.orders), headers: headers, body: body);

      dynamic data = json.decode(response.body);
      log(data.toString());
      if (response.statusCode >= 200 && response.statusCode < 300) {
        log("past order");
        onSuccess();
      } else {
        onError(data['message']);
      }
    } catch (e, s) {
      log(e.toString());
      log(s.toString());
      onError("Sorry! something went wrong");
    }
  }

  static Future<void> getOrderHistory({
    required Function(List<ProductHistory> orderHistory) onSuccess,
    required Function(String message) onError,
  }) async {
    try {
      var token = StorageHelper.getUser()!.token;

      var headers = {
        "Accept": "application/json",
        "Authorization": "Bearer ${token.toString()}",
      };

      http.Response response = await http.get(
        Uri.parse(Api.orders),
        headers: headers,
      );
      dynamic data = json.decode(response.body);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        List<ProductHistory> orderHistory =
            productHistoryFromJson(data["data"]);
        onSuccess(orderHistory);
      } else {
        onError(data['message']);
      }
    } catch (e) {
      log(e.toString());
      onError("Sorry! something went wrong");
    }
  }
}
