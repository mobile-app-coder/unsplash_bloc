import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  int selectedIndex = 0;
  PageController? controller;

  HomeCubit() : super(HomeInitial());

  onPageChange(int index) {
    selectedIndex = index;
    emit(HomeInitial());
  }

  onTabChange(int index) {
    selectedIndex = index;
    controller!.animateToPage(selectedIndex,
        duration: Duration(milliseconds: 200), curve: Curves.easeIn);
    emit(HomeInitial());
  }
}
