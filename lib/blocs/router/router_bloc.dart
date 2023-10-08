import 'package:NearCard/screens/app/home.dart';
import 'package:NearCard/screens/app/profile.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'router_event.dart';
part 'router_state.dart';

class RouterBloc extends Bloc<RouterEvent, RouterInitial> {
  RouterBloc() : super(RouterInitial(0)) {
    on<RouterEvent>((event, emit) {
      if (event is RouterChangePage) {
        emit(RouterInitial(event.index));
      }
    });
  }
}
