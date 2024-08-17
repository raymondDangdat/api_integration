import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'model/data_plans_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  DataPlanModel? dataPlanModel;

  bool fetchingPlans = true;

  @override
  void initState() {
    getDataPlans();
    super.initState();
  }

  void getDataPlans() async {
    var url = "https://uzobestgsm.com/api/network/";

    // Await the http get response, then decode the json-formatted response.
    var response = await http.put(Uri.parse(url), headers: {
      "Accept": "application/json",
      'Content-Type': 'application/json',
      'Authorization': 'Token '
    });

    setState(() {
      fetchingPlans = false;
    });
    if (response.statusCode == 200 || response.statusCode == 201) {
      dataPlanModel = dataPlanModelFromJson(response.body);
      if (dataPlanModel != null) {
        debugPrint("We have list of data plans");
        debugPrint("MTN Plans: ${dataPlanModel!.airtelPlan.length}");
      } else {
        debugPrint("No Data plans");
      }
    } else {
      debugPrint('Request failed with status: ${response.statusCode}.');
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: SafeArea(
          child: Column(
        children: [
          const SizedBox(
            height: 30,
          ),
          const Text("MTN Plans"),
          const SizedBox(
            height: 20,
          ),
          Expanded(
              child: fetchingPlans
                  ? const Center(child: CupertinoActivityIndicator())
                  : dataPlanModel == null
                      ? const Text("Error Fetching Data Plans")
                      : ListView.builder(
                          itemCount: dataPlanModel!.mtnPlan.length,
                          itemBuilder: (context, index) {
                            final plan = dataPlanModel!.mtnPlan[index];
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: Column(
                                children: [
                                  Text(
                                    "Plan: ${plan.plan}",
                                    style:
                                        const TextStyle(fontWeight: FontWeight.w700),
                                  ),
                                  Text(
                                      "Validity: ${plan.monthValidate} Amount: NGN${plan.planAmount}"),
                                ],
                              ),
                            );
                          })),
        ],
      )), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
