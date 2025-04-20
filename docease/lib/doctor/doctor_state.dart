import 'package:docease_1/model/auth_response.dart';
import 'package:docease_1/model/doctor/doctor.dart';
import 'package:equatable/equatable.dart';

abstract class DoctorState extends Equatable {}

class DoctorInitialState extends DoctorState {
  @override
  List<Object?> get props => [];
}


class GetDoctorDetailsInitilState extends DoctorState {
  @override
  List<Object?> get props => [];
}

class GetDoctorDetailsLoadingState extends DoctorState {
  @override
  List<Object?> get props => [];
}

class GetDoctorDetailsLoadedState extends DoctorState {
  final List<DoctorsDetailsResponseData>? authResponse;

  GetDoctorDetailsLoadedState(this.authResponse);

  @override
  List<Object?> get props => [authResponse];
}

class GetDoctorDetailsErrorState extends DoctorState {
  final String error;

  GetDoctorDetailsErrorState(this.error);

  @override
  List<Object?> get props => [error];
}


class GetPatientDetailsLoadingState extends DoctorState {
  @override
  List<Object?> get props => [];
}

class GetPatientDetailsLoadedState extends DoctorState {
  final List<DoctorsDetailsResponseData>? patientres;

  GetPatientDetailsLoadedState(this.patientres);

  @override
  List<Object?> get props => [patientres];
}

class GetPatientDetailsErrorState extends DoctorState {
  final String error;

  GetPatientDetailsErrorState(this.error);

  @override
  List<Object?> get props => [error];
}
class GetUserDetailsLoadingState extends DoctorState {
  @override
  List<Object?> get props => [];
}

class GetUserDetailsLoadedState extends DoctorState {
  final List<GetUserDetailsData>? getuserDetails;

  GetUserDetailsLoadedState(this.getuserDetails);

  @override
  List<Object?> get props => [getuserDetails];
}

class GetUserDetailsErrorState extends DoctorState {
  final String error;

  GetUserDetailsErrorState(this.error);

  @override
  List<Object?> get props => [error];
}



class SchedleAppointmentLoadingState extends DoctorState {
  @override
  List<Object?> get props => [];
}

class SchedleAppointmentLoadedState extends DoctorState {
ScheduleAppointmentResData scheduleAppointmentResData;

  SchedleAppointmentLoadedState(this.scheduleAppointmentResData);

  @override
  List<Object?> get props => [scheduleAppointmentResData];
}

class SchedleAppointmentErrorState extends DoctorState {
  final String error;

  SchedleAppointmentErrorState(this.error);

  @override
  List<Object?> get props => [error];
}


class AddprescriptionsLoadingState extends DoctorState {
  @override
  List<Object?> get props => [];
}

class AddprescriptionsLoadedState extends DoctorState {
AddPrescriptionResData addPrescriptionResData;

  AddprescriptionsLoadedState(this.addPrescriptionResData);

  @override
  List<Object?> get props => [addPrescriptionResData];
}

class AddprescriptionsErrorState extends DoctorState {
  final String error;

  AddprescriptionsErrorState(this.error);

  @override
  List<Object?> get props => [error];
}
