// import 'dart:math';

import 'dart:async';
import 'dart:developer';

import 'package:docease_1/auth/auth.state.dart';
import 'package:docease_1/auth/auth_event.dart';
import 'package:docease_1/http_service.dart';
import 'package:docease_1/repo/auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitialState()) {
    on<GetAuthTokenEvent>(getAuthToken);
     on<RegenTokenEvent>(regenToken);
  }
}

void getAuthToken(GetAuthTokenEvent event, Emitter<AuthState> emit) async {
  // try {
    emit(GetAuthTokenLoadingState());

    final data = await APIWeb().post(AuthRepoClass.loginRepo(event.authrequest));

    if (data is ErrResponse) {
      log(data.toString());
      emit(GetAuthTokenErrorState(data.message!));
    } else {
      emit(GetAuthTokenLoadedState(data));
    }
  // } catch (ex) {
  //   emit(GetAuthTokenErrorState(ex.toString()));
  // }
}



void regenToken(RegenTokenEvent event, Emitter<AuthState> emit) async {
  try {
    emit(RegenTokenLoadingState());

    final data = await APIWeb()
        .get(AuthRepoClass.regenToken(event.regenTokenRequestBody));

    if (data is ErrResponse) {
      log(data.toString());
      emit(RegenTokenErrorState(data.message!));
    } else {
      emit(RegenTokenLoadedState(data));
    }
  } catch (ex) {
    emit(RegenTokenErrorState(ex.toString()));
  }
}

