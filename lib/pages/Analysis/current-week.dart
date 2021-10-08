import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:jarvia_prime/utilities/data_classes/records.dart';
import 'package:jarvia_prime/Firebase-Interaction/Read/read.dart';
import 'package:intl/intl.dart';

class CurrentWeekChart extends StatefulWidget {
  @override
  _CurrentWeekChartState createState() => _CurrentWeekChartState();
}

class _CurrentWeekChartState extends State<CurrentWeekChart> {
  Future<List<CurrentWeekData>> _weekData = getWeekData();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<CurrentWeekData>>(
      future: _weekData,
      builder: (BuildContext context, AsyncSnapshot<List<CurrentWeekData>> snapshot){
        if(snapshot.hasData){
          List<CurrentWeekData> listOfCurrentWeekData = snapshot.data!;
          return SfCartesianChart(
              primaryXAxis: CategoryAxis(),
              primaryYAxis: NumericAxis(
                edgeLabelPlacement: EdgeLabelPlacement.shift,
                numberFormat: NumberFormat("####.##", "en_us"),
                title: AxisTitle(text: "Time in each Quadrant (Hours)"),
              ),
              series: <BarSeries<CurrentWeekData, String>>[
                BarSeries<CurrentWeekData, String>(
                    dataSource: listOfCurrentWeekData,
                    xValueMapper: (CurrentWeekData week, _) => week.quadrant,
                    yValueMapper: (CurrentWeekData week, _) => week.hours,
                  dataLabelSettings: DataLabelSettings(isVisible: true),
                )
              ]
          );
        }else if(snapshot.hasError) {
          return Container(
            child: Text("Error: ${snapshot.error}"),
          );
        }else{
          return Container(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const <Widget>[
                  SizedBox(
                    child: CircularProgressIndicator(),
                    width: 60,
                    height: 60,
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 16),
                    child: Text('Awaiting result...'),
                  )
                ],
              ),
            ),
          );
        }
      },
    );
  }

  static Future<List<CurrentWeekData>> getWeekData() async{
    List<CurrentWeekData>  currentWeekData = [];
    Map<String, double> allQuadrantHours = {};
    await Reader.getQuadrantHours().then((result) => {
      allQuadrantHours = result
    });

    allQuadrantHours.forEach((quadrant, hours) {
      if(quadrant == "Quadrant 1"){
        CurrentWeekData current = CurrentWeekData(quadrant, hours);
        currentWeekData = <CurrentWeekData>[current];
      } else{
        CurrentWeekData current = CurrentWeekData(quadrant, hours);
        currentWeekData.add(current);
      }
    });
    return currentWeekData;
  }
}