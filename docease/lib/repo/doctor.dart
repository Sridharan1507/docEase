import 'dart:convert';
import 'dart:developer';

import 'package:docease_1/constant.dart';
import 'package:docease_1/http_service.dart';
import 'package:docease_1/model/auth_response.dart';
import 'package:docease_1/model/doctor/doctor.dart';
import 'package:docease_1/model/patient/patient.dart';
import 'package:docease_1/regenToken.dart';



class DoctorRepoClass {
  static getDocotorDetails() {
    return HttpService(
        url: Constant().getDoctors,
        parse: (response) {
          BaseResponse baseResponse = response;
           List<DoctorsDetailsResponseData>? doctorsDetailsResponse =
              (baseResponse.response as List)
                  .map((item) => DoctorsDetailsResponseData.fromJson(item))
                  .toList();
     
          log(" doc res ${jsonEncode(doctorsDetailsResponse)}");
          return doctorsDetailsResponse;
        },
        errparse: (response) {
          ErrResponse errResponse = response;

          return errResponse;
        });
  }

   static getPatientDetails() {
    return HttpService(
        url: Constant().getPatients,
        parse: (response) {
          BaseResponse baseResponse = response;
           List<DoctorsDetailsResponseData>? doctorsDetailsResponse =
              (baseResponse.response as List)
                  .map((item) => DoctorsDetailsResponseData.fromJson(item))
                  .toList();
     
          log(" doc res ${jsonEncode(doctorsDetailsResponse)}");
          return doctorsDetailsResponse;
        },
        errparse: (response) {
          ErrResponse errResponse = response;

          return errResponse;
        });
  }


static getUserDetails() {
    return HttpService(
        url: Constant().getUserDetails,
        parse: (response) {
          BaseResponse baseResponse = response;
           List<GetUserDetailsData>? userDetails =
              (baseResponse.response as List)
                  .map((item) => GetUserDetailsData.fromJson(item))
                  .toList();
     
          log(jsonEncode(userDetails));
          return userDetails;
        },
        errparse: (response) {
          ErrResponse errResponse = response;

          return errResponse;
        });
  }
 

  static scheduleAppointment(ScheduleAppointmentReq scheduleAppointmentReq) {
    return HttpService(
        url: Constant().scheduleAppointment,
        body: scheduleAppointmentReq.toJson(),
        parse: (response) {
          BaseResponse baseResponse = response;
          ScheduleAppointmentResData scheduleAppointmentResData=ScheduleAppointmentResData.fromJson(baseResponse.response);
          log("schedule app res ${jsonEncode(baseResponse.response)}");
          return scheduleAppointmentResData;
        },
        errparse: (response) {
          ErrResponse errResponse = response;

          return errResponse;
        });
  }



  static addprescriptions(AddPrescriptionRequest addPrescriptionReq) {
    return HttpService(
        url: Constant().addPrescriptions,
        body: addPrescriptionReq.toJson(),
        parse: (response) {
          BaseResponse baseResponse = response;
          AddPrescriptionResData scheduleAppointmentResData=AddPrescriptionResData.fromJson(baseResponse.response);
          log("add pres res ${jsonEncode(baseResponse.response)}");
          return scheduleAppointmentResData;
        },
        errparse: (response) {
          ErrResponse errResponse = response;

          return errResponse;
        });
  }

}



