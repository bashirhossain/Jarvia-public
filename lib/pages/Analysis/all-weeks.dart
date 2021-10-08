import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:jarvia_prime/utilities/data_classes/records.dart';
import 'package:jarvia_prime/Firebase-Interaction/Read/all_week_records.dart';

class AllWeekChart extends StatefulWidget {
  @override
  _AllWeekChartState createState() => _AllWeekChartState();
}

class _AllWeekChartState extends State<AllWeekChart> {
  Future<List<AllWeeksData>> _weekData = getAllWeeksData();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<AllWeeksData>>(
      future: _weekData,
      builder: (BuildContext context, AsyncSnapshot<List<AllWeeksData>> snapshot){
        if(snapshot.hasData){
          List<AllWeeksData> listOfCurrentWeekData = snapshot.data!;
          return SfCartesianChart(
              primaryXAxis: CategoryAxis(),
              series: <ChartSeries>[
                StackedLineSeries<AllWeeksData, String>(
                  // Bind data source
                    dataSource: listOfCurrentWeekData,
                    xValueMapper: (AllWeeksData week, _) => week.week,
                    yValueMapper: (AllWeeksData week, _) => week.q1
                ),
                StackedLineSeries<AllWeeksData, String>(
                  // Bind data source
                    dataSource: listOfCurrentWeekData,
                    xValueMapper: (AllWeeksData week, _) => week.week,
                    yValueMapper: (AllWeeksData week, _) => week.q2
                ),
                StackedLineSeries<AllWeeksData, String>(
                  // Bind data source
                    dataSource: listOfCurrentWeekData,
                    xValueMapper: (AllWeeksData week, _) => week.week,
                    yValueMapper: (AllWeeksData week, _) => week.q3
                ),
                StackedLineSeries<AllWeeksData, String>(
                  // Bind data source
                    dataSource: listOfCurrentWeekData,
                    xValueMapper: (AllWeeksData week, _) => week.week,
                    yValueMapper: (AllWeeksData week, _) => week.q4
                ),
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

  static Future<List<AllWeeksData>> getAllWeeksData() async{
    List<AllWeeksData>  allWeeksDataList = [];
    List<dynamic> allWeeksQuadrantHours = [];
    await AllWeekReader.getAllWeekRecords().then((result) => {
      allWeeksQuadrantHours = result
    });

    for(var i in allWeeksQuadrantHours){
      if(!i.isEmpty){
        i.forEach((week, quadrantHourMap) {
          AllWeeksData allWeeksData = AllWeeksData(
              week,
              quadrantHourMap["Quadrant 1"],
              quadrantHourMap["Quadrant 2"],
              quadrantHourMap["Quadrant 3"],
              quadrantHourMap["Quadrant 4"]
          );
          allWeeksDataList.add(allWeeksData);
        });
      }
    }
    print(allWeeksDataList);
    return allWeeksDataList;
  }
}

class AllWeeksData{
  AllWeeksData(this.week, this.q1, this.q2, this.q3, this.q4);
  final String week;
  final double q1;
  final double q2;
  final double q3;
  final double q4;
}