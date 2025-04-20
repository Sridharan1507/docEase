
import 'package:docease_1/model/auth_response.dart';
import 'package:docease_1/model/doctor/doctor.dart';
import 'package:docease_1/regenToken.dart';
import 'package:equatable/equatable.dart';



abstract class DoctorEvent extends Equatable {}

class GetDoctorDetailsEvent extends DoctorEvent {
  GetDoctorDetailsEvent();



  @override
  List<Object?> get props => [];
}


class GetPatientsDetailsEvent extends DoctorEvent {
  GetPatientsDetailsEvent();



  @override
  List<Object?> get props => [];
}
class GetUSerDetailEvent extends DoctorEvent {
  GetUSerDetailEvent();



  @override
  List<Object?> get props => [];
}


class ScheduleAppointmentEvent extends DoctorEvent {
  ScheduleAppointmentEvent(this.scheduleAppointmentReq);
final ScheduleAppointmentReq scheduleAppointmentReq;


  @override
  List<Object?> get props => [scheduleAppointmentReq];
}


class AddPrescriptionEvent extends DoctorEvent {
  AddPrescriptionEvent(this.addPrescriptionReq);
final AddPrescriptionRequest addPrescriptionReq;


  @override
  List<Object?> get props => [addPrescriptionReq];
}
