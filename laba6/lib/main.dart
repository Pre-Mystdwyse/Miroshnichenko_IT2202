import 'package:flutter/material.dart';

class MyForm extends StatefulWidget {
  const MyForm({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => MyFormState();
}

class MyFormState extends State<MyForm> {
  final _formKey = GlobalKey<FormState>();
  double? _savedWidth;
  double? _savedHeight;
  double? _areaResult;
  double? _perimeterResult;
  final TextEditingController _widthController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();

  final Color mainColor = Colors.purple;
  final Color lightPurple = Color.fromARGB(255, 237, 231, 246);
  final Color darkPurple = Color.fromARGB(255, 74, 20, 140);
  final Color appBarColor = Color.fromARGB(255, 106, 27, 154);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [lightPurple, const Color.fromARGB(255, 222, 195, 240)],
        ),
      ),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            _buildInputField('Ширина:', 'Введите ширину', _widthController),
            const SizedBox(height: 25.0),
            _buildInputField('Высота:', 'Введите высоту', _heightController),
            const SizedBox(height: 35.0),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: mainColor,
                padding: EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: _calculateResults,
              child: const Text(
                'Вычислить',
                style: TextStyle(fontSize: 18, color: Color.fromARGB(255, 255, 255, 255)),
              ),
            ),
            const SizedBox(height: 25.0),
            if (_areaResult != null || _perimeterResult != null) _buildResults(),
          ],
        ),
      ),
    );
  }

  Widget _buildInputField(String label, String hint, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
              fontSize: 18, color: darkPurple, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            hintText: hint,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: mainColor),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: mainColor, width: 2),
            ),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) return 'Поле не может быть пустым';
            if (double.tryParse(value) == null) return 'Введите число';
            return null;
          },
          onSaved: (value) => label.startsWith('Шир')
              ? _savedWidth = double.parse(value!)
              : _savedHeight = double.parse(value!),
        ),
      ],
    );
  }

  Widget _buildResults() {
    return Column(
      children: [
        _buildResultItem(
          'S = ${_savedWidth?.toStringAsFixed(2)} * ${_savedHeight?.toStringAsFixed(2)} = ${_areaResult?.toStringAsFixed(2)}',
        ),
        const SizedBox(height: 15),
        _buildResultItem(
          'P = (${_savedWidth?.toStringAsFixed(2)} + ${_savedHeight?.toStringAsFixed(2)}) * 2 = ${_perimeterResult?.toStringAsFixed(2)}',
        ),
      ],
    );
  }

  Widget _buildResultItem(String text) {
    return Container(
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 250, 224, 255),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 18,
          color: darkPurple,
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  void _calculateResults() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      setState(() {
        _areaResult = _savedWidth! * _savedHeight!;
        _perimeterResult = (_savedWidth! + _savedHeight!) * 2;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Вычисления выполнены успешно!'),
          backgroundColor: mainColor,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10)),
        ),
      );
      
      _widthController.clear();
      _heightController.clear();
    }
  }
}

void main() => runApp(
      MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: AppBar(
            title: const Text('Калькулятор прямоугольника'),
          ),
          body: const MyForm(),
        ),
      ),
    );