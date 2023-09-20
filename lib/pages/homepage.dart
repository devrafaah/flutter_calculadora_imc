import 'dart:ffi';

import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var myStats = 'Informe o seus dados';
  Color colora = Colors.black;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();

  void _resetFields() {
    nameController.text = '';
    weightController.text = '';
    heightController.text = '';
    setState(() {
      myStats = 'Informe o seus dados';
      colora = Colors.black;
      _formKey = GlobalKey<FormState>();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black87,
        appBar: AppBar(
          toolbarHeight: 75,
          backgroundColor: Colors.black,
          centerTitle: true,
          title: const Text(
            'Calculadora de IMC',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w500,
              letterSpacing: 1,
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 17),
              child: IconButton(
                onPressed: _resetFields,
                icon: const Icon(
                  Icons.restart_alt,
                  size: 30,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
        body: Container(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Icon(
                        Icons.person,
                        color: Colors.white,
                        size: 200,
                      ),
                      TextFormField(
                        controller: weightController,
                        keyboardType: TextInputType.number,
                        style: const TextStyle(color: Colors.white),
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: BorderSide(width: 2),
                          ),
                          suffix: Text(
                            'kg',
                            style: TextStyle(color: Colors.white),
                          ),
                          label: Text(
                            'Digite seu Peso',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Insira o seu Peso';
                          }
                        },
                      ),
                      const SizedBox(
                        height: 17,
                      ),
                      TextFormField(
                        controller: heightController,
                        keyboardType: TextInputType.number,
                        style: const TextStyle(color: Colors.white),
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: BorderSide(width: 2),
                          ),
                          suffix: Text(
                            'cm',
                            style: TextStyle(color: Colors.white),
                          ),
                          label: Text(
                            'Digite sua Altura',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Insira o sua Altura';
                          }
                        },
                      ),
                      const SizedBox(
                        height: 17,
                      ),
                      OutlinedButton(
                        style: const ButtonStyle(
                          padding: MaterialStatePropertyAll(
                            EdgeInsets.all(12),
                          ),
                          side: MaterialStatePropertyAll(
                            BorderSide(
                              style: BorderStyle.solid,
                              color: Color.fromARGB(95, 41, 58, 134),
                            ),
                          ),
                          shape: MaterialStatePropertyAll(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.zero),
                            ),
                          ),
                          backgroundColor: MaterialStatePropertyAll(
                            Color.fromARGB(95, 41, 58, 134),
                          ),
                        ),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _salvar();
                          }
                        },
                        child: const Text(
                          'Calcular IMC',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 1,
                  height: 100,
                  child: Container(
                    width: double.infinity,
                    height: 100,
                    decoration: BoxDecoration(
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                          offset: Offset(2, 2),
                          blurRadius: 3,
                          color: colora,
                        )
                      ],
                      color: colora,
                      borderRadius: const BorderRadius.all(
                        Radius.circular(12),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        myStats,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          shadows: <Shadow>[
                            Shadow(
                              offset: Offset(2, 2),
                              blurRadius: 3,
                              color: Colors.white,
                            )
                          ],
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _salvar() {
    setState(() {
      double weight = double.parse(weightController.text);
      double height = double.parse(heightController.text);

      double imc = (weight / (height / 100 * height / 100));

      if (imc < 18.6) {
        colora = const Color.fromARGB(197, 100, 157, 184);
        var sit = 'Abaixo do Peso';
        myStats = '$sit IMC: ${imc.toStringAsFixed(2)}';
      } else if (imc >= 18.6 && imc < 29.9) {
        colora = const Color.fromARGB(197, 100, 157, 184);
        var sit = 'Peso Ideal';
        myStats = '$sit IMC: ${imc.toStringAsFixed(2)}';
      } else if (imc >= 24.9 && imc < 29.9) {
        colora = const Color.fromARGB(197, 123, 16, 0);
        var sit = 'Peso Ideal';
        myStats = '$sit IMC: ${imc.toStringAsFixed(2)}';
      } else if (imc >= 29.9 && imc < 34.9) {
        colora = const Color.fromARGB(197, 155, 26, 0);
        var sit = 'Obesidade Grau I';
        myStats = '$sit IMC: ${imc.toStringAsFixed(2)}';
      } else if (imc >= 34.9 && imc < 39.9) {
        colora = const Color.fromARGB(197, 200, 0, 0);
        var sit = 'Obesidade Grau II';
        myStats = '$sit IMC: ${imc.toStringAsFixed(2)}';
      } else if (imc >= 40) {
        colora = const Color.fromARGB(197, 255, 0, 0);
        var sit = 'Obesidade Grau III';
        myStats = '$sit IMC: ${imc.toStringAsFixed(2)}';
      }
    });
  }
}
