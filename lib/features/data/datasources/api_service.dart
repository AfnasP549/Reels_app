import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:reels_app/features/data/models/reel_model.dart';


abstract class ApiService {
  Future<List<ReelModel>> fetchReels(int page, int limit);
}

class RemoteDataSourceImpl implements ApiService {
  final http.Client client;

  RemoteDataSourceImpl({required this.client});

  @override
  Future<List<ReelModel>> fetchReels(int page, int limit) async {
    final response = await client.get(
      Uri.parse('https://backend-cj4o057m.fctl.app/bytes/scroll?page=$page&limit=$limit'),
    );

    if (response.statusCode == 200) {
      print('Raw JSON: ${response.body}');
      final jsonData = jsonDecode(response.body);
      final List<dynamic> data = jsonData['data']['data'];
      return data.map((json) => ReelModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load reels ');
    }
  }
}