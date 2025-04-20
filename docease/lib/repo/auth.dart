import 'dart:convert';
import 'dart:developer';

import 'package:docease_1/constant.dart';
import 'package:docease_1/http_service.dart';
import 'package:docease_1/model/auth_response.dart';
import 'package:docease_1/model/patient/patient.dart';
import 'package:docease_1/regenToken.dart';



class AuthRepoClass {
  static loginRepo(AuthRequest authrequest) {
    return HttpService(
        url: Constant().getAuth,
        body: authrequest.toJson(),
        parse: (response) {
          BaseResponse baseResponse = response;
          List<AuthResponseData>? authResponse = (baseResponse.response as List)
              .map((item) => AuthResponseData.fromJson(item))
              .toList();
          log(jsonEncode(authResponse));
          return authResponse;
        },
        errparse: (response) {
          ErrResponse errResponse = response;

          return errResponse;
        });
  }

 

  static regenToken(RegenTokenRequestBody regenTokenRequestBody) {
    return HttpService(
        url: Constant().regenToken,
        body: regenTokenRequestBody.toJson(),
        parse: (response) {
          BaseResponse baseResponse = response;
        },
        errparse: (response) {
          ErrResponse errResponse = response;

          return errResponse;
        });
  }

  static patientReg(PatientRegisterRequest patientReg) {
    return HttpService(
        url: Constant().patientReg,
        body: patientReg.toJson(),
        parse: (response) {
          BaseResponse baseResponse = response;
        },
        errparse: (response) {
          ErrResponse errResponse = response;

          return errResponse;
        });
  }
}

