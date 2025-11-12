import 'package:project_filmes/model/filme.dart';
import 'package:project_filmes/services/filmes_api.dart';

class FilmeController {
  final FilmesApi _api = FilmesApi();

  Map<String, String> validarCampos(Filme filme) {
    Map<String, String> erros = {};

    if (filme.imagem.isEmpty) erros["imagem"] = "A imagem é obrigatória";
    if (filme.titulo.isEmpty) erros["titulo"] = "O título é obrigatório";
    if (filme.genero.isEmpty) erros["genero"] = "O gênero é obrigatório";
    if (filme.faixaEtaria.isEmpty) erros["faixaEtaria"] = "A faixa etária é obrigatória";
    if (filme.duracao.isEmpty) erros["duracao"] = "A duração é obrigatória";
    if (filme.pontuacao == 0) erros["pontuacao"] = "A pontuação é obrigatória";
    if (filme.descricao.isEmpty) erros["descricao"] = "A descrição é obrigatória";
    if (filme.ano.isEmpty) erros["ano"] = "O ano é obrigatório";

    return erros;
  }

  Future<dynamic> salvar(Filme filme) async {
    final erros = validarCampos(filme);
    if (erros.isNotEmpty) return erros;

    bool ok = await _api.criarFilme(filme);
    return ok ? "Filme cadastrado com sucesso!" : "Erro ao cadastrar filme";
  }

  Future<dynamic> editar(String id, Filme filme) async {
    final erros = validarCampos(filme);
    if (erros.isNotEmpty) return erros;

    bool ok = await _api.atualizarFilme(filme);
    return ok ? "Filme atualizado com sucesso!" : "Erro ao atualizar filme";
  }

  Future<List<Filme>> listarFilmes() {
    return _api.getFilmes();
  }

  Future<Filme> buscarPorId(String id) {
    return _api.getFilmeById(id);
  }

  Future<String> deletar(String id) async {
    bool ok = await _api.removerFilme(id);
    return ok ? "Filme removido com sucesso!" : "Erro ao remover filme";
  }

  Future<String> removerFilme(String id) => deletar(id);
}
