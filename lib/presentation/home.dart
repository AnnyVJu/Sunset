import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:sunset/domain/state/home/home_state.dart';
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
    Size size = MediaQuery.of(context).size;
   // double containerHeight = size.height * 0.90;
    return MaterialApp(
      theme: ThemeData(colorScheme: const ColorScheme.highContrastDark()),
      home: GestureDetector(
        onTap: FocusScope.of(context).unfocus,
        child: Scaffold(
          body: _getBody(),
        ),
      ),
    );
  }

  Widget _getBody() {
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: Image.asset("assets/images/2.png").image,
                  fit: BoxFit.cover)),
          child: Center(
            child: ClipRRect(
              borderRadius: borderRadius,
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                child: Container(
                  width: 350,
                  height: 350,
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            color: Colors.red.withOpacity(0.2), blurRadius: 10)
                      ],
                      borderRadius: borderRadius,
                      border: Border.all(
                          color: Colors.white.withOpacity(0.5), width: 1.0),
                      gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Colors.white.withOpacity(0.2),
                            Colors.white.withOpacity(0.1)
                          ],
                          stops: const [
                            0.0,
                            1.0
                          ])),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          _getRowInput(),
                          const SizedBox(height: 20),
                          OutlinedButton(
                            style: const ButtonStyle(
                              padding:
                                  MaterialStatePropertyAll(EdgeInsets.all(10)),
                            ),
                            onPressed: _getDay,
                            child: const Text('Получить'),
                          ),
                          const SizedBox(height: 20),
                          _getDayInfo(),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _getRowInput() {
    return Column(
      children: [
        TextField(
          controller: _latController,
          decoration: const InputDecoration(hintText: 'Широта'),
          keyboardType: const TextInputType.numberWithOptions(
              decimal: true, signed: true),
        ),
        const SizedBox(height: 20),
        TextField(
          controller: _lngController,
          keyboardType: const TextInputType.numberWithOptions(
              decimal: true, signed: true),
          decoration: const InputDecoration(hintText: 'Долгота'),
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
            Text(
                'Продолжительность дня: ${Duration(seconds: _homeState.day!.dayLength)}'),
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

final borderRadius = BorderRadius.circular(20.0);
