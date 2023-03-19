import 'package:flutter/material.dart';

class DetailScreen extends StatefulWidget {
  String image, name;
  int totalCases,
      totalDeaths,
      totalRecovered,
      active,
      critical,
      todayRecovered,
      test;

  DetailScreen({
    required this.image,
    required this.name,
    required this.totalCases,
    required this.totalDeaths,
    required this.totalRecovered,
    required this.active,
    required this.critical,
    required this.todayRecovered,
    required this.test,
  });

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 50,
            backgroundImage: NetworkImage(widget.image),
          ),
          const SizedBox(
            height: 20,
          ),
          Card(
            child: Column(
              children: [
                ReusableRow(
                  title: 'Cases',
                  value: widget.totalCases.toString(),
                ),
                ReusableRow(
                  title: 'Recovered',
                  value: widget.totalRecovered.toString(),
                ),
                ReusableRow(
                  title: 'Death',
                  value: widget.totalDeaths.toString(),
                ),
                ReusableRow(
                  title: 'Critical',
                  value: widget.critical.toString(),
                ),
                ReusableRow(
                  title: 'Today Recovered',
                  value: widget.totalRecovered.toString(),
                ),
              ],
            ),
          )
        ],
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
