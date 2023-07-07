class Familly {
  String? patientName;
  String? medicFileNumber;
  String? patientIDNumber;
  String? mastPtCode;

  Familly(
      {this.patientName,
      this.medicFileNumber,
      this.patientIDNumber,
      this.mastPtCode});

  Familly.fromJson(Map<String, dynamic> json) {
    patientName = json['patientName'];
    medicFileNumber = json['medicFileNumber'];
    patientIDNumber = json['patientIDNumber'];
    mastPtCode = json['mastPtCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['patientName'] = patientName;
    data['medicFileNumber'] = medicFileNumber;
    data['patientIDNumber'] = patientIDNumber;
    data['mastPtCode'] = mastPtCode;
    return data;
  }

  @override
  String toString() {
    // TODO: implement toString
    return "$patientName";
  }
}
