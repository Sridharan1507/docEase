class DoctorsDetailsResponse {
  bool? status;
  String? message;
  List<DoctorsDetailsResponseData>? data;

  DoctorsDetailsResponse({this.status, this.message, this.data});

  DoctorsDetailsResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <DoctorsDetailsResponseData>[];
      json['data'].forEach((v) {
        data!.add(new DoctorsDetailsResponseData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DoctorsDetailsResponseData {
  String? id;
  String? userCode;
  String? role;
  String? name;
  String? userName;
  String? gender;
  String? dob;
  String? mobileNumber;
  String? email;
  String? createdAt;
  String? updatedAt;
  String? activeFlag;
  String? specialist;

  DoctorsDetailsResponseData(
      {this.id,
      this.userCode,
      this.role,
      this.name,
      this.userName,
      this.gender,
      this.dob,
      this.mobileNumber,
      this.email,
      this.createdAt,
      this.updatedAt,
      this.activeFlag,
      this.specialist});

  DoctorsDetailsResponseData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userCode = json['user_code'];
    role = json['role'];
    name = json['name'];
    userName = json['user_name'];
    gender = json['gender'];
    dob = json['dob'];
    mobileNumber = json['mobile_number'];
    email = json['email'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    activeFlag = json['active_flag'];
    specialist = json['specialist'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_code'] = this.userCode;
    data['role'] = this.role;
    data['name'] = this.name;
    data['user_name'] = this.userName;
    data['gender'] = this.gender;
    data['dob'] = this.dob;
    data['mobile_number'] = this.mobileNumber;
    data['email'] = this.email;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['active_flag'] = this.activeFlag;
    data['specialist'] = this.specialist;
    return data;
  }
}

class GetUserDetails {
  bool? status;
  String? message;
  List<GetUserDetailsData>? data;

  GetUserDetails({this.status, this.message, this.data});

  GetUserDetails.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <GetUserDetailsData>[];
      json['data'].forEach((v) {
        data!.add(new GetUserDetailsData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class GetUserDetailsData {
  String? id;
  String? code;
  String? name;
  String? userName;
  String? password;
  String? rOLE;
  String? email;
  String? gender;
  String? dob;
  String? mobileNumber;
  String? address;
  String? sessionToken;
  String? createdAt;
  String? updatedAt;
  String? deviceToken;
  String? activeFlag;
  String? specialist;

  GetUserDetailsData(
      {this.id,
      this.code,
      this.name,
      this.userName,
      this.password,
      this.rOLE,
      this.email,
      this.gender,
      this.dob,
      this.mobileNumber,
      this.address,
      this.sessionToken,
      this.createdAt,
      this.updatedAt,
      this.deviceToken,
      this.activeFlag,
      this.specialist});

  GetUserDetailsData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    name = json['name'];
    userName = json['user_name'];
    password = json['password'];
    rOLE = json['ROLE'];
    email = json['email'];
    gender = json['gender'];
    dob = json['dob'];
    mobileNumber = json['mobile_number'];
    address = json['address'];
    sessionToken = json['session_token'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deviceToken = json['device_token'];
    activeFlag = json['active_flag'];
    specialist = json['specialist']??"5";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['code'] = this.code;
    data['name'] = this.name;
    data['user_name'] = this.userName;
    data['password'] = this.password;
    data['ROLE'] = this.rOLE;
    data['email'] = this.email;
    data['gender'] = this.gender;
    data['dob'] = this.dob;
    data['mobile_number'] = this.mobileNumber;
    data['address'] = this.address;
    data['session_token'] = this.sessionToken;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['device_token'] = this.deviceToken;
    data['active_flag'] = this.activeFlag;
    data['specialist'] = this.specialist;
    return data;
  }
}

class ScheduleAppointmentReq {
  int? doctorId;
  String? appointmentDate;
  String? status;
  String? problemDescription;

  ScheduleAppointmentReq(
      {this.doctorId,
      this.appointmentDate,
      this.status,
      this.problemDescription});

  ScheduleAppointmentReq.fromJson(Map<String, dynamic> json) {
    doctorId = json['doctor_id'];
    appointmentDate = json['appointment_date'];
    status = json['status'];
    problemDescription = json['problem_description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['doctor_id'] = this.doctorId;
    data['appointment_date'] = this.appointmentDate;
    data['status'] = this.status;
    data['problem_description'] = this.problemDescription;
    return data;
  }
}


class ScheduleAppointmentRes {
  bool? status;
  String? message;
  ScheduleAppointmentResData? data;

  ScheduleAppointmentRes({this.status, this.message, this.data});

  ScheduleAppointmentRes.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new ScheduleAppointmentResData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class ScheduleAppointmentResData {
  String? patientId;
  int? doctorId;
  String? appointmentDate;
  String? status;
  String? problemDescription;
  String? createdAt;
  int? appointmentId;

  ScheduleAppointmentResData(
      {this.patientId,
      this.doctorId,
      this.appointmentDate,
      this.status,
      this.problemDescription,
      this.createdAt,
      this.appointmentId});

  ScheduleAppointmentResData.fromJson(Map<String, dynamic> json) {
    patientId = json['patient_id'];
    doctorId = json['doctor_id'];
    appointmentDate = json['appointment_date'];
    status = json['status'];
    problemDescription = json['problem_description'];
    createdAt = json['created_at'];
    appointmentId = json['appointment_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['patient_id'] = this.patientId;
    data['doctor_id'] = this.doctorId;
    data['appointment_date'] = this.appointmentDate;
    data['status'] = this.status;
    data['problem_description'] = this.problemDescription;
    data['created_at'] = this.createdAt;
    data['appointment_id'] = this.appointmentId;
    return data;
  }
}

class DoctorRegReq {
  String? name;
  String? userName;
  String? password;
  String? gender;
  String? dob;
  String? mobileNumber;
  String? email;
  String? deviceToken;
  String? role;
  String? address;
  int? specialist;

  DoctorRegReq(
      {this.name,
      this.userName,
      this.password,
      this.gender,
      this.dob,
      this.mobileNumber,
      this.email,
      this.deviceToken,
      this.role,
      this.address,
      this.specialist});

  DoctorRegReq.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    userName = json['user_name'];
    password = json['password'];
    gender = json['gender'];
    dob = json['dob'];
    mobileNumber = json['mobile_number'];
    email = json['email'];
    deviceToken = json['device_token'];
    role = json['role'];
    address = json['address'];
    specialist = json['specialist'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['user_name'] = this.userName;
    data['password'] = this.password;
    data['gender'] = this.gender;
    data['dob'] = this.dob;
    data['mobile_number'] = this.mobileNumber;
    data['email'] = this.email;
    data['device_token'] = this.deviceToken;
    data['role'] = this.role;
    data['address'] = this.address;
    data['specialist'] = this.specialist;
    return data;
  }
}


class AddPrescriptionRequest {
  int? patientId;
  String? notes;
  String? expiryDate;
  List<Medicines>? medicines;

  AddPrescriptionRequest(
      {this.patientId, this.notes, this.expiryDate, this.medicines});

  AddPrescriptionRequest.fromJson(Map<String, dynamic> json) {
    patientId = json['patient_id'];
    notes = json['notes'];
    expiryDate = json['expiry_date'];
    if (json['medicines'] != null) {
      medicines = <Medicines>[];
      json['medicines'].forEach((v) {
        medicines!.add(new Medicines.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['patient_id'] = this.patientId;
    data['notes'] = this.notes;
    data['expiry_date'] = this.expiryDate;
    if (this.medicines != null) {
      data['medicines'] = this.medicines!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Medicines {
  int? medicineId;
  String? dosage;
  int? tabletLimit;

  Medicines({this.medicineId, this.dosage, this.tabletLimit});

  Medicines.fromJson(Map<String, dynamic> json) {
    medicineId = json['medicine_id'];
    dosage = json['dosage'];
    tabletLimit = json['tablet_limit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['medicine_id'] = this.medicineId;
    data['dosage'] = this.dosage;
    data['tablet_limit'] = this.tabletLimit;
    return data;
  }
}


class AddPrescriptionRes {
  bool? status;
  String? message;
  AddPrescriptionResData? data;

  AddPrescriptionRes({this.status, this.message, this.data});

  AddPrescriptionRes.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new AddPrescriptionResData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class AddPrescriptionResData {
  int? patientId;
  String? notes;
  String? expiryDate;
  List<Medicines>? medicines;
  int? prescriptionId;

  AddPrescriptionResData(
      {this.patientId,
      this.notes,
      this.expiryDate,
      this.medicines,
      this.prescriptionId});

  AddPrescriptionResData.fromJson(Map<String, dynamic> json) {
    patientId = json['patient_id'];
    notes = json['notes'];
    expiryDate = json['expiry_date'];
    if (json['medicines'] != null) {
      medicines = <Medicines>[];
      json['medicines'].forEach((v) {
        medicines!.add(new Medicines.fromJson(v));
      });
    }
    prescriptionId = json['prescription_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['patient_id'] = this.patientId;
    data['notes'] = this.notes;
    data['expiry_date'] = this.expiryDate;
    if (this.medicines != null) {
      data['medicines'] = this.medicines!.map((v) => v.toJson()).toList();
    }
    data['prescription_id'] = this.prescriptionId;
    return data;
  }
}


