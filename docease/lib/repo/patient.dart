import 'dart:convert';
import 'dart:developer';

import 'package:docease_1/constant.dart';
import 'package:docease_1/http_service.dart';
import 'package:docease_1/model/auth_response.dart';
import 'package:docease_1/model/patient/patient.dart';
import 'package:docease_1/regenToken.dart';

class PatientRepoClass {
  static patientReg(dynamic patientRegisterRequest) {
    return HttpService(
      url: Constant().patientReg,
      body: patientRegisterRequest.toJson(),
      parse: (response) {
        BaseResponse baseResponse = response;
        List<AuthResponseData>? authResponse =
            (baseResponse.response as List)
                .map((item) => AuthResponseData.fromJson(item))
                .toList();
        log(jsonEncode(authResponse));
        return authResponse;
      },
      errparse: (response) {
        ErrResponse errResponse = response;

        return errResponse;
      },
    );
  }

  static getAppoinments() {
    return HttpService(
      url: Constant().scheduleAppointment,
      parse: (response) {
        BaseResponse baseResponse = response;

        List<GetpatientAppointmentResData>? getAppointments =
            (baseResponse.response as List)
                .map((item) => GetpatientAppointmentResData.fromJson(item))
                .toList();
        log(jsonEncode(getAppointments));

        return getAppointments;
      },
      errparse: (response) {
        ErrResponse errResponse = response;

        return errResponse;
      },
    );
  }

  static getAllPrescriptions() {
    return HttpService(
      url: Constant().getAllpresctiptions,
      parse: (response) {
        BaseResponse baseResponse = response;

        List<GetAllPrescriptionsData>? getAllPrescriptions =
            (baseResponse.response as List)
                .map((item) => GetAllPrescriptionsData.fromJson(item))
                .toList();
        log(jsonEncode(getAllPrescriptions));

        return getAllPrescriptions;
      },
      errparse: (response) {
        ErrResponse errResponse = response;

        return errResponse;
      },
    );
  }
}
