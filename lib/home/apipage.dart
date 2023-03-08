import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'dart:ui';
import '../connectivity.dart';

class Apipage extends StatefulWidget {
  const Apipage({Key? key}) : super(key: key);

  @override
  State<Apipage> createState() => _ApipageState();
}

class _ApipageState extends State<Apipage> {
  final _formKey = GlobalKey<FormState>();
  bool _iseditable = false;
  final Map<String, dynamic> _formData = {};
  // late String domain;
  // late String key;
  // late String secret;

  @override
  void initState() {
    // getCurrentAPI();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = Theme.of(context).colorScheme;
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Container(
            height: MediaQuery.of(context).size.height * .4,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primaryContainer,
            ),
            child: const SizedBox()),
        Container(
            margin: const EdgeInsets.only(top: 100),
            padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
            width: MediaQuery.of(context).size.width * .9,
            decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                color: Theme.of(context).colorScheme.background,
                boxShadow: const [BoxShadow(color: Colors.black12)],
                border: Border.all(width: .1, color: Colors.black)),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(
                    fit: BoxFit.fitWidth,
                    'assets/images/logo.png',
                    scale: .10,
                  ),
                  const Center(child: Text("Please enter below API Details.")),
                  Form(
                    key: _formKey,
                    child: FutureBuilder(
                      future: Auth.getAPI(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          Map api = snapshot.data as Map;
                          return Column(
                            children: [
                              TextFormField(
                                initialValue: api['domain'],
                                decoration: InputDecoration(
                                  filled: true,
                                  enabled: _iseditable,
                                  border: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
                                  labelText: 'Domain',
                                ),
                                onSaved: (newValue) {
                                  setState(() {
                                    _formData['domain'] = newValue;
                                  });
                                },
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              TextFormField(
                                initialValue: api['key'],
                                enabled: _iseditable,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'API Key',
                                ),
                                onSaved: (newValue) {
                                  setState(() {
                                    _formData['key'] = newValue;
                                  });
                                },
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              TextFormField(
                                initialValue: api['secret'],
                                enabled: _iseditable,
                                obscureText: true,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'API Secret',
                                ),
                                onSaved: (newValue) {
                                  setState(() {
                                    _formData['secret'] = newValue;
                                  });
                                },
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  !_iseditable
                                      ? IconButton(
                                          style: IconButton.styleFrom(foregroundColor: colors.onPrimaryContainer, backgroundColor: colors.primaryContainer),
                                          onPressed: () {
                                            setState(() {
                                              _iseditable = !_iseditable;
                                            });
                                          },
                                          icon: const Icon(Icons.edit))
                                      : IconButton(
                                          style: IconButton.styleFrom(foregroundColor: colors.onPrimaryContainer, backgroundColor: colors.primaryContainer),
                                          onPressed: () {
                                            _formKey.currentState!.save();
                                            Auth.setAPI(_formData['domain'], _formData['key'], _formData['secret']);
                                            setState(() {
                                              _iseditable = !_iseditable;
                                            });
                                          },
                                          icon: const Icon(Icons.save)),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  !_iseditable
                                      ? ElevatedButton(
                                          onPressed: () async {
                                            bool status = await Auth.checkAPI(_formData['domain'], _formData['key'], _formData['secret']);
                                            if (status == true) {
                                              Auth.setAPI(_formData['domain'], _formData['key'], _formData['secret']);
                                              // ignore: use_build_context_synchronously
                                              context.go("/successapi");
                                            } else {
                                              // ignore: use_build_context_synchronously
                                              showDialog(
                                                  context: context,
                                                  builder: (BuildContext context) {
                                                    return AlertDialog(
                                                      title: const Text("Wrong API"),
                                                      content: const Text("Please check the API again or consult the Administrator."),
                                                      actions: <Widget>[
                                                        TextButton(
                                                          onPressed: () => Navigator.pop(context, 'OK'),
                                                          child: const Text('OK'),
                                                        ),
                                                      ],
                                                    );
                                                  });
                                            }
                                          },
                                          child: const Text("Connect"))
                                      : const SizedBox()
                                ],
                              )
                            ],
                          );
                        } else {
                          return Container();
                        }
                      },
                    ),
                  )
                ],
              ),
            ))
      ],
    );
  }
}
