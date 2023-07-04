import "package:calculator/colors.dart";
import "package:flutter/material.dart";
import "package:math_expressions/math_expressions.dart";

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: CalculatorApp(),
  ));
}

class CalculatorApp extends StatefulWidget {
  const CalculatorApp({super.key});

  @override
  State<CalculatorApp> createState() => _CalculatorAppState();
}

class _CalculatorAppState extends State<CalculatorApp> {
  // variables
  double fisrtnum = 0.0;
  double secondnum = 0.0;
  var input = " ";
  var output = " ";
  var operation = " ";

  // var hideInput = false;
  var hideOutput = false;

  var outputSize = 50.0;

  onButtonClick(value) {
    // if AC button is pressed

    if (value == "AC") {
      input = " ";
      output = " ";
    } else if (value == "DEL") {
      if (input.isNotEmpty) {
        input = input.substring(
            0,
            input.length -
                1); // similar to .pop() operation, removes the last charecter from string i.e we're reassigning the input to input without the last charecter
      }
    } else if (value == "%") {
      input = (double.parse(input) / 100).toString();
    } else if (value == "=") {
      if (input.isNotEmpty) {
        var userInput = input;
        userInput = input
            .replaceAll("×", "*")
            .replaceAll("–", "-")
            .replaceAll("÷", "/");

        Parser p = Parser();
        // ignore: unused_local_variable
        Expression expression = p.parse(userInput);
        ContextModel cm = ContextModel();
        var finalValue = expression.evaluate(EvaluationType.REAL, cm);
        output = finalValue.toString();
        if (output.endsWith(".0")) {
          output = output.substring(0, output.length - 2);
        }
        // input = output;
        
        // hideInput = true;
        // outputSize = 48;
      }
    } else {
      input = input + value;
      // hideInput = false;
      // outputSize = 34;
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          // ipop area
          Expanded(
            child: Container(
                width: double.infinity,
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
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        hideOutput ? " " : output,
                        style: TextStyle(
                          fontSize: outputSize,
                          color: Colors.white.withOpacity(0.7),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 100,
                      )
                    ])),
          ),

          // buttons
          Row(
            children: [
              button(text: "AC", buttonBG: operatorColor, tColor: orangeColor),
              button(text: "DEL", buttonBG: operatorColor),
              button(text: "+/–", buttonBG: operatorColor),
              button(text: "÷", buttonBG: operatorColor)
            ],
          ),

          Row(
            children: [
              button(text: "7"),
              button(text: "8"),
              button(text: "9"),
              button(text: "×", buttonBG: operatorColor)
            ],
          ),

          Row(
            children: [
              button(text: "4"),
              button(text: "5"),
              button(text: "6"),
              button(text: "–", buttonBG: operatorColor)
            ],
          ),

          Row(
            children: [
              button(text: "1"),
              button(text: "2"),
              button(text: "3"),
              button(text: "+", buttonBG: operatorColor)
            ],
          ),

          Row(
            children: [
              button(text: "%"),
              button(text: "0"),
              button(text: "."),
              button(text: "=", buttonBG: orangeColor)
            ],
          ),
        ],
      ),
    );
  }

  Widget button({text, tColor = Colors.white, buttonBG = buttonColor}) {
    return Expanded(
        child: Container(
      margin: EdgeInsets.all(8),
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              padding: EdgeInsets.all(22),
              backgroundColor: buttonBG),
          onPressed: () => onButtonClick(text),
          child: Text(text,
              style: TextStyle(
                fontSize: 18,
                color: tColor,
                fontWeight: FontWeight.bold,
              ))),
    ));
  }
}
