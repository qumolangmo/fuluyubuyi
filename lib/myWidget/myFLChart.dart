import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

GlobalKey<_MyFLChartState> flChartKey = GlobalKey();

class MyFLChart extends StatefulWidget {
  //data format is [[x,y],[x,y],[x,y]...]
  final List<List> data;
  final double minX;
  final double maxX;
  final double minY;
  final double maxY;
  MyFLChart({required this.data, super.key, required this.minX, required this.maxX, required this.minY, required this.maxY,});

  @override
  State<MyFLChart> createState() => _MyFLChartState();
}


//将传送过来的原始列表[x,y]转换成FlSpot(x,y)
List<FlSpot> dataToFlSpot(List<List> tmp){
  List<FlSpot> fl = [];
  for(var tmp1 in tmp){
    fl.add(FlSpot(tmp1[0].toDouble(), tmp1[1].toDouble()));
  }
  return fl;
}

class _MyFLChartState extends State<MyFLChart> {

  void change(){
    setState(() {
      
    });
  }

  List<LineChartBarData> getBarData(){
    return [LineChartBarData(
      spots: dataToFlSpot(widget.data),         //用来绘制图形的数据
      isCurved: true,                           //是否绘制成曲线
      color: Colors.blue,                     //曲线颜色
      barWidth: 2,                              //曲线粗细
      isStrokeCapRound: true,                   //确定线头的形状
      dotData: FlDotData(                       //显示结点
        show: false,
      ),
      belowBarData: BarAreaData(                //填充曲线下区域的颜色
        show: false,
      )
    )];
  }
  @override
  Widget build(BuildContext context) {
    return LineChart(
      LineChartData(
        lineTouchData: LineTouchData(enabled: true),
        //网格线的设置
        gridData: FlGridData(
          show: true,                   //是否显示网格线
          drawVerticalLine: true,       //是否绘制垂直方向的网格线
          //getDrawingHorizontalLine:         通过FlLine来定义网格线的颜色，粗细等属性
          //getDrawingVerticalLine: 
        ),
        //自定义x，y轴的各点值
        titlesData: FlTitlesData(
          show: true,                   //是否显示xy轴的标题
          bottomTitles: AxisTitles(     //x轴标题
            //axisNameSize: 22,
            sideTitles: SideTitles(
              showTitles: false,
              reservedSize: 22,
              getTitlesWidget: (value, meta) {
                //定义标题的样式
                const style = TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16
                );
                //设定标题
                Widget text = Text("$value",style: style,);
                //返回标题组件
                return SideTitleWidget(
                  axisSide: meta.axisSide,
                  child: text
                );
              },
              //interval: 1
            )
          ),   
          leftTitles: AxisTitles(       //y轴标题
            sideTitles: SideTitles(
              showTitles: false,
              reservedSize: 16,
              getTitlesWidget: (value, meta) {
                const style = TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16
                );
                Widget text = Text("$value",style: style,);
                return SideTitleWidget(
                  axisSide: meta.axisSide,
                  child: text,
                );
              },
            )
          ),
          
        ),
        //设置边框大小和颜色
        borderData: FlBorderData(
          show: true,
          border: Border.all(color: Colors.blue,width: 1)
        ),
        //设置x和y轴的起点和终点
        minX: widget.minX,
        maxX: widget.maxX,
        minY: widget.minY,
        maxY: widget.maxY,
        //设置用来绘制图像的数据和样式
        lineBarsData: getBarData(),
      )
    );
    
  }
}