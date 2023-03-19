import 'package:covid_19_tracker_app/Modal/hit_world_states_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:shimmer/shimmer.dart';

import 'detail_screen.dart';

class CountriesList extends StatefulWidget {
  const CountriesList({super.key});

  @override
  State<CountriesList> createState() => _CountriesListState();
}

class _CountriesListState extends State<CountriesList> {
  WorldStatesHitApi worldStatesHitApi = WorldStatesHitApi();

  final TextEditingController _textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextFormField(
                controller: _textEditingController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50)),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                    hintText: "Search",
                    suffixIcon: _textEditingController.text.isEmpty
                        ? const Icon(Icons.search)
                        : GestureDetector(
                            onTap: () {
                              _textEditingController.text = "";
                              setState(() {});
                            },
                            child: const Icon(Icons.clear))),
                onChanged: (value) {
                  setState(() {});
                },
              ),
              Expanded(
                  child: FutureBuilder(
                      future: worldStatesHitApi.hitApiCountriesStates(),
                      builder:
                          ((context, AsyncSnapshot<List<dynamic>> snapshot) {
                        if (!snapshot.hasData) {
                          return ListView.builder(
                              itemCount: 5,
                              itemBuilder: (context, index) {
                                return Shimmer.fromColors(
                                  baseColor: Colors.grey.shade700,
                                  highlightColor: Colors.grey.shade100,
                                  child: ListTile(
                                    leading: Container(
                                      height: 50,
                                      width: 50,
                                      color: Colors.white,
                                    ),
                                    title: Container(
                                      width: 100,
                                      height: 8.0,
                                      color: Colors.white,
                                    ),
                                    subtitle: Container(
                                      width: double.infinity,
                                      height: 8.0,
                                      color: Colors.white,
                                    ),
                                  ),
                                );
                              });
                        } else {
                          return ListView.builder(
                              itemCount: snapshot.data!.length,
                              itemBuilder: (context, index) {
                                String name = snapshot.data![index]['country'];
                                if (_textEditingController.text.isEmpty) {
                                  return Column(
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          Navigator.push(context,
                                              MaterialPageRoute(
                                                  builder: (context) {
                                            return DetailScreen(
                                              image: snapshot.data![index]
                                                  ['countryInfo']['flag'],
                                              name: snapshot.data![index]
                                                  ['country'],
                                              totalCases: snapshot.data![index]
                                                  ['cases'],
                                              totalRecovered: snapshot
                                                  .data![index]['recovered'],
                                              totalDeaths: snapshot.data![index]
                                                  ['deaths'],
                                              active: snapshot.data![index]
                                                  ['active'],
                                              test: snapshot.data![index]
                                                  ['tests'],
                                              todayRecovered:
                                                  snapshot.data![index]
                                                      ['todayRecovered'],
                                              critical: snapshot.data![index]
                                                  ['critical'],
                                            );
                                          }));
                                        },
                                        child: ListTile(
                                          leading: Image(
                                              height: 50,
                                              width: 50,
                                              image: NetworkImage(
                                                  snapshot.data![index]
                                                      ['countryInfo']['flag'])),
                                          title: Text(
                                              snapshot.data![index]['country']),
                                          // ignore: prefer_interpolation_to_compose_strings
                                          subtitle: Text("Effected: " +
                                              snapshot.data![index]['cases']
                                                  .toString()),
                                        ),
                                      ),
                                      const Divider()
                                    ],
                                  );
                                } else if (name.toLowerCase().contains(
                                    _textEditingController.text
                                        .toLowerCase())) {
                                  Column(
                                    children: [
                                      ListTile(
                                        leading: Image(
                                            height: 50,
                                            width: 50,
                                            image: NetworkImage(
                                                snapshot.data![index]
                                                    ['countryInfo']['flag'])),
                                        title: Text(
                                            snapshot.data![index]['country']),
                                        // ignore: prefer_interpolation_to_compose_strings
                                        subtitle: Text("Effected: " +
                                            snapshot.data![index]['cases']
                                                .toString()),
                                      ),
                                      const Divider()
                                    ],
                                  );
                                } else {
                                  return Container();
                                }
                              });
                        }
                      })))
            ],
          ),
        ),
      ),
    );
  }
}
