import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:project_filmes/controllers/filme_controller.dart';
import 'package:project_filmes/model/filme.dart';
import 'detalhes_filme.dart';
import 'cadastrar_filme.dart';
import 'editar_filme.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FilmeController _controller = FilmeController();
  List<Filme> _filmes = [];
  bool _carregando = true;

  @override
  void initState() {
    super.initState();
    _carregarFilmes();
  }

  Future<void> _carregarFilmes() async {
    List<Filme> lista = await _controller.listarFilmes();
    setState(() {
      _filmes = lista;
      _carregando = false;
    });
  }

  Future<bool?> _confirmarExclusao(Filme filme) {
    return showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Excluir Filme"),
        content: Text("Tem certeza que deseja excluir '${filme.titulo}'?"),
        actions: [
          TextButton(
            child: const Text("Cancelar"),
            onPressed: () => Navigator.pop(context, false),
          ),
          TextButton(
            child: const Text("Excluir"),
            onPressed: () => Navigator.pop(context, true),
          ),
        ],
      ),
    );
  }

  void _abrirCadastro() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const CadastrarFilmeScreen()),
    ).then((_) => _carregarFilmes());
  }

  void _mostrarInfoGrupo() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Grupo"),
        content: const Text("Anderson Max"),
        actions: [
          TextButton(
            style: TextButton.styleFrom(foregroundColor: Colors.blue),
            child: const Text("Ok"),
            onPressed: () => Navigator.pop(context),
          )
        ],
      ),
    );
  }

  void _mostrarOpcoes(BuildContext context, Filme filme) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: const Center(child: Text("Exibir Dados")),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => DetalhesFilmeScreen(filme: filme)),
                );
              },
            ),
            const Divider(height: 0),
            ListTile(
              title: const Center(child: Text("Alterar")),
              onTap: () async {
                Navigator.pop(context);
                var result = await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => EditarFilmeScreen(filme: filme)),
                );
                if (result == true) {
                  _carregarFilmes();
                }
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        title: const Text("Filmes"),
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: _mostrarInfoGrupo,
          )
        ],
      ),
      body: _carregando
          ? const Center(child: CircularProgressIndicator())
          : _filmes.isEmpty
          ? _telaVazia()
          : ListView.builder(
        itemCount: _filmes.length,
        itemBuilder: (_, index) {
          final filme = _filmes[index];
          return Dismissible(
            key: ValueKey(filme.id.toString()),
            direction: DismissDirection.endToStart,
            background: Container(
              color: Colors.red,
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: const Icon(Icons.delete, color: Colors.white, size: 32),
            ),
            confirmDismiss: (_) => _confirmarExclusao(filme),
            onDismissed: (_) async {
              String msg = await _controller.removerFilme(filme.id!.toString());
              if (mounted) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
              }
              _carregarFilmes();
            },
            child: _cardFilme(filme),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _abrirCadastro,
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        shape: const CircleBorder(),
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _telaVazia() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.movie_filter, size: 80, color: Colors.grey),
          SizedBox(height: 16),
          Text("Nenhum filme cadastrado ainda", style: TextStyle(fontSize: 18, color: Colors.grey)),
        ],
      ),
    );
  }

  Widget _cardFilme(Filme filme) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: InkWell(
        onTap: () => _mostrarOpcoes(context, filme),
        child: Row(
          children: [
            Image.network(
              filme.imagem,
              height: 120,
              width: 90,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => const Icon(Icons.broken_image, size: 80),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(filme.titulo, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 5),
                    Text(filme.genero),
                    const SizedBox(height: 5),
                    Text(filme.duracao),
                    const SizedBox(height: 18),
                    RatingBarIndicator(
                      rating: filme.pontuacao,
                      itemCount: 5,
                      itemSize: 22,
                      itemBuilder: (_, __) => const Icon(Icons.star, color: Colors.amber),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
