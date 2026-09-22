import 'package:flutter/material.dart';
import 'package:stack_appodeal_flutter/stack_appodeal_flutter.dart';

class EndpointPage extends StatefulWidget {
  @override
  _EndpointPageState createState() => _EndpointPageState();
}

class _EndpointPageState extends State<EndpointPage> {
  final TextEditingController _controller = TextEditingController();
  String _currentEndpoint = '';

  @override
  void initState() {
    super.initState();
    getEndpoint().then((endpoint) => _controller.text = endpoint);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<String> getEndpoint() async {
    final endpoint = await Appodeal.getEndpoint();
    print("getEndpoint: $endpoint");
    if (mounted) setState(() => _currentEndpoint = endpoint);
    return endpoint;
  }

  setEndpoint() async {
    final endpoint = _controller.text.trim();
    await Appodeal.setEndpoint(endpoint);
    final current = await Appodeal.getEndpoint();
    print("setEndpoint: $endpoint -> getEndpoint: $current");
    if (mounted) setState(() => _currentEndpoint = current);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Custom endpoint'),
        automaticallyImplyLeading: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(spacing: 12, children: [
          const Text(
            'Call before INITIALIZATION',
            style: TextStyle(fontSize: 14),
            textAlign: TextAlign.center,
          ),
          TextField(
            controller: _controller,
            keyboardType: TextInputType.url,
            decoration: const InputDecoration(
              labelText: 'Endpoint',
              border: OutlineInputBorder(),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    textStyle: const TextStyle(fontSize: 20),
                    fixedSize: Size(300, 20)),
                onPressed: () {
                  setEndpoint();
                },
                child: const Text('SET ENDPOINT'),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    textStyle: const TextStyle(fontSize: 20),
                    fixedSize: Size(300, 20)),
                onPressed: () {
                  getEndpoint();
                },
                child: const Text('GET ENDPOINT'),
              ),
            ],
          ),
          Text(
            'Current endpoint: $_currentEndpoint',
            style: const TextStyle(fontSize: 14),
            textAlign: TextAlign.center,
          ),
        ]),
      ),
    );
  }
}
