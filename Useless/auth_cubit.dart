import 'dart:async';
import 'package:dhananjaya/connectivity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum AuthState { signedIn, signedOut }

class AuthCubit extends Cubit<AuthState> {
  StreamSubscription? _authSubscription;
  AuthCubit() : super(AuthState.signedOut) {
    _authSubscription = Auth.controller.stream.listen((state) {
      if (state) {
        emit(AuthState.signedIn);
      } else {
        emit(AuthState.signedOut);
      }
    });
  }
  @override
  Future<void> close() {
    _authSubscription?.cancel();
    return super.close();
  }
}
