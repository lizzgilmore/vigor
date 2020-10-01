import 'package:fhir/r4.dart';
import 'package:vigor/interfaces/i_fhir_db.dart';

Future main() async {
  await IFhirDb().save(
    Patient(
      resourceType: 'Patient',
      name: [
        HumanName(text: 'New Patient Name'),
      ],
      birthDate: Date(DateTime.now()),
    ),
  );
}
