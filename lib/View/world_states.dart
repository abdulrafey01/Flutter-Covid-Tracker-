import "package:covid_19_tracker_app/Modal/world_states_model.dart";
import "package:flutter/material.dart";
import "package:flutter_spinkit/flutter_spinkit.dart";
import "package:pie_chart/pie_chart.dart";

import '../Modal/hit_world_states_api.dart';
import "countries_states.dart";

class WorldStates extends StatefulWidget {
  const WorldStates({super.key});

  @override
  State<WorldStates> createState() => _WorldStatesState();
}

class _WorldStatesState extends State<WorldStates>
    with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 8),
    vsync: this,
  )..repeat();

  WorldStatesHitApi worldStatesHitApi = WorldStatesHitApi();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * .01,
              ),
              FutureBuilder(
                  future: worldStatesHitApi.hitApiWorldStates(),
                  builder: (context, AsyncSnapshot<WorldStatesModel> snapshot) {
                    print(snapshot);
                    if (!snapshot.hasData) {
                      return const Expanded(
                        child: SpinKitCircle(
                          color: Colors.white,
                        ),
                      );
                    } else {
                      return Column(
                        children: [
                          PieChart(
                            dataMap: {
                              "Cases":
                                  double.parse(snapshot.data!.cases.toString()),
                              "Recovered": double.parse(
                                  snapshot.data!.recovered.toString()),
                              "Death": double.parse(
                                  snapshot.data!.deaths.toString()),
                            },
                            chartValuesOptions: const ChartValuesOptions(
                                showChartValuesInPercentage: true),
                            animationDuration: const Duration(seconds: 3),
                            chartRadius:
                                MediaQuery.of(context).size.width / 3.2,
                            legendOptions: const LegendOptions(
                                legendPosition: LegendPosition.left),
                            chartType: ChartType.ring,
                            colorList: const [
                              Color(0xff1aa260),
                              Color(0xffde5246),
                              Color(0xff4285f4),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 30),
                            child: Card(
                              child: Column(
                                children: [
                                  ReusableRow(
                                      title: 'Total Cases',
                                      value: snapshot.data!.cases.toString()),
                                  ReusableRow(
                                      title: 'Deaths',
                                      value: snapshot.data!.deaths.toString()),
                                  ReusableRow(
                                      title: 'Recovered',
                                      value:
                                          snapshot.data!.recovered.toString()),
                                  ReusableRow(
                                      title: 'Active',
                                      value: snapshot.data!.active.toString()),
                                  ReusableRow(
                                      title: 'Critical',
                                      value:
                                          snapshot.data!.critical.toString()),
                                  ReusableRow(
                                      title: 'Today Deaths',
                                      value: snapshot.data!.todayDeaths
                                          .toString()),
                                  ReusableRow(
                                      title: 'Today Recovered',
                                      value: snapshot.data!.todayRecovered
                                          .toString()),
                                ],
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const CountriesList()));
                            },
                            child: Container(
                              height: 50,
                              width: 280,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Colors.deepOrange[300]),
                              child: const Center(
                                  child: Text(
                                "Track Countries",
                                style: TextStyle(fontSize: 17),
                              )),
                            ),
                          )
                        ],
                      );
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }
}

class ReusableRow extends StatelessWidget {
  String title, value;
  ReusableRow({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title),
              Text(value),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          const Divider()
        ],
      ),
    );
  }
}
