import 'package:flutter/material.dart';
import 'dart:async'; // Importado para usar temporizador
import 'dart:math';

class Jogo extends StatefulWidget {
  @override
  _JogoState createState() => _JogoState();
}

class _JogoState extends State<Jogo> {
  var _imagemApp = AssetImage('assets/imagens/padrao.png');
  var _mensagem = 'Escolha uma opção abaixo!';
  int _pontosUsuario = 0;
  int _pontosApp = 0;
  bool _aguardandoResultado = false; // Para controle do temporizador

  final Map<String, AssetImage> _opcoesImagens = {
    'pedra': AssetImage('assets/imagens/pedra.png'),
    'papel': AssetImage('assets/imagens/papel.png'),
    'tesoura': AssetImage('assets/imagens/tesoura.png'),
  };

  void _opcaoSelecionada(String escolhaUsuario) {
    if (_aguardandoResultado) return; // Impede novas jogadas enquanto espera o resultado

    setState(() {
      _mensagem = "Aguardando resultado...";
      _aguardandoResultado = true;
    });

    final opcoes = ['pedra', 'papel', 'tesoura'];
    var numero = Random().nextInt(3); // Gerando número aleatório entre 0 e 2
    var escolhaApp = opcoes[numero];

    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        _imagemApp = _opcoesImagens[escolhaApp]!;

        if (escolhaUsuario == escolhaApp) {
          _mensagem = 'Empate!';
        } else if (
          (escolhaUsuario == 'papel' && escolhaApp == 'pedra') ||
          (escolhaUsuario == 'tesoura' && escolhaApp == 'papel') ||
          (escolhaUsuario == 'pedra' && escolhaApp == 'tesoura')
        ) {
          _mensagem = 'Você ganhou!';
          _pontosUsuario++;
        } else {
          _mensagem = 'Você perdeu!';
          _pontosApp++;
        }

        _aguardandoResultado = false; // Permite uma nova jogada
      });
    });
  }

  void _resetarJogo() {
    setState(() {
      _imagemApp = AssetImage('assets/imagens/padrao.png');
      _mensagem = 'Escolha uma opção abaixo!';
      _pontosUsuario = 0;
      _pontosApp = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Jokenpo'),
        backgroundColor: Colors.blueGrey[900], // Cor mais elegante para o AppBar
        elevation: 0,
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 5,
                blurRadius: 15,
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "Escolha do App",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w600,
                  color: Colors.blueGrey[700], // Cor suave para o título
                ),
              ),
              SizedBox(height: 20),
              Image(image: _imagemApp, height: 150),
              SizedBox(height: 20),
              Text(
                _mensagem,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueGrey[800], // Harmonização do texto
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Placar: Usuário $_pontosUsuario x $_pontosApp App',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.blueGrey[600], // Texto do placar
                ),
              ),
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  GestureDetector(
                    onTap: () => _opcaoSelecionada('pedra'),
                    child: Image.asset('assets/imagens/pedra.png', height: 100),
                  ),
                  GestureDetector(
                    onTap: () => _opcaoSelecionada('papel'),
                    child: Image.asset('assets/imagens/papel.png', height: 100),
                  ),
                  GestureDetector(
                    onTap: () => _opcaoSelecionada('tesoura'),
                    child: Image.asset('assets/imagens/tesoura.png', height: 100),
                  ),
                ],
              ),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: _resetarJogo,
                child: Text(
                  'Reiniciar Jogo',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 1,
                    color: Colors.white, // Cor do texto
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal[400], // Correção aqui
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  elevation: 5,
                  shadowColor: Colors.teal[100],
                ),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.blueGrey[50],
    );
  }
}
