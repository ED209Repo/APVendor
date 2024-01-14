import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HistogramData {
  HistogramData(this.x);

  final double x;
}

class HistogramDefault extends StatefulWidget {
  const HistogramDefault({Key? key}) : super(key: key);

  @override
  _HistogramDefaultState createState() => _HistogramDefaultState();
}

class _HistogramDefaultState extends State<HistogramDefault> {
  late bool _showDistributionCurve;
  late TooltipBehavior _tooltipBehavior;

  @override
  void initState() {
    super.initState();
    _showDistributionCurve = true;
    _tooltipBehavior = TooltipBehavior(enable: true);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 60),
      child: _buildDefaultHistogramChart(),
    );
  }

  SfCartesianChart _buildDefaultHistogramChart() {
    return SfCartesianChart(
      plotAreaBorderWidth: 0,
      title: ChartTitle(
          text: AppLocalizations.of(context)!.customers, textStyle:
      TextStyle (color: Colors.black,
        fontSize: 26,
        fontWeight: FontWeight.bold,
        letterSpacing: 2)),
      primaryXAxis: NumericAxis(
        majorGridLines: const MajorGridLines(width: 0),
        minimum: 0,
        maximum: 100,
      ),
      primaryYAxis: NumericAxis(
        name: 'Number of Customers',
        minimum: 0,
        maximum: 50,
        axisLine: const AxisLine(width: 0),
        majorTickLines: const MajorTickLines(size: 0),
      ),
      series: _getHistogramSeries(),
      tooltipBehavior: _tooltipBehavior,
    );
  }

  List<HistogramSeries<HistogramData, double>> _getHistogramSeries() {
    return <HistogramSeries<HistogramData, double>>[
      HistogramSeries<HistogramData, double>(
        name: 'Customers',
        dataSource: <HistogramData>[
          HistogramData(5.250),
          HistogramData(7.750),
          HistogramData(5.250),
          HistogramData(7.750),
          HistogramData(5.250),
          HistogramData(7.750),
          HistogramData(5.250),
          HistogramData(2.350),
          HistogramData(3.450),
          HistogramData(2.650),
          HistogramData(3.250),
          HistogramData(2.350),
          HistogramData(8.250),
          HistogramData(3.350),
          // Add more data points as needed
        ],
        showNormalDistributionCurve: _showDistributionCurve,
        curveColor: const Color.fromRGBO(192, 108, 132, 1),
        binInterval: 20,
        curveDashArray: <double>[12, 3, 3, 3],
        width: 0.99,
        curveWidth: 2.5,
        yValueMapper: (HistogramData data, _) => data.x,
        dataLabelSettings: const DataLabelSettings(
          isVisible: true,
          labelAlignment: ChartDataLabelAlignment.top,
          textStyle: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
    ];
  }
}
