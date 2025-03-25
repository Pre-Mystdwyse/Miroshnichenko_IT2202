import 'package:flutter/material.dart';

class InfinityMathList extends StatelessWidget {
  const InfinityMathList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        // Используем BigInt для корректных вычислений больших чисел
        final exponent = index;
        final result = BigInt.from(2).pow(exponent).toString();
        
        return Container(
          color: Colors.white,
          margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
          child: ListTile(
            title: Text(
              '2^$exponent = $result',
              style: const TextStyle(fontFamily: 'Monospace'),
            ),
          ),
        );
      },
    );
  }
}