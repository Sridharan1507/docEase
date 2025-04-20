
import 'package:docease_1/model/auth_response.dart';
import 'package:docease_1/model/patient/patient.dart';
import 'package:docease_1/regenToken.dart';
import 'package:equatable/equatable.dart';



abstract class PatientEvent extends Equatable {}

class PatientRegEvent extends PatientEvent {
  PatientRegEvent({required this.patientRegisterRequest});

  final dynamic patientRegisterRequest;

  @override
  List<Object?> get props => [patientRegisterRequest];
}



class GetAppointmentsEvent extends PatientEvent {
  GetAppointmentsEvent();



  @override
  List<Object?> get props => [];
}

class GetAllPrescriptionsEvent extends PatientEvent {
  GetAllPrescriptionsEvent();



  @override
  List<Object?> get props => [];
}


class GetPrescriptionHTMLEvent extends PatientEvent {
  GetPrescriptionHTMLEvent();



  @override
  List<Object?> get props => [];
}