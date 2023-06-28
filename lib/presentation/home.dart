import 'package:flutter/material.dart';

import '../domain/model/day.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _latController = TextEditingController();
  final _lngController = TextEditingController();

  late Day _day;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: FocusScope.of(context).unfocus,
      child: Scaffold(
        body: _getBody(),
      ),
    );
  }

  Widget _getBody() {
    return SafeArea(
        child: Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _getRowInput(),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: _getDay,
            child: const Text('Получить'),
          ),
          const SizedBox(height: 20),
          if (_day != null) _getDayInfo(_day),
        ],
      ),
    ));
  }

  Widget _getRowInput() {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: _latController,
            decoration: const InputDecoration(hintText: 'Широта'),
            keyboardType: const TextInputType.numberWithOptions(
                decimal: true, signed: true),
          ),
        ),
      ],
    );
  }
  
  Widget _getDayInfo(Day day) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text('Восход: ${day.sunrise?.toLocal()}'),
        Text('Заход: ${day.sunset?.toLocal()}'),
        Text('Полдень: ${day.solarNoon?.toLocal()}'),
        Text('Продолжительность дня: ${Duration(seconds: day.dayLength)}'),
      ],
    );
  }

  void _getDay() {

  }
}
