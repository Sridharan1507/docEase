// import 'dart:math';

import 'dart:async';
import 'dart:developer';

import 'package:docease_1/auth/auth.state.dart';
import 'package:docease_1/auth/auth_event.dart';
import 'package:docease_1/http_service.dart';
import 'package:docease_1/patient/patient_event.dart';
import 'package:docease_1/patient/patient_state.dart';
import 'package:docease_1/repo/auth.dart';
import 'package:docease_1/repo/patient.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PatientBloc extends Bloc<PatientEvent, PatientState> {
  PatientBloc() : super(PatientRegInitilState()) {
    on<PatientRegEvent>(patientRegEvent);
    on<GetAppointmentsEvent>(getAppointments);
    on<GetAllPrescriptionsEvent>(getAllPrescriptions);
  }
}

void patientRegEvent(PatientRegEvent event, Emitter<PatientState> emit) async {
  // try {
    emit(PatientRegLoadingState());

    final data = await APIWeb().post(PatientRepoClass.patientReg(event.patientRegisterRequest));

    if (data is ErrResponse) {
      log(data.toString());
      emit(PatientRegErrorState(data.message!));
    } else {
      emit(PatientRegLoadedState(data));
    }
  // } catch (ex) {
  //   emit(GetAuthTokenErrorState(ex.toString()));
  // }
}



void getAppointments(GetAppointmentsEvent event, Emitter<PatientState> emit) async {
  // try {
    emit(GetPatientAppoinmentLoadingState());

    final data = await APIWeb()
        .get(PatientRepoClass.getAppoinments());

    if (data is ErrResponse) {
      log(data.toString());
      emit(GetPatientAppoinmentErrorState(data.message!));
    } else {
      emit(GetPatientAppoinmentLoadedState(data));
    }
  // } catch (ex) {
  //   emit(RegenTokenErrorState(ex.toString()));
  // }
}

void getAllPrescriptions(GetAllPrescriptionsEvent event, Emitter<PatientState> emit) async {
  // try {
    emit(GetAllprescriptionsLoadingState());

    final data = await APIWeb()
        .get(PatientRepoClass.getAllPrescriptions());

    if (data is ErrResponse) {
      log(data.toString());
      emit(GetAllprescriptionsErrorState(data.message!));
    } else {
      emit(GetAllprescriptionsLoadedState(data));
    }
  // } catch (ex) {
  //   emit(RegenTokenErrorState(ex.toString()));
  // }
}

// void getPrescriptionsHTML(GetPrescriptionHTMLEvent event, Emitter<PatientState> emit) async {
//   // try {
//     emit(GetAllprescriptionsLoadingState());

//     final data = await APIWeb()
//         .get(PatientRepoClass.getAllPrescriptions());

//     if (data is ErrResponse) {
//       log(data.toString());
//       emit(GetAllprescriptionsErrorState(data.message!));
//     } else {
//       emit(GetAllprescriptionsLoadedState(data));
//     }
//   // } catch (ex) {
//   //   emit(RegenTokenErrorState(ex.toString()));
//   // }
// }
