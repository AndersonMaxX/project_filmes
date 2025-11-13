=======
# 🎬 Catálogo de Filmes — Flutter + API (MockAPI)
>>>>>>> 9d15993e03b1493c33d972900b7d828c07b35739

Aplicativo desenvolvido em **Flutter** com integração a uma **API REST (MockAPI)** para gerenciamento de um catálogo de filmes.  
Permite **cadastrar, editar, listar, visualizar e excluir filmes** de forma dinâmica e conectada à nuvem.

---

## 🚀 Funcionalidades

✅ **Listar filmes** — Exibe todos os filmes vindos da API  
✅ **Cadastrar filme** — Permite adicionar novos filmes com validação  
✅ **Editar filme** — Atualiza os dados de um filme existente  
✅ **Ver detalhes** — Mostra informações completas sobre um filme  
✅ **Excluir filme** — Remove um filme da API com confirmação  
✅ **Validação de campos** — Impede salvar filmes com campos vazios  

---

## 🧩 Estrutura do Projeto
```bash
lib/
│
├── controllers/
│ └── filme_controller.dart → Lógica de negócio e validação
│
├── model/
│ └── filme.dart → Estrutura de dados do filme
│
├── services/
│ └── filmes_api.dart → Comunicação com a API via Dio
│
├── views/
│ ├── home_screen.dart → Tela inicial (lista de filmes)
│ ├── cadastrar_filme.dart → Tela de cadastro
│ ├── editar_filme.dart → Tela de edição
│ └── detalhes_filme.dart → Tela de detalhes do filme
│
└── main.dart → Ponto de entrada do app
```
---

## 🧠 Arquitetura MVC

| Camada | Função |
|--------|--------|
| **Model** | Define a estrutura dos dados (`Filme`) |
| **Controller** | Faz a validação e controla as ações (`FilmeController`) |
| **View** | Telas do aplicativo (`views/`) |
| **Service** | Comunicação com a API (`FilmesApi`) |

Essa separação facilita manutenção, testes e entendimento do fluxo do app.

---

## ⚙️ Tecnologias Utilizadas

| Tecnologia | Função |
|-------------|--------|
| **Flutter** | Framework principal para o app |
| **Dart** | Linguagem de programação |
| **Dio** | Biblioteca para requisições HTTP |
| **Flutter Rating Bar** | Exibição das estrelas de avaliação |
| **MockAPI.io** | API REST gratuita usada como backend |

---

## 🌐 API — MockAPI.io

Base URL:
https://690ca78aa6d92d83e84ebd32.mockapi.io/filmes/filmes

| Método | Endpoint | Descrição |
|---------|-----------|-----------|
| `GET` | `/` | Lista todos os filmes |
| `GET` | `/{id}` | Busca um filme pelo ID |
| `POST` | `/` | Cadastra um novo filme |
| `PUT` | `/{id}` | Atualiza um filme existente |
| `DELETE` | `/{id}` | Remove um filme |

---


## 🧰 Como Executar o Projeto

### 1️⃣ Clone o repositório
```bash
git clone https://github.com/AndersonMaxX/project_filmes.git
```
### 2️⃣ Acesse a pasta do projeto
```bash
cd project_filmes
```
### 3️⃣ Instale as dependências
```bash
flutter pub get
```
### 4️⃣ Execute o aplicativo
```bash
flutter run
```

## 💡 Conceitos Aplicados

* Estrutura MVC

* Consumo de API REST com Dio

* Validação de formulários no Controller

* Uso de SnackBars e AlertDialogs para feedback ao usuário

* Tratamento de erros e verificação de conexão

* Comunicação entre telas com Navigator.push / Navigator.pop

* Exibição de imagens da web com Image.network

## 🎨 Layout e UX

O app segue o padrão Material Design, com:

* 🎨 Cores principais: Azul e Branco

* ⭐ Avaliação visual com estrelas: RatingBarIndicator

* 📱 Interface responsiva e com rolagem: SingleChildScrollView

* 🟢 Botões flutuantes arredondados (FAB) para ações principais

## 👨‍💻 Autor

Anderson Max
Curso: Análise e Desenvolvimento de Sistemas — UNIPÊ
João Pessoa - PB

GitHub: https://github.com/AndersonMaxX

LinkedIn: https://www.linkedin.com/in/andersonmax-frontend/

## 📝 Licença

Este projeto está licenciado sob a MIT License.
