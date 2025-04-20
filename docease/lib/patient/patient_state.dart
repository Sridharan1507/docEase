import 'package:docease_1/model/auth_response.dart';
import 'package:docease_1/model/patient/patient.dart';
import 'package:equatable/equatable.dart';

abstract class PatientState extends Equatable {}

class AuthInitialState extends PatientState {
  @override
  List<Object?> get props => [];
}


class PatientRegInitilState extends PatientState {
  @override
  List<Object?> get props => [];
}

class PatientRegLoadingState extends PatientState {
  @override
  List<Object?> get props => [];
}

class PatientRegLoadedState extends PatientState {
  final List<AuthResponseData>? authResponse;

  PatientRegLoadedState(this.authResponse);

  @override
  List<Object?> get props => [authResponse];
}

class PatientRegErrorState extends PatientState {
  final String error;

  PatientRegErrorState(this.error);

  @override
  List<Object?> get props => [error];
}

class GetPatientAppoinmentLoadingState extends PatientState {
  @override
  List<Object?> get props => [];
}

class GetPatientAppoinmentLoadedState extends PatientState {
  List<GetpatientAppointmentResData>? getAppointments;

  GetPatientAppoinmentLoadedState(this.getAppointments);

  @override
  List<Object?> get props => [getAppointments];
}

class GetPatientAppoinmentErrorState extends PatientState {
  final String error;

  GetPatientAppoinmentErrorState(this.error);

  @override
  List<Object?> get props => [error];
}


class GetAllprescriptionsLoadingState extends PatientState {
  @override
  List<Object?> get props => [];
}

class GetAllprescriptionsLoadedState extends PatientState {
  List<GetAllPrescriptionsData>? getAllPrescriptions;

  GetAllprescriptionsLoadedState(this.getAllPrescriptions);

  @override
  List<Object?> get props => [getAllPrescriptions];
}

class GetAllprescriptionsErrorState extends PatientState {
  final String error;

  GetAllprescriptionsErrorState(this.error);

  @override
  List<Object?> get props => [error];
}

