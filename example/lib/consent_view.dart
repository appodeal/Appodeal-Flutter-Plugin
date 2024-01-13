import 'package:flutter/material.dart';
import 'package:stack_appodeal_flutter/stack_appodeal_flutter.dart';

import 'main.dart';

class ConsentPage extends StatefulWidget {
  @override
  _ConsentPageState createState() => _ConsentPageState();
}

class _ConsentPageState extends State<ConsentPage> {
  @override
  void initState() {
    super.initState();
  }

  load() {
    Appodeal.ConsentForm.load(
        appKey: exampleAppodealKey,
        onConsentFormLoadSuccess: (status) {
          print("onConsentFormLoadSuccess: status - $status");
        },
        onConsentFormLoadFailure: (error) {
          print("onConsentFormLoadFailure: error - ${error.description}");
        });
  }

  show() {
    Appodeal.ConsentForm.show(onConsentFormDismissed: (error) {
      if (error != null) {
        print("onConsentFormDismissed: error - ${error.description}");
      } else {
        print("onConsentFormDismissed: No error");
      }
    });
  }

  loadAndShowIfRequired() {
    Appodeal.ConsentForm.loadAndShowIfRequired(
        appKey: exampleAppodealKey,
        onConsentFormDismissed: (error) {
          if (error != null) {
            print("onConsentFormDismissed: error - ${error.description}");
          } else {
            print("onConsentFormDismissed: No error");
          }
        });
  }

  revoke() {
    Appodeal.ConsentForm.revoke();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Consent management platform'),
        automaticallyImplyLeading: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    textStyle: const TextStyle(fontSize: 20),
                    fixedSize: Size(300, 20)),
                onPressed: () {
                  load();
                },
                child: const Text('LOAD CONSENT FORM'),
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
                  show();
                },
                child: const Text('SHOW CONSENT FORM'),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    textStyle: const TextStyle(fontSize: 20),
                    fixedSize: Size.fromWidth(300)),
                onPressed: () {
                  loadAndShowIfRequired();
                },
                child: const Text(
                  'LOAD AND SHOW CONSENT FORM IF REQUIRED',
                  maxLines: 3,
                  textAlign: TextAlign.center,
                ),
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
                  revoke();
                },
                child: const Text('REVOKE CONSENT'),
              ),
            ],
          ),
          //Interstitial
        ]),
      ),
    );
  }
}
