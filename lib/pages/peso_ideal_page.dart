import 'package:flutter/material.dart';

class PesoIdealPage extends StatefulWidget {
  const PesoIdealPage({super.key});

  @override
  State<PesoIdealPage> createState() => _PesoIdealPageState();
}

class _PesoIdealPageState extends State<PesoIdealPage> {
  String sexo = 'M';
  double pesoIdeal = 0;
  String resultPesoIdeal = '';
  String resultClassificacao = '';
  double imc = 0;

  TextEditingController alturaController = TextEditingController();
  TextEditingController pesoController = TextEditingController();

  calcular() {
    double altura = double.parse(alturaController.text);
    double peso = double.parse(pesoController.text);
    if (sexo == 'M') {
      pesoIdeal = (72.7 * altura) - 58;
    } else if (sexo == 'F') {
      pesoIdeal = (62.1 * altura) - 44;
    }

    imc = peso / (altura * altura);

    if (imc < 18.5) {
      resultClassificacao = 'Abaixo do peso';
    } else if (imc < 25) {
      resultClassificacao = 'Normal';
    } else if (imc < 30) {
      resultClassificacao = 'Sobrepeso';
    } else if (imc < 35) {
      resultClassificacao = 'Obesidade grau I';
    } else if (imc < 40) {
      resultClassificacao = 'Obesidade grau II';
    } else {
      resultClassificacao = 'Obesidade grau III';
    }

    setState(() {
      resultPesoIdeal = pesoIdeal.toStringAsFixed(2);
      resultClassificacao;
      imc;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Peso Ideal e IMC',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.amber,
      ),
      body: Center(
        child: ConstrainedBox(
          constraints:
              const BoxConstraints(maxWidth: 300), // Largura máxima de 300
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextField(
                  controller: alturaController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    labelText: 'Altura (m)',
                    labelStyle: const TextStyle(fontSize: 18),
                    prefixIcon:
                        const Icon(Icons.height), // Ícone de altura à esquerda
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: pesoController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    labelText: 'Peso (kg)',
                    labelStyle: const TextStyle(fontSize: 18),
                    prefixIcon:
                        const Icon(Icons.fitness_center), // Ícone à esquerda
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Radio(
                        value: 'M',
                        groupValue: sexo,
                        onChanged: (String? value) {
                          setState(() {
                            sexo = value!;
                          });
                        }),
                    const Text('Masculino'),
                    const SizedBox(width: 16),
                    Radio(
                        value: 'F',
                        groupValue: sexo,
                        onChanged: (String? value) {
                          setState(() {
                            sexo = value!;
                          });
                        }),
                    const Text('Feminino'),
                  ],
                ),
                const SizedBox(height: 32),
                ElevatedButton(
                  onPressed: calcular,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    'Calcular IMC',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                const SizedBox(height: 32),
                resultPesoIdeal == ''
                    ? const Text('')
                    : Text(
                        'Seu peso ideal é: $resultPesoIdeal',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                        textAlign: TextAlign.center,
                      ),
                imc == 0
                    ? const Text('')
                    : Text(
                        'Seu IMC é: ${imc.toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                        textAlign: TextAlign.center,
                      ),
                resultClassificacao == ''
                    ? const Text('')
                    : Text(
                        'Você está: $resultClassificacao',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Colors.brown,
                        ),
                        textAlign: TextAlign.center,
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
