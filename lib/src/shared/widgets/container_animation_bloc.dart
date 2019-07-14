import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

enum AnimationType { height, width, opacity, size }

class ContainerAnimationBloc extends BlocBase {
  final Map<AnimationType, Animation> animations;

  var selected = BehaviorSubject<AnimationType>();

  ContainerAnimationBloc(this.animations);
  Observable<AnimationType> get selectedOut => selected.stream;
  Sink<AnimationType> get selectedIn => selected.sink;


  @override
  void dispose() {
    selected.close();
    super.dispose();
  }
}
