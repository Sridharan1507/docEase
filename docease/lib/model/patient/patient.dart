
class PatientRegisterRequest {
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

  PatientRegisterRequest(
      {this.name,
      this.userName,
      this.password,
      this.gender,
      this.dob,
      this.mobileNumber,
      this.email,
      this.deviceToken,
      this.role,
      this.address});

  PatientRegisterRequest.fromJson(Map<String, dynamic> json) {
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
    return data;
  }
}

class GetpatientAppointmentRes {
  bool? status;
  String? message;
  List<GetpatientAppointmentResData>? data;

  GetpatientAppointmentRes({this.status, this.message, this.data});

  GetpatientAppointmentRes.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <GetpatientAppointmentResData>[];
      json['data'].forEach((v) {
        data!.add(new GetpatientAppointmentResData.fromJson(v));
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

class GetpatientAppointmentResData {
  String? appointmentId;
  String? patientId;
  String? doctorId;
  String? appointmentDate;
  String? status;
  String? problemDescription;
  String? createdAt;

  GetpatientAppointmentResData(
      {this.appointmentId,
      this.patientId,
      this.doctorId,
      this.appointmentDate,
      this.status,
      this.problemDescription,
      this.createdAt});

  GetpatientAppointmentResData.fromJson(Map<String, dynamic> json) {
    appointmentId = json['appointment_id'];
    patientId = json['patient_id'];
    doctorId = json['doctor_id'];
    appointmentDate = json['appointment_date'];
    status = json['status'];
    problemDescription = json['problem_description'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['appointment_id'] = this.appointmentId;
    data['patient_id'] = this.patientId;
    data['doctor_id'] = this.doctorId;
    data['appointment_date'] = this.appointmentDate;
    data['status'] = this.status;
    data['problem_description'] = this.problemDescription;
    data['created_at'] = this.createdAt;
    return data;
  }
}


class GetAllPrescriptions {
  bool? status;
  String? message;
  List<GetAllPrescriptionsData>? data;

  GetAllPrescriptions({this.status, this.message, this.data});

  GetAllPrescriptions.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <GetAllPrescriptionsData>[];
      json['data'].forEach((v) {
        data!.add(new GetAllPrescriptionsData.fromJson(v));
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

class GetAllPrescriptionsData {
  String? prescriptionId;
  String? patientId;
  String? doctorId;
  String? notes;
  String? createdAt;
  String? expiryDate;
  List<Doctor>? doctor;
  List<Patient>? patient;
  List<Medicines>? medicines;

  GetAllPrescriptionsData(
      {this.prescriptionId,
      this.patientId,
      this.doctorId,
      this.notes,
      this.createdAt,
      this.expiryDate,
      this.doctor,
      this.patient,
      this.medicines});

  GetAllPrescriptionsData.fromJson(Map<String, dynamic> json) {
    prescriptionId = json['prescription_id'];
    patientId = json['patient_id'];
    doctorId = json['doctor_id'];
    notes = json['notes'];
    createdAt = json['created_at'];
    expiryDate = json['expiry_date'];
    if (json['doctor'] != null) {
      doctor = <Doctor>[];
      json['doctor'].forEach((v) {
        doctor!.add(new Doctor.fromJson(v));
      });
    }
    if (json['patient'] != null) {
      patient = <Patient>[];
      json['patient'].forEach((v) {
        patient!.add(new Patient.fromJson(v));
      });
    }
    if (json['medicines'] != null) {
      medicines = <Medicines>[];
      json['medicines'].forEach((v) {
        medicines!.add(new Medicines.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['prescription_id'] = this.prescriptionId;
    data['patient_id'] = this.patientId;
    data['doctor_id'] = this.doctorId;
    data['notes'] = this.notes;
    data['created_at'] = this.createdAt;
    data['expiry_date'] = this.expiryDate;
    if (this.doctor != null) {
      data['doctor'] = this.doctor!.map((v) => v.toJson()).toList();
    }
    if (this.patient != null) {
      data['patient'] = this.patient!.map((v) => v.toJson()).toList();
    }
    if (this.medicines != null) {
      data['medicines'] = this.medicines!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Doctor {
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

  Doctor(
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

  Doctor.fromJson(Map<String, dynamic> json) {
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

class Patient {
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

  Patient(
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

  Patient.fromJson(Map<String, dynamic> json) {
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

class Medicines {
  String? id;
  String? prescriptionId;
  String? medicineId;
  String? dosage;
  String? tabletLimit;

  Medicines(
      {this.id,
      this.prescriptionId,
      this.medicineId,
      this.dosage,
      this.tabletLimit});

  Medicines.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    prescriptionId = json['prescription_id'];
    medicineId = json['medicine_id'];
    dosage = json['dosage'];
    tabletLimit = json['tablet_limit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['prescription_id'] = this.prescriptionId;
    data['medicine_id'] = this.medicineId;
    data['dosage'] = this.dosage;
    data['tablet_limit'] = this.tabletLimit;
    return data;
  }
}