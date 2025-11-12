import 'package:dio/dio.dart';
import '../model/filme.dart';

class FilmesApi {
  final Dio dio = Dio(
    BaseOptions(
      baseUrl: 'https://690ca78aa6d92d83e84ebd32.mockapi.io/filmes/filmes',
      connectTimeout: Duration(seconds: 10),
      receiveTimeout: Duration(seconds: 10),
      headers: {'Content-Type': 'application/json'},
    ),
  );

  Future<List<Filme>> getFilmes() async {
    try {
      final response = await dio.get('/');
      final List data = response.data;
      return data.map((json) => Filme.fromJson(json)).toList();
    } on DioException catch (e) {
      throw Exception('Erro ao carregar filmes: ${e.message}');
    }
  }

  Future<Filme> getFilmeById(String id) async {
    try {
      final response = await dio.get('/$id');
      return Filme.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception('Erro ao buscar filme ($id): ${e.message}');
    }
  }

  Future<bool> criarFilme(Filme filme) async {
    try {
      final response = await dio.post('/', data: filme.toJson());
      return response.statusCode == 201;
    } on DioException catch (e) {
      throw Exception('Erro ao criar filme: ${e.message}');
    }
  }

  Future<bool> atualizarFilme(Filme filme) async {
    if (filme.id == null) return false;
    try {
      final response = await dio.put('/${filme.id}', data: filme.toJson());
      return response.statusCode == 200;
    } on DioException catch (e) {
      throw Exception('Erro ao atualizar filme (${filme.id}): ${e.message}');
    }
  }

  Future<bool> removerFilme(String id) async {
    try {
      final response = await dio.delete('/$id');
      return response.statusCode == 200;
    } on DioException catch (e) {
      throw Exception('Erro ao remover filme ($id): ${e.message}');
    }
  }
}
