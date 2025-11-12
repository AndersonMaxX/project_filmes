import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:project_filmes/model/filme.dart';

class DetalhesFilmeScreen extends StatelessWidget {
  final Filme filme;

  const DetalhesFilmeScreen({super.key, required this.filme});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detalhes do Filme"),
        foregroundColor: Colors.white,
        backgroundColor: Colors.blue,
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
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  filme.imagem,
                  height: 230,
                  fit: BoxFit.contain,
                  errorBuilder: (_, __, ___) =>
                  const Icon(Icons.broken_image, size: 100),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    filme.titulo,
                    style: const TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text(
                  filme.ano,
                  style: const TextStyle(color: Colors.grey, fontSize: 14),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  filme.genero,
                  style: const TextStyle(color: Colors.grey),
                ),
                Text(
                  filme.faixaEtaria,
                  style: const TextStyle(color: Colors.grey),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    filme.duracao,
                    style: const TextStyle(color: Colors.grey),
                  ),
                  RatingBarIndicator(
                    rating: filme.pontuacao,
                    itemCount: 5,
                    itemSize: 24,
                    itemBuilder: (_, __) =>
                    const Icon(Icons.star, color: Colors.amber),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 6),
            Text(
              filme.descricao,
              textAlign: TextAlign.justify,
              style: const TextStyle(fontSize: 15),
            ),
          ],
        ),
      ),
    );
  }
}
