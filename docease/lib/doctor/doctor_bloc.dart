// import 'dart:math';

import 'dart:async';
import 'dart:developer';

import 'package:docease_1/auth/auth.state.dart';
import 'package:docease_1/auth/auth_event.dart';
import 'package:docease_1/doctor/doctor_event.dart';
import 'package:docease_1/doctor/doctor_state.dart';
import 'package:docease_1/http_service.dart';
import 'package:docease_1/patient/patient_event.dart';
import 'package:docease_1/patient/patient_state.dart';
import 'package:docease_1/repo/auth.dart';
import 'package:docease_1/repo/doctor.dart';
import 'package:docease_1/repo/patient.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DoctorBloc extends Bloc<DoctorEvent, DoctorState> {
  DoctorBloc() : super(DoctorInitialState()) {
    on<GetDoctorDetailsEvent>(getDoctorDetails);
    on<GetUSerDetailEvent>(getuserDetails);
    on<ScheduleAppointmentEvent>(scheduleAppointment);
    on<GetPatientsDetailsEvent>(getPatientDetails);
    on<AddPrescriptionEvent>(addPrescriptipon);
    
  }
}

void getDoctorDetails(GetDoctorDetailsEvent event, Emitter<DoctorState> emit) async {
  // try {
    emit(GetDoctorDetailsLoadingState());

    final data = await APIWeb().get(DoctorRepoClass.getDocotorDetails());

    if (data is ErrResponse) {
      log(data.toString());
      emit(GetDoctorDetailsErrorState(data.message!));
    } else {
      emit(GetDoctorDetailsLoadedState(data));
    }
  // } catch (ex) {
  //   emit(GetAuthTokenErrorState(ex.toString()));
  // }
}

void getPatientDetails(GetPatientsDetailsEvent event, Emitter<DoctorState> emit) async {
  // try {
    emit(GetDoctorDetailsLoadingState());

    final data = await APIWeb().get(DoctorRepoClass.getPatientDetails());

    if (data is ErrResponse) {
      log(data.toString());
      emit(GetDoctorDetailsErrorState(data.message!));
    } else {
      emit(GetDoctorDetailsLoadedState(data));
    }
  // } catch (ex) {
  //   emit(GetAuthTokenErrorState(ex.toString()));
  // }
}

void getuserDetails(GetUSerDetailEvent event, Emitter<DoctorState> emit) async {
  // try {
    emit(GetUserDetailsLoadingState());

    final data = await APIWeb().get(DoctorRepoClass.getUserDetails());

    if (data is ErrResponse) {
      log(data.toString());
      emit(GetUserDetailsErrorState(data.message!));
    } else {
      emit(GetUserDetailsLoadedState(data));
    }
  // } catch (ex) {
  //   emit(GetAuthTokenErrorState(ex.toString()));
  // }
}


void scheduleAppointment(ScheduleAppointmentEvent event, Emitter<DoctorState> emit) async {
  // try {
    emit(SchedleAppointmentLoadingState());

    final data = await APIWeb()
        .post(DoctorRepoClass.scheduleAppointment(event.scheduleAppointmentReq));

    if (data is ErrResponse) {
      log(data.toString());
      emit(SchedleAppointmentErrorState(data.message!));
    } else {
      emit(SchedleAppointmentLoadedState(data));
    }
  // } catch (ex) {
  //   emit(SchedleAppointmentErrorState(ex.toString()));
  // }
}

void addPrescriptipon(AddPrescriptionEvent event, Emitter<DoctorState> emit) async {
  // try {
    emit(AddprescriptionsLoadingState());

    final data = await APIWeb()
        .post(DoctorRepoClass.addprescriptions(event.addPrescriptionReq));

    if (data is ErrResponse) {
      log(data.toString());
      emit(AddprescriptionsErrorState(data.message!));
    } else {
      emit(AddprescriptionsLoadedState(data));
    }
  // } catch (ex) {
  //   emit(SchedleAppointmentErrorState(ex.toString()));
  // }
}