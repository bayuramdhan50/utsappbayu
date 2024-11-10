import 'package:flutter/material.dart';
import 'dart:math';

class CalculatorScreen extends StatefulWidget {
  final Color color;

  CalculatorScreen({required this.color});

  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String output = "0";
  String _output = "0";
  double num1 = 0.0;
  double num2 = 0.0;
  String operand = "";
  bool isOperatorPressed = false;

  // List untuk menyimpan riwayat perhitungan
  List<String> history = [];

  buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == "CLEAR") {
        _output = "0";
        num1 = 0.0;
        num2 = 0.0;
        operand = "";
        isOperatorPressed = false;
        history.clear();
      } else if (buttonText == "⌫") {
        // Tombol backspace
        if (_output.length > 1) {
          _output = _output.substring(0, _output.length - 1);
        } else {
          _output = "0";
        }
      } else if (buttonText == "√") {
        // Tombol akar kuadrat
        double result = double.parse(_output);
        result = result >= 0
            ? sqrt(result)
            : double.nan; // Error untuk angka negatif
        history.insert(0, "√$_output = ${result.toString()}");
        _output = result.toString();
      } else if (buttonText == "x²") {
        // Tombol kuadrat
        double result = double.parse(_output);
        result *= result;
        history.insert(0, "$_output² = ${result.toString()}");
        _output = result.toString();
      } else if (buttonText == "+" ||
          buttonText == "-" ||
          buttonText == "*" ||
          buttonText == "/") {
        if (!isOperatorPressed) {
          num1 = double.parse(_output);
          operand = buttonText;
          isOperatorPressed = true;
        }
      } else if (buttonText == "=") {
        if (operand.isNotEmpty) {
          num2 = double.parse(_output);
          switch (operand) {
            case "+":
              _output = (num1 + num2).toString();
              break;
            case "-":
              _output = (num1 - num2).toString();
              break;
            case "*":
              _output = (num1 * num2).toString();
              break;
            case "/":
              _output = (num2 != 0) ? (num1 / num2).toString() : "Error";
              break;
          }
          history.insert(0, "$num1 $operand $num2 = $_output");
          num1 = 0.0;
          num2 = 0.0;
          operand = "";
          isOperatorPressed = false;
        }
      } else {
        if (_output == "0" || isOperatorPressed) {
          _output = buttonText;
          isOperatorPressed = false;
        } else {
          _output += buttonText;
        }
      }
      output = _output;
    });
  }

  Widget buildButton(String buttonText, Color color) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        shape: CircleBorder(),
        padding: EdgeInsets.all(20),
      ),
      onPressed: () => buttonPressed(buttonText),
      child: Text(
        buttonText,
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("KalkulatorBay"),
        centerTitle: true,
        backgroundColor: widget.color,
      ),
      body: Stack(
        children: [
          Container(
            color: widget.color,
          ),
          Container(
            margin: EdgeInsets.only(top: 10),
            decoration: BoxDecoration(
              color: Colors.grey[900],
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              children: <Widget>[
                // Area tampilan output hasil perhitungan
                Container(
                  alignment: Alignment.centerRight,
                  padding: EdgeInsets.symmetric(vertical: 24, horizontal: 12),
                  child: Text(
                    output,
                    style: TextStyle(fontSize: 48, color: Colors.white),
                  ),
                ),
                Expanded(
                  child: Divider(color: Colors.white),
                ),

                // Area riwayat perhitungan
                Expanded(
                  flex: 2,
                  child: Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.grey[850],
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(16)),
                    ),
                    child: ListView.builder(
                      itemCount: history.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Text(
                            history[index],
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                        );
                      },
                    ),
                  ),
                ),

                // Tombol perhitungan
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        buildButton("√", widget.color),
                        buildButton("x²", widget.color),
                        buildButton("⌫", Colors.grey[800]!),
                        buildButton("/", widget.color),
                      ],
                    ),
                    SizedBox(height: 8), // Menambahkan ruang antara baris
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        buildButton("7", Colors.grey[800]!),
                        buildButton("8", Colors.grey[800]!),
                        buildButton("9", Colors.grey[800]!),
                        buildButton("*", Colors.orange),
                      ],
                    ),
                    SizedBox(height: 8), // Menambahkan ruang antara baris
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        buildButton("4", Colors.grey[800]!),
                        buildButton("5", Colors.grey[800]!),
                        buildButton("6", Colors.grey[800]!),
                        buildButton("-", Colors.orange),
                      ],
                    ),
                    SizedBox(height: 8), // Menambahkan ruang antara baris
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        buildButton("1", Colors.grey[800]!),
                        buildButton("2", Colors.grey[800]!),
                        buildButton("3", Colors.grey[800]!),
                        buildButton("+", Colors.orange),
                      ],
                    ),
                    SizedBox(height: 8), // Menambahkan ruang antara baris
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        buildButton(".", Colors.grey[800]!),
                        buildButton("0", Colors.grey[800]!),
                        buildButton("C", Colors.red),
                        buildButton("=", Colors.green),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 16), // Ruang di bawah tombol
              ],
            ),
          ),
        ],
      ),
    );
  }
}
