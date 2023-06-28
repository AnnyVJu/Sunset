import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:sunset/domain/state/home/home_state.dart';
import '../domain/model/day.dart';
import '../internal/dependencies/home_module.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _latController = TextEditingController();
  final _lngController = TextEditingController();

  late HomeState _homeState;

  @override
  void initState() {
    super.initState();
    _homeState = HomeModule.homeState();
  }

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
            _getDayInfo(),
          ],
        ),
      ),
    );
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

  Widget _getDayInfo() {
    return Observer(
      builder: (_) {
        if (_homeState.isLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (_homeState.day == null) return Container();
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('Восход: ${_homeState.day?.sunrise?.toLocal()}'),
            Text('Заход: ${_homeState.day?.sunset?.toLocal()}'),
            Text('Полдень: ${_homeState.day?.solarNoon?.toLocal()}'),
            Text('Продолжительность дня: ${Duration(seconds: _homeState.day!.dayLength)}'),
          ],
        );
      },
    );
  }

  void _getDay() {
    final lat = double.tryParse(_latController.text);
    final lng = double.tryParse(_lngController.text);
    _homeState.getDay(latitude: lat, longitude: lng);
  }
}
