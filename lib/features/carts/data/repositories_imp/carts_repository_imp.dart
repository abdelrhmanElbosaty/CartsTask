import 'dart:convert';

import 'package:carts_task/features/carts/data/mappers/api_carts_map.dart';
import 'package:carts_task/features/carts/data/models/api_carts_result.dart';
import 'package:carts_task/features/carts/domain/entities/cart_entity.dart';
import 'package:carts_task/features/carts/domain/repositories/carts_repository.dart';
import 'package:carts_task/features/core/constants.dart';
import 'package:carts_task/features/core/exceptions.dart';
import 'package:dio/dio.dart';

class CartsRepositoryImpl implements CartsRepository {
  @override
  Future<List<Cart>> getCarts(int limit) async {
    String apiUrl = '${Constants.baseUrl}?limit=$limit';
    final response = await Dio().get(apiUrl, options: Options());

    if (response.statusCode == 200) {
      final result = ApiCartsResult.fromJson(response.data).carts;

      final List<Cart> carts = result?.map((e) => e.mapCart).toList() ?? [];
      return carts;
    } else {
      throw ApiRequestException(
          response.statusCode ?? 400, 'Failed to load carts');
    }
  }
}
