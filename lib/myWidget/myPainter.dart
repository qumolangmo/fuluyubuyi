import 'package:flutter/material.dart';

class MyPainter extends CustomPainter{
  static const double basePadding = 16;
  late double startX,endX;
  late double startY,endY;
  late double _fixedWidth;
  late double _fixedHeight;
  Path _path = new Path();

  void _initBorder(Size size){
    startX = basePadding*2;
    endX = size.width-basePadding*2;
    endY = size.height-basePadding*2;
    startY = basePadding*2;

    _fixedHeight = endY - startY;
    _fixedWidth = endX - startX;
  }

  void _drawXY(Canvas canvas){
    var paint = Paint()
    ..isAntiAlias = true    //抗锯齿
    ..strokeWidth = 1.0
    ..strokeCap = StrokeCap.square  //行首行尾的线条形状
    ..color = Colors.white
    ..style = PaintingStyle.stroke;
    //开始画线:X轴
    canvas.drawLine(Offset(startX,startY), Offset(endX, startY), paint);
    //开始画线:Y轴
    canvas.drawLine(Offset(startX,startY), Offset(startX, endY), paint);

  }

  void _drawXRuler(Canvas canvas,int i,double spacing,double rulerHeight,var paint){
    canvas.drawLine(
      Offset(startX+i*spacing,startY),
      Offset(startX+i*spacing, startY+rulerHeight) , paint);
  }
  void _drawYRuler(Canvas canvas,int i,double spacing,double rulerHeight,var paint){
    canvas.drawLine(
      Offset(startX,startY+i*spacing),
      Offset(startX+rulerHeight, startY+i*spacing) , paint);
  }

  void _drawXText(Canvas canvas,double spacing,int i){
    TextPainter(
      textAlign: TextAlign.center,
      ellipsis: '.',
      text: TextSpan(
        text: (i).toString(),
        style: const TextStyle(color: Colors.white,fontSize: 10),
      ),
      textDirection: TextDirection.ltr
    )
      ..layout(minWidth: spacing,maxWidth: spacing)
      ..paint(canvas, Offset(startX-spacing/2+i*spacing,startY-basePadding));
  }
  void _drawYText(Canvas canvas,double spacing,int i){
    TextPainter(
      textAlign: TextAlign.center,
      ellipsis: '.',
      text: TextSpan(
        text: (i-1).toString(),
        style: const TextStyle(color: Colors.white,fontSize: 10),
      ),
      textDirection: TextDirection.ltr
    )
      ..layout(minWidth: spacing,maxWidth: spacing)
      ..paint(canvas, Offset(startX-20,startY-spacing/2+(i-1)*spacing));
  }


  void _drawXYRulerWithText(Canvas canvas){
    var paint = Paint()
      ..isAntiAlias = true    //抗锯齿
      ..strokeWidth = 1.0
      ..strokeCap = StrokeCap.square  //行首行尾的线条形状
      ..color = Colors.white
      ..style = PaintingStyle.stroke;

      int rulerCount = 10;
      double YSpacing = _fixedHeight/rulerCount;
      double XSpacing = _fixedWidth/rulerCount;

      for(int i=1;i<=rulerCount;i++){
        //X轴上的刻度
        _drawXRuler(canvas, i, XSpacing, 5, paint);
        //Y轴上的刻度
        _drawYRuler(canvas, i, YSpacing, 5, paint);
        _drawXText(canvas, XSpacing, i);
        _drawYText(canvas, YSpacing, i);
      }
  }

  void _initPath(int i,double xSpacing,double ySpacing){
    if(i==0){
      var x = startX;
      var y = startY;
      _path.moveTo(x, y);
    }
    else{
      double currentX = startX+xSpacing*i;
      double currentY = (startY + ( i%2==0?ySpacing:ySpacing*4));
      _path.lineTo(currentX, currentY);
    }
  }

  void _drawLine(Canvas canvas){
    var paint = Paint()
      ..isAntiAlias = true
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round
      ..color = Colors.red
      ..style = PaintingStyle.stroke;

      var pathMetrics = _path.computeMetrics(forceClosed: false);
      var list = pathMetrics.toList();
      var length = list.length.toInt();
      Path linePath = new Path();
      for(int i=0;i<length;i++){
        var extractPath = list[i].extractPath(0, list[i].length,startWithMoveTo: true);
        linePath.addPath(extractPath,Offset(0,0));
      }
      canvas.drawPath(linePath, paint);
  }

  @override
  void paint(Canvas canvas, Size size) {
    _initBorder(size);
    _drawXY(canvas);
    _drawXYRulerWithText(canvas);
  _drawLine(canvas);

  }
  
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {//是否可以重新绘制
    return true;
  }
}