import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/data/model.dart';

class WeatherView extends StatefulWidget {
  const WeatherView({super.key});

  @override
  State<WeatherView> createState() => _WeatherViewState();
}

class _WeatherViewState extends State<WeatherView> {
  final cityController = TextEditingController(text: 'Mansoura');

  bool isLoading = false;
  WeatherData? model;

  getData() async {
    isLoading = true;
    setState(() {});
    final response = await Dio().get(
        'https://api.openweathermap.org/data/2.5/weather?q=${cityController.text}&appid=509dc5d730ff2dd6003b22f30ae93313');
    print(response.data);
    model = WeatherData.fromJson(response.data);
    isLoading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('WeatherApp'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              isLoading
                  ? CircularProgressIndicator()
                  : model != null
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('Time ='),
                                Text(model!.timezone.toString()),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('City ='),
                                Text(model!.name),
                              ],
                            ),
                          ],
                        )
                      : SizedBox.shrink(),
              SizedBox(
                height: 16,
              ),
              TextFormField(
                  controller: cityController,
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    borderSide: BorderSide(width: 1, color: Colors.deepPurple),
                  ))),
              SizedBox(
                height: 16,
              ),
              ElevatedButton(
                  onPressed: () {
                    getData();
                  },
                  child: Text('Get')),
            ],
          ),
        ),
      ),
    );
  }
}
