import 'package:calculator/colors.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CalculatorApp(),
    ),
  );
}

class CalculatorApp extends StatefulWidget {
  const CalculatorApp({Key? key}) : super(key: key);

  @override
  State<CalculatorApp> createState() => _CalculatorAppState();
}

class _CalculatorAppState extends State<CalculatorApp> {
  // variables
  double fisrtnum = 0.0;
  double secondnum = 0.0;
  var input = '';
  var output = '';
  var operation = '';

  var hideOutput = false;
  var outputSize = 50.0;

  onButtonClick(value) {
    // if AC button is pressed
    if (value == 'AC') {
      input = '';
      output = '';
    } else if (value == 'DEL') {
      if (input.isNotEmpty) {
        input = input.substring(0, input.length - 1);
      }
    } else if (value == '%') {
      input = (double.parse(input) / 100).toString();
    } else if (value == '=') {
      if (input.isNotEmpty) {
        var userInput = input;
        userInput = input
            .replaceAll('×', '*')
            .replaceAll('–', '-')
            .replaceAll('÷', '/');

        Parser p = Parser();
        Expression expression = p.parse(userInput);
        ContextModel cm = ContextModel();
        var finalValue = expression.evaluate(EvaluationType.REAL, cm);
        output = finalValue.toString();
        if (output.endsWith('.0')) {
          output = output.substring(0, output.length - 2);
        }
      }
    } else {
      input = input + value;
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    final calculatorWidth = MediaQuery.of(context).size.width * 0.3;
    final buttonWidth = (calculatorWidth - 16 * 5) / 4;
    final buttonHeight = buttonWidth;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Container(
          height: screenHeight,
          width: calculatorWidth,
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Display area
              Container(
                width: calculatorWidth,
                padding: const EdgeInsets.all(12),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      input,
                      style: TextStyle(
                        fontSize: 60,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      hideOutput ? ' ' : output,
                      style: TextStyle(
                        fontSize: outputSize,
                        color: Colors.white.withOpacity(0.7),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 100),
                  ],
                ),
              ),

              // Buttons
              Column(
                children: [
                  Row(
                    children: [
                      button(
                        text: 'AC',
                        buttonBG: operatorColor,
                        width: buttonWidth,
                        height: buttonHeight,
                      ),
                      button(
                        text: 'DEL',
                        buttonBG: operatorColor,
                        width: buttonWidth,
                        height: buttonHeight,
                      ),
                      button(
                        text: '+/-',
                        buttonBG: operatorColor,
                        width: buttonWidth,
                        height: buttonHeight,
                      ),
                      button(
                        text: '÷',
                        buttonBG: operatorColor,
                        width: buttonWidth,
                        height: buttonHeight,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      button(
                        text: '7',
                        width: buttonWidth,
                        height: buttonHeight,
                      ),
                      button(
                        text: '8',
                        width: buttonWidth,
                        height: buttonHeight,
                      ),
                      button(
                        text: '9',
                        width: buttonWidth,
                        height: buttonHeight,
                      ),
                      button(
                        text: '×',
                        buttonBG: operatorColor,
                        width: buttonWidth,
                        height: buttonHeight,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      button(
                        text: '4',
                        width: buttonWidth,
                        height: buttonHeight,
                      ),
                      button(
                        text: '5',
                        width: buttonWidth,
                        height: buttonHeight,
                      ),
                      button(
                        text: '6',
                        width: buttonWidth,
                        height: buttonHeight,
                      ),
                      button(
                        text: '–',
                        buttonBG: operatorColor,
                        width: buttonWidth,
                        height: buttonHeight,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      button(
                        text: '1',
                        width: buttonWidth,
                        height: buttonHeight,
                      ),
                      button(
                        text: '2',
                        width: buttonWidth,
                        height: buttonHeight,
                      ),
                      button(
                        text: '3',
                        width: buttonWidth,
                        height: buttonHeight,
                      ),
                      button(
                        text: '+',
                        buttonBG: operatorColor,
                        width: buttonWidth,
                        height: buttonHeight,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      button(
                        text: '%',
                        width: buttonWidth,
                        height: buttonHeight,
                      ),
                      button(
                        text: '0',
                        width: buttonWidth,
                        height: buttonHeight,
                      ),
                      button(
                        text: '.',
                        width: buttonWidth,
                        height: buttonHeight,
                      ),
                      button(
                        text: '=',
                        buttonBG: orangeColor,
                        width: buttonWidth,
                        height: buttonHeight,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget button({
    required String text,
    Color buttonBG = buttonColor,
    required double width,
    required double height,
  }) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.all(8),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            padding: EdgeInsets.all(22),
            backgroundColor: buttonBG,
          ),
          onPressed: () => onButtonClick(text),
          child: Text(
            text,
            style: TextStyle(
              fontSize: 18,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
