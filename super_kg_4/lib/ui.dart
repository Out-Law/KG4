
import 'package:flutter/material.dart';
import 'canvas.dart';

class Ui extends StatefulWidget {
  const Ui({Key? key}) : super(key: key);

  @override
  State<Ui> createState() => _UiState();
}

class _UiState extends State<Ui> {
  double moveDy = 1;
  double moveDx = 1;
  int indexRectangle = 0;
  int indexCircle = 0;
  bool selectFigure = true;

 /* List<Rect> rectangles = <Rectangle>[
    Rectangle(600, 350, const Offset(1, 1)),
    Rectangle(700, 300, const Offset(10, 10)),
    Rectangle(650, 400, const Offset(5, 5))
  ];
  List<Circle> circles = <Circle>[
    Circle(radius: 25, center: const Offset(100, 100)),
    Circle(radius: 70, center: const Offset(115, 110)),
    Circle(radius: 50, center: const Offset(500, 150)),
    Circle(radius: 100, center: const Offset(200, 400))
  ];*/

  bool valueS = false;
  final controllerIdFigure = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ///Колонка с канвасам и регулировка размера
        upColumn(),
        /// Колонка с настройками
        //downColumn()
      ],
    );
  }


  Widget upColumn(){
    return Column(
      children: [
        Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  width: 800,
                  height: 500,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.blueAccent)
                  ),
                  child: CanvasWidget(

                  )
              ),
              RotatedBox(
                quarterTurns: 1,
                child: SizedBox(
                  width: 500,
                  child: Slider(
                    label: "Select Age",
                    value: 1/*selectFigure ? rectangles[indexRectangle].start!.dy : circles[indexCircle].center!.dy*/,
                    onChanged: (value) {
                      setState(() {
                        /*if(selectFigure){
                          rectangles[indexRectangle].start = Offset(rectangles[indexRectangle].start!.dx, value);
                        }else{
                          circles[indexCircle].center = Offset(circles[indexCircle].center!.dx, value);
                        }*/
                      });
                    },
                    min: 1,
                    max: 448,
                  ),
                ),
              ),

              const SizedBox(
                width: 16,
              ),

              RotatedBox(
                quarterTurns: 1,
                child: SizedBox(
                  width: 500,
                  child: Slider(
                    label: "Select Age",
                    activeColor: Colors.red,
                    thumbColor: Colors.red,
                    value: 1,/*selectFigure ? rectangles[indexRectangle].height!.toDouble() : circles[indexCircle].radius!.toDouble(),*/
                    onChanged: (value) {
                      /*setState(() {
                        if(selectFigure){
                          rectangles[indexRectangle].height = value.toInt();
                        }else{
                          circles[indexCircle].radius = value.toInt();
                        }
                      });*/
                    },
                    min: 1,
                    max: 400,
                  ),
                ),
              ),
            ]
        ),

        SizedBox(
          width: 800,
          child: Slider(
            label: "Select Age",
            value: 1,/*selectFigure ? rectangles[indexRectangle].start!.dx : circles[indexCircle].center!.dx,*/
            onChanged: (value) {
              /*setState(() {
                setState(() {
                  if(selectFigure){
                    rectangles[indexRectangle].start = Offset(value, rectangles[indexRectangle].start!.dy);
                  }else{
                    circles[indexCircle].center = Offset(value, circles[indexCircle].center!.dy);
                  }
                });
              });*/
            },
            min: 1,
            max: 748,
          ),
        ),

        const SizedBox(
          height: 16,
        ),

        SizedBox(
          width: 800,
          child: Slider(
            label: "Select Age",
            activeColor: Colors.red,
            thumbColor: Colors.red,
            value: 1,/*selectFigure ? rectangles[indexRectangle].width!.toDouble() : circles[indexCircle].radius!.toDouble(),*/
            onChanged: (value) {
              /*setState(() {
                setState(() {
                  if(selectFigure){
                    rectangles[indexRectangle].width = value.toInt();
                  }else{
                    circles[indexCircle].radius = value.toInt();
                  }
                });
              });*/
            },
            min: 1,
            max: 800,
          ),
        ),


        const SizedBox(
          height: 16,
        ),


        TextField(
            controller: controllerIdFigure,
            decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: "ID фигуры",
                fillColor: Colors.black12,
                filled: true
            )
        ),

        const SizedBox(
          height: 16,
        ),

        ElevatedButton(
          child: const Text(
            'OK',
          ),
          onPressed: () {
            setState(() {
              switch(controllerIdFigure.text){
                case "0":
                  selectFigure = true;
                  indexRectangle = 0;
                  break;
                case "1":
                  selectFigure = true;
                  indexRectangle = 1;
                  break;
                case "2":
                  selectFigure = true;
                  indexRectangle = 2;
                  break;
                case "3":
                  selectFigure = false;
                  indexCircle = 0;
                  break;
                case "4":
                  selectFigure = false;
                  indexCircle = 1;
                  break;
                case "5":
                  selectFigure = false;
                  indexCircle = 2;
                  break;
                case "6":
                  selectFigure = false;
                  indexCircle = 3;
                  break;
              }
            });
          },
        ),

        const SizedBox(
          height: 16,
        ),

        Container(
          height: 4,
          color: Colors.black,
        ),

        const SizedBox(
          height: 16,
        ),
      ],
    );
  }

  Widget  downColumn(){
    return Column(
      children: [
        Row(
          children: <Widget>[
            Checkbox(
              value: valueS,
              onChanged: (bool? value) {
                setState(() {
                  valueS = value!;
                });
              },
            ),
            const SizedBox(
              width: 10,
            ), //SizedBox
            const Text(
              '1 - Прямоугольник',
              style: TextStyle(fontSize: 17.0),
            ), //Text
            const SizedBox(width: 10), //SizedBox
            Checkbox(
              value: valueS,
              onChanged: (bool? value) {
                setState(() {
                  valueS = value!;
                });
              },
            ),

            ///

            const SizedBox(
              width: 10,
            ), //SizedBox
            const Text(
              '2 - Прямоугольник',
              style: TextStyle(fontSize: 17.0),
            ), //Text
            const SizedBox(width: 10), //SizedBox
            Checkbox(
              value: valueS,
              onChanged: (bool? value) {
                setState(() {
                  valueS = value!;
                });
              },
            ),

            ///

            const SizedBox(
              width: 10,
            ),
            const Text(
              '3 - Прямоугольник',
              style: TextStyle(fontSize: 17.0),
            ),
          ],
        ),
        const SizedBox(width: 10),
        Row(
          children: <Widget>[
            Checkbox(
              value: valueS,
              onChanged: (bool? value) {
                setState(() {
                  valueS = value!;
                });
              },
            ),
            const SizedBox(
              width: 10,
            ), //SizedBox
            const Text(
              '1 - Прямоугольник',
              style: TextStyle(fontSize: 17.0),
            ), //Text
            const SizedBox(width: 10), //SizedBox
            Checkbox(
              value: valueS,
              onChanged: (bool? value) {
                setState(() {
                  valueS = value!;
                });
              },
            ),

            ///

            const SizedBox(
              width: 10,
            ), //SizedBox
            const Text(
              '2 - Прямоугольник',
              style: TextStyle(fontSize: 17.0),
            ), //Text
            const SizedBox(width: 10), //SizedBox
            Checkbox(
              value: valueS,
              onChanged: (bool? value) {
                setState(() {
                  valueS = value!;
                });
              },
            ),

            ///

            const SizedBox(
              width: 10,
            ), //SizedBox
            const Text(
              '2 - Прямоугольник',
              style: TextStyle(fontSize: 17.0),
            ), //Text
            const SizedBox(width: 10), //SizedBox
            Checkbox(
              value: valueS,
              onChanged: (bool? value) {
                setState(() {
                  valueS = value!;
                });
              },
            ),

            ///

            const SizedBox(
              width: 10,
            ),
            const Text(
              '3 - Прямоугольник',
              style: TextStyle(fontSize: 17.0),
            ),
          ],
        ),

        const TextField(decoration: InputDecoration(
            border: InputBorder.none,
            hintText: "Размер",
            fillColor: Colors.black12,
            filled: true
        )),

        const SizedBox(
          height: 10,
        ),

        const TextField(decoration: InputDecoration(
            border: InputBorder.none,
            hintText: "Размер",
            fillColor: Colors.black12,
            filled: true
        )),

        const SizedBox(
          height: 10,
        ),

        ElevatedButton(
          child: const Text(
            'OK',
          ),
          onPressed: () {

          },
        ),
      ],
    );
  }
}
