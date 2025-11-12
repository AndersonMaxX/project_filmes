import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:project_filmes/controllers/filme_controller.dart';
import 'package:project_filmes/model/filme.dart';

class CadastrarFilmeScreen extends StatefulWidget {
  const CadastrarFilmeScreen({super.key});

  @override
  State<CadastrarFilmeScreen> createState() => _CadastrarFilmeScreenState();
}

class _CadastrarFilmeScreenState extends State<CadastrarFilmeScreen> {
  final FilmeController _controller = FilmeController();

  final TextEditingController _imagem = TextEditingController();
  final TextEditingController _titulo = TextEditingController();
  final TextEditingController _genero = TextEditingController();
  final TextEditingController _duracao = TextEditingController();
  final TextEditingController _descricao = TextEditingController();
  final TextEditingController _ano = TextEditingController();

  String _faixaEtaria = "Livre";
  double _pontuacao = 0.0;

  Map<String, String> erros = {};

  Future<void> _confirmarSalvar() async {
    final bool? confirmar = await showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Confirmar"),
        content: const Text("Deseja salvar este filme?"),
        actions: [
          TextButton(
            child: const Text("Cancelar"),
            onPressed: () => Navigator.pop(context, false),
          ),
          TextButton(
            child: const Text("Salvar"),
            onPressed: () => Navigator.pop(context, true),
          ),
        ],
      ),
    );

    if (confirmar == true) {
      _salvarFilme();
    }
  }

  Future<void> _salvarFilme() async {
    Filme filme = Filme(
      imagem: _imagem.text,
      titulo: _titulo.text,
      genero: _genero.text,
      faixaEtaria: _faixaEtaria,
      duracao: _duracao.text,
      pontuacao: _pontuacao,
      descricao: _descricao.text,
      ano: _ano.text,
    );

    var resultado = await _controller.salvar(filme);

    if (resultado is Map<String, String>) {
      setState(() => erros = resultado);
    } else if (resultado is String) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(resultado)),
        );
        Navigator.pop(context, true);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cadastrar Filme"),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _campo("URL da imagem", _imagem, erros["imagem"]),
            _campo("Título", _titulo, erros["titulo"]),
            _campo("Gênero", _genero, erros["genero"]),
            _dropdownFaixaEtaria(),
            _campo("Duração", _duracao, erros["duracao"]),
            _ratingBar(),
            _campoNumero("Ano", _ano, erros["ano"]),
            _campoDescricao(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final errosTemp = _controller.validarCampos(
            Filme(
              imagem: _imagem.text,
              titulo: _titulo.text,
              genero: _genero.text,
              faixaEtaria: _faixaEtaria,
              duracao: _duracao.text,
              pontuacao: _pontuacao,
              descricao: _descricao.text,
              ano: _ano.text,
            ),
          );

          if (errosTemp.isNotEmpty) {
            setState(() => erros = errosTemp);
            return;
          }

          _confirmarSalvar();
        },
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        shape: const CircleBorder(),
        child: const Icon(Icons.save),
      ),
    );
  }

  Widget _campo(String label, TextEditingController controller, String? erro) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(labelText: label, errorText: erro),
      ),
    );
  }

  Widget _campoNumero(String label, TextEditingController controller, String? erro) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(labelText: label, errorText: erro),
      ),
    );
  }

  Widget _campoDescricao() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: TextField(
        controller: _descricao,
        maxLines: 4,
        decoration: InputDecoration(labelText: "Descrição", errorText: erros["descricao"]),
      ),
    );
  }

  Widget _dropdownFaixaEtaria() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          const Text("Faixa Etária: "),
          const SizedBox(width: 20),
          SizedBox(
            width: 120,
            child: DropdownButtonFormField<String>(
              value: _faixaEtaria,
              items: const [
                DropdownMenuItem(value: "Livre", child: Text("Livre")),
                DropdownMenuItem(value: "10", child: Text("10")),
                DropdownMenuItem(value: "12", child: Text("12")),
                DropdownMenuItem(value: "14", child: Text("14")),
                DropdownMenuItem(value: "16", child: Text("16")),
                DropdownMenuItem(value: "18", child: Text("18")),
              ],
              onChanged: (valor) => setState(() => _faixaEtaria = valor!),
            ),
          ),
        ],
      ),
    );
  }

  Widget _ratingBar() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          const Text("Nota: "),
          RatingBar.builder(
            initialRating: _pontuacao,
            minRating: 0,
            maxRating: 5,
            allowHalfRating: true,
            itemCount: 5,
            itemSize: 30,
            itemBuilder: (_, __) => const Icon(Icons.star, color: Colors.amber),
            onRatingUpdate: (valor) => setState(() => _pontuacao = valor),
          ),
          if (erros["pontuacao"] != null)
            Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Text(erros["pontuacao"]!, style: const TextStyle(color: Colors.red)),
            ),
        ],
      ),
    );
  }
}
