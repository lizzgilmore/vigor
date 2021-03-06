import 'package:fhir/r4.dart';
import 'package:get/get.dart';
import 'package:vax_cast/vax_cast.dart';
import 'package:vigor/interfaces/i_fhir_db.dart';
import 'package:vigor/interfaces/i_vax_cast.dart';

import '_internal/formatters.dart';

class PatientModel {
  PatientModel({
    this.patient,
    this.medsAdministered,
    this.pastImmunizations,
    this.immEvaluations,
    this.recommendation,
    this.pastImmMap,
  }) {
    medsAdministered ??= <MedicationAdministration>[];
    pastImmunizations ??= <Immunization>[];
    immEvaluations ??= <ImmunizationEvaluation>[];
    pastImmMap ??= <String, List<Immunization>>{};
  }

  Patient patient;
  List<MedicationAdministration> medsAdministered;
  List<Immunization> pastImmunizations;
  List<ImmunizationEvaluation> immEvaluations;
  ImmunizationRecommendation recommendation;
  Map<String, List<Immunization>> pastImmMap;

  Future loadImmunizations() async {
    final iFhirDb = IFhirDb();
    await iFhirDb
        .returnPatientImmunizationHistory(patient.id.toString())
        .then((result) {
      result.fold(
          (l) => Get.snackbar('Error', '${l.error}'),
          (r) => r.forEach(
              (resource) => pastImmunizations.add(resource as Immunization)));
    });
  }

  void createHx() {
    for (var imm in pastImmunizations) {
      final cvx = imm.vaccineCode.coding
          .firstWhere(
              (coding) =>
                  coding.system == FhirUri('http://hl7.org/fhir/sid/cvx'),
              orElse: () => null)
          ?.code
          ?.toString();
      if (cvx != null) {
        for (var ag in simpleCvxMap[cvx].antigens) {
          pastImmMap.containsKey(ag)
              ? pastImmMap[ag].add(imm)
              : pastImmMap[ag] = [imm];
        }
      }
    }
  }

  Future getImmunizationRecommendation() async {
    final returnValues = await IVaxCast.vaxCast(
        patient: patient,
        immunizations: pastImmunizations,
        assessmentDate: Date(DateTime.now().toIso8601String()));
    for (final parameter in returnValues.parameter) {
      if (parameter.name == 'evaluation') {
        immEvaluations.add(parameter.resource);
      }
      if (parameter.name == 'recommendation') {
        recommendation = parameter.resource;
      }
    }
  }

  String name() => lastCommaGivenName(patient);
  String id() => patient.id.toString();
  String sex() => basicEnumToString(patient.gender);
  String birthDate() => simpleDate(patient.birthDate);
}
