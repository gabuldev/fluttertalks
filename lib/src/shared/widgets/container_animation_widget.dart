import 'package:flutter/material.dart';
import 'package:fluttertalks/src/shared/widgets/container_animation_bloc.dart';

class ContainerAnimationWidget extends StatefulWidget {
  @override
  _ContainerAnimationWidgetState createState() => _ContainerAnimationWidgetState();
}

class _ContainerAnimationWidgetState extends State<ContainerAnimationWidget> with SingleTickerProviderStateMixin{


  AnimationController controller;
  Animation height;
  Animation width;
  Animation opacity;
  Animation size;

  ContainerAnimationBloc bloc;

  @override
  void didChangeDependencies() {
      initAnimation();
      bloc = ContainerAnimationBloc({
        AnimationType.height : height,
        AnimationType.width : width,
        AnimationType.opacity : opacity,
        AnimationType.size : size
      });
    super.didChangeDependencies();
  }

  void initAnimation(){

    controller = AnimationController(vsync: this,duration: Duration(seconds: 1));
    height = Tween(begin: 500.0,end: 200.0).animate(controller);
    width = Tween(begin: 500.0,end: 200.0).animate(controller);
    opacity = Tween(begin: 0.0,end:1.0 ).animate(controller);
    size = SizeTween(begin: Size(500.0,500.0),end: Size(200.0, 200.0)).animate(controller);

  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            FlatButton(
              child: Text("Height"),
              onPressed: (){
                bloc.selectedIn.add(AnimationType.height);
              },
            ),
            FlatButton(
          child: Text("Width"),
          onPressed: (){
            bloc.selectedIn.add(AnimationType.width);
          },
        ),
        FlatButton(
          child: Text("Opacity"),
          onPressed: (){
            bloc.selectedIn.add(AnimationType.opacity);
          },
        ),
        FlatButton(
          child: Text("Size"),
          onPressed: (){
            bloc.selectedIn.add(AnimationType.size);
          },
        ),
          ],
        ),
        AnimatedBuilder(
         animation: controller,
          builder: (context, snapshot) {
            return StreamBuilder<AnimationType>(
              stream: bloc.selectedOut,
              builder: (context, snapshot) {
                if(snapshot.hasData){
                  //controller.reset();
               switch (snapshot.data) {
      case AnimationType.height:
        return Container(
          height: height.value,
          width: 500,
          color: Colors.green,
        );

      case AnimationType.width:
        return Container(
          height: 500,
          width: width.value,
          color: Colors.green,
        );

      case AnimationType.opacity:
        return Opacity(
          opacity: opacity.value,
          child: Container(
            height: 500,
            width: 500,
            color: Colors.green,
          ),
        );

        case AnimationType.size:
        return Container(
          height: size.value.height,
          width: size.value.width,
          color: Colors.green,
        );

        break;
      default:
        return Container();
    }
                }
                else
                return Container();
              }
            );
          }
        ),
      ],
    ),
    floatingActionButton: FloatingActionButton(
      onPressed: (){
        if(controller.isCompleted)
          controller.reverse();
          else if( controller.isDismissed)
          controller.forward();
      },
    ),
    );
  }
}
