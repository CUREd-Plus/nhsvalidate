# NHS Validate

Work to validate data received from NHS Digital and YAS.

## XML Schema

The [NHS Data Model and
Dictionary](https://www.datadictionary.nhs.uk/supporting_information/xml_schema_trud_download.html) provides XML Schema
 for download. Registration is required and you must subscribe to each Schema to be able to download the files.

Files are downloaded to `data/xml/` and the SHA-256 listed on each page is checked.

+ [All Items](https://isd.digital.nhs.uk/trud/users/authenticated/filters/0/categories/1)


| Schema                                                                                                                                                                    | Description                                                                                                                             | File                                             | Version |
|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------|-----------------------------------------------------------------------------------------------------------------------------------------|--------------------------------------------------|---------|
| [Emergency Care Data Set XML Scehma version 4](https://isd.digital.nhs.uk/trud/users/authenticated/filters/0/categories/36/items/1819/releases)                           | The Emergency Care Data Set (ECDS) collects information about why people attend Emergency Care Services and the treatment they receive. | `ecds_4_20230222000001.zip`                      | 4       |
| [NHS ICD-10 5th Edition XML data files](https://isd.digital.nhs.uk/trud/users/authenticated/filters/0/categories/1/items/259/subscription/request/confirmation)           |                                                                                                                                         |                                                  |         |
| [NHS National Laboratory Medicine Catalogue](https://isd.digital.nhs.uk/trud/users/authenticated/filters/0/categories/1/items/77/releases)                                | A catalogue of SNOMED CT coded laboratory medicine test requests intended for use by Pathology services and their users across the NHS  | `nhs_nlmc_5.1.0_20151103000001.zip`              | 5.1.0   |
| [Mental Health Services Data Set Commissioner extract XML Schemas - TRUD](https://isd.digital.nhs.uk/trud/users/authenticated/filters/0/categories/1/items/1779/releases) | File structure for the outgoing Commissioner extract for the Mental Health Services Data Set (MHSDS).                                   | `MHSDS_CommissioningExtract_V5_0_42_FinalV1.zip` | 5.0.42  |

Each of the above contains `.xls` or `.pdf` release notes which I would expect to provide human readable overview of the
schema (i.e. data dictionaries).

## Data Dictionaries

There are a number of data dictionaries provided, these can be found at
`/xdrive/ScHARR/PR_ARC_UEC/General/CUREd-plus/Data\ Management/Data\ dictionaries\ and\ TOS/`. There are the following
files which were obtained from https://digital.nhs.uk/

| File                 | Source |
|----------------------|--------|
| `TOS ECDS v4.0.xlsx` | [link](https://digital.nhs.uk/data-and-information/information-standards/information-standards-and-data-collections-including-extractions/publications-and-notifications/standards-and-collections/dapb0092-2062-commissioning-data-sets-emergency-care-data-set)       |
| `TOS HES APC, OP, AE, CC, DR v1.11.xlsx` | [link](https://digital.nhs.uk/data-and-information/data-tools-and-services/data-services/hospital-episode-statistics/hospital-episode-statistics-data-dictionary) |
| `TOS MHSDS v5.0.xlsx` | [link](https://digital.nhs.uk/data-and-information/data-collections-and-data-sets/data-sets/mental-health-services-data-set/tools-and-guidance) |
| `primcare_meds_reference-data_24-03-2021.xlsx` | [link](https://digital.nhs.uk/data-and-information/data-collections-and-data-sets/data-sets/mental-health-services-data-set/tools-and-guidance) |
| `Proposed YAS CURED_plus data items-2022-10-06.xlsx` | NA |

It would be reasonable to expect the above data dictionaries to align with the XML Schemas noted above in some manner
(although [TRUD](https://isd.digital.nhs.uk/trud/users/authenticated/filters/0/categories/1) does not appear to have a
Hospital Episodes Statistics XML Schema available).

### 2023-07-27 Data Dictionary v Schema

#### `TOS ECDS v4.0.xlsx`

The `TOS ECDS v4.0.xlsx` data dictionary contains a number of worksheets (XX in total), these detail data fields and
their types and I would therefore expect them to align with the [Emergency Care Data Set XML Scehma version
4](https://isd.digital.nhs.uk/trud/users/authenticated/filters/0/categories/36/items/1819/releases)
(`ecds_4_20230222000001.zip`). There are five XML files within this zip (they extract to the `ecdsxml` sub-directory),
the number of rows in each are shown below.

``` bash
wc -l * | sort -n
    41 CDS-XML_Standard_Data_Structures-V4-0.xsd
    53 CDS-XML_Message_Root-V4-0.xsd
   167 CDS_000_Message_Headers_And_Trailers-V4-0.xsd
   544 CDS_011_Emergency_Care-V4-0.xsd
  2279 CDS-XML_Standard_Data_Elements-V4-0.xsd
  3084 total
```

In order to check the XLS data dictionary against the XML Schema the script `checks.sh` was written. Its output has been
co-erced into the following table.

| **XML SCHEMA ELEMENT**                                                    | **MATCHES**                               | **FILE**                                        |
|---------------------------------------------------------------------------|-------------------------------------------|-------------------------------------------------|
| `NHSNumber`                                                               | 16                                        | `CDS_011_Emergency_Care-V4-0.xsd`               |
|                                                                           | 4                                         | `CDS-XML_Standard_Data_Elements-V4-0.xsd`       |
| `NHSNumberStatusIndicatorCode`                                            | 12                                        | `CDS_011_Emergency_Care-V4-0.xsd`               |
|                                                                           | 3                                         | `CDS-XML_Standard_Data_Elements-V4-0.xsd`       |
| `PostcodeOfUsualAddress`                                                  | 4                                         | `CDS_011_Emergency_Care-V4-0.xsd`               |
|                                                                           | 1                                         | `CDS-XML_Standard_Data_Elements-V4-0.xsd`       |
| `OrganisationIdentifier_ResidenceResponsibility`                          | 3                                         | `CDS_011_Emergency_Care-V4-0.xsd`               |
| `PersonBirthDate`                                                         | 4                                         | `CDS_011_Emergency_Care-V4-0.xsd`               |
|                                                                           | 2                                         | `CDS-XML_Standard_Data_Elements-V4-0.xsd`       |
| `PreferredSpokenLanguage_SnomedCt`                                        | 1                                         | `CDS_011_Emergency_Care-V4-0.xsd`               |
| `AccessibleInformationProfessionalRequiredCode_SnomedCt`                  | 1                                         | `CDS_011_Emergency_Care-V4-0.xsd`               |
| `InterpreterLanguage_SnomedCt`                                            | 1                                         | `CDS_011_Emergency_Care-V4-0.xsd`               |
| `OverseasVisitorChargingCategoryAtCDSActivityDate`                        | 1                                         | `CDS_011_Emergency_Care-V4-0.xsd`               |
| `SocPer_SnomedCt`                                                         | 1                                         | `CDS_011_Emergency_Care-V4-0.xsd`               |
| `SocPerRecordedTimestamp`                                                 | 1                                         | `CDS_011_Emergency_Care-V4-0.xsd`               |
| `MentalHealthActLegalStatusClassificationAssignmentPeriodStartTimestamp`  | 1                                         | `CDS_011_Emergency_Care-V4-0.xsd`               |
| `MentalHealthActLegalStatusClassificationExpiryTimestamp`                 | 1                                         | `CDS_011_Emergency_Care-V4-0.xsd`               |
| `MentalHealthActLegalStatusClassificationCode`                            | 1                                         | `CDS_011_Emergency_Care-V4-0.xsd`               |
|                                                                           | 5                                         | `CDS-XML_Standard_Data_Elements-V4-0.xsd`       |
| `GeneralMedicalPractitioner_Specified`                                    | 1                                         | `CDS-XML_Standard_Data_Elements-V4-0.xsd`       |
|                                                                           | 2                                         | `CDS-XML_Standard_Data_Structures-V4-0.xsd`     |
| `GeneralMedicalPractice_PatientRegistration`                              | 1                                         | `CDS-XML_Standard_Data_Structures-V4-0.xsd`     |
| `OrganisationSiteIdentifier_OfTreatment`                                  | 1                                         | `CDS_011_Emergency_Care-V4-0.xsd`               |
| `UrgentAndEmergencyCareActivityType`                                      | 1                                         | `CDS_011_Emergency_Care-V4-0.xsd`               |
| `AmbulanceCallIdentifier`                                                 | 1                                         | `CDS_011_Emergency_Care-V4-0.xsd`               |
| `OrganisationIdentifier_ConveyingAmbulanceTrust`                          | 1                                         | `CDS_011_Emergency_Care-V4-0.xsd`               |
| `CareContactIdentifier_AmbulanceService`                                  | 1                                         | `CDS_011_Emergency_Care-V4-0.xsd`               |
| `EmergencyCareExpectedDateAndTimestampOfTreatment`                        | 1                                         | `CDS_011_Emergency_Care-V4-0.xsd`               |
| `EmergencyCareTreatmentAllocationTimestamp`                               | 1                                         | `CDS_011_Emergency_Care-V4-0.xsd`               |
| `UrgentAndEmergencyCareActivityIdentifier`                                | 1                                         | `CDS_011_Emergency_Care-V4-0.xsd`               |
| `ConsultationMechanism_UrgentAndEmergencyCare`                            | 1                                         | `CDS_011_Emergency_Care-V4-0.xsd`               |
| `UrgentAndEmergencyCareArrivalMode_SnomedCt`                              | 1                                         | `CDS_011_Emergency_Care-V4-0.xsd`               |
| `UrgentAndEmergencyCareAttendanceCategory`                                | 1                                         | `CDS_011_Emergency_Care-V4-0.xsd`               |
| `UrgentAndEmergencyCareAttendanceSource_SnomedCt`                         | 1                                         | `CDS_011_Emergency_Care-V4-0.xsd`               |
| `OrganisationSiteIdentifier_UrgentAndEmergencyCareAttendanceSource`       | 1                                         | `CDS_011_Emergency_Care-V4-0.xsd`               |
| `UrgentAndEmergencyCareActivityStartDateAndTime`                          | 1                                         | `CDS_011_Emergency_Care-V4-0.xsd`               |
| `AgeAtCDSActivityDate`                                                    | 1                                         | `CDS_011_Emergency_Care-V4-0.xsd`               |
|                                                                           | 1                                         | `CDS-XML_Standard_Data_Elements-V4-0.xsd`       |
| `UrgentAndEmergencyCareInitialAssessmentTimestamp`                        | 1                                         | `CDS_011_Emergency_Care-V4-0.xsd`               |
| `UrgentAndEmergencyCareAcuity_SnomedCt`                                   | 1                                         | `CDS_011_Emergency_Care-V4-0.xsd`               |
| `UrgentAndEmergencyCareChiefComplaint_SnomedCt`                           | 1                                         | `CDS_011_Emergency_Care-V4-0.xsd`               |
| `UrgentAndEmergencyCareTimestampSeenForTreatment`                         | 1                                         | `CDS_011_Emergency_Care-V4-0.xsd`               |
| `UrgentAndEmergencyCareExtendedCareEpisodeIdentifier`                     | 1                                         | `CDS_011_Emergency_Care-V4-0.xsd`               |
| `CodedAssessmentToolType_SnomedCt`                                        | 1                                         | `CDS_011_Emergency_Care-V4-0.xsd`               |
| `PersonScore`                                                             | 1                                         | `CDS_011_Emergency_Care-V4-0.xsd`               |
| `AssessmentToolValidationTimestamp`                                       | 1                                         | `CDS_011_Emergency_Care-V4-0.xsd`               |
| `CodedObservation_SnomedCt`                                               | 1                                         | `CDS_011_Emergency_Care-V4-0.xsd`               |
| `ObservationValue`                                                        | 1                                         | `CDS_011_Emergency_Care-V4-0.xsd`               |
| `UnitOfMeasurement_UCUM`                                                  | 1                                         | `CDS_011_Emergency_Care-V4-0.xsd`               |
| `CodedObservationTimestamp`                                               | 1                                         | `CDS_011_Emergency_Care-V4-0.xsd`               |
| `CodedFinding_SnomedCt`                                                   | 1                                         | `CDS_011_Emergency_Care-V4-0.xsd`               |
| `CodedFindingTimestamp`                                                   | 1                                         | `CDS_011_Emergency_Care-V4-0.xsd`               |
| `InjuryDateAndTime`                                                       | 1                                         | `CDS_011_Emergency_Care-V4-0.xsd`               |
| `EmergencyCarePlaceOfInjury_SnomedCt`                                     | 1                                         | `CDS_011_Emergency_Care-V4-0.xsd`               |
| `EmergencyCarePlaceOfInjury_Latitude`                                     | 2                                         | `CDS_011_Emergency_Care-V4-0.xsd`               |
| `EmergencyCarePlaceOfInjury_Longitude`                                    | 1                                         | `CDS_011_Emergency_Care-V4-0.xsd`               |
| `EmergencyCareInjuryIntent_SnomedCt`                                      | 1                                         | `CDS_011_Emergency_Care-V4-0.xsd`               |
| `EmergencyCareInjuryActivityStatus_SnomedCt`                              | 1                                         | `CDS_011_Emergency_Care-V4-0.xsd`               |
| `EmergencyCareInjuryActivityType_SnomedCt`                                | 1                                         | `CDS_011_Emergency_Care-V4-0.xsd`               |
| `EmergencyCareInjuryMechanism_SnomedCt`                                   | 1                                         | `CDS_011_Emergency_Care-V4-0.xsd`               |
| `EmergencyCareInjuryAlcoholOrDrugInvolvement_SnomedCt`                    | 1                                         | `CDS_011_Emergency_Care-V4-0.xsd`               |
| `AssaultLocationDescription`                                              | 1                                         | `CDS_011_Emergency_Care-V4-0.xsd`               |
| `Comorbidity_SnomedCt`                                                    | 1                                         | `CDS_011_Emergency_Care-V4-0.xsd`               |
| `OrganisationIdentifier_CodeOfProvider`                                   | 1                                         | `CDS_011_Emergency_Care-V4-0.xsd`               |
| `OrganisationIdentifier_CodeOfCommissioner`                               | 1                                         | `CDS_011_Emergency_Care-V4-0.xsd`               |
| `StartDate_CommissionerAssignmentPeriod`                                  | 1                                         | `CDS_011_Emergency_Care-V4-0.xsd`               |
| `EndDate_CommissionerAssignmentPeriod`                                    | 1                                         | `CDS_011_Emergency_Care-V4-0.xsd`               |
| `NHSServiceAgreementIdentifier`                                           | 2                                         | `CDS_011_Emergency_Care-V4-0.xsd`               |
|                                                                           | 1                                         | `CDS-XML_Standard_Data_Elements-V4-0.xsd`       |
| `NHSServiceAgreementLineIdentifier`                                       | 2                                         | `CDS_011_Emergency_Care-V4-0.xsd`               |
|                                                                           | 1                                         | `CDS-XML_Standard_Data_Elements-V4-0.xsd`       |
| `ProviderReferenceIdentifier`                                             | 2                                         | `CDS_011_Emergency_Care-V4-0.xsd`               |
|                                                                           | 1                                         | `CDS-XML_Standard_Data_Elements-V4-0.xsd`       |
| `CommissionerReferenceIdentifier`                                         | 2                                         | `CDS_011_Emergency_Care-V4-0.xsd`               |
|                                                                           | 1                                         | `CDS-XML_Standard_Data_Elements-V4-0.xsd`       |
| `ServiceCode`                                                             | 1                                         | `CDS_011_Emergency_Care-V4-0.xsd`               |
| `ProfessionalRegistrationIssuerCode`                                      |                                           |                                                 |
| `ProfessionalRegistrationEntryIdentifier`                                 |                                           |                                                 |
| `CareProfessionalTier_UrgentAndEmergencyCare`                             |                                           |                                                 |
| `CareProfessionalDischargeResponsibilityIndicator_UrgentAndEmergencyCare` |                                           |                                                 |
| `CareProfessionalClinicalResponsibilityTimestamp`                         | 7                                         | `CDS_011_Emergency_Care-V4-0.xsd`               |
|                                                                           | 2                                         | `CDS-XML_Standard_Data_Elements-V4-0.xsd`       |
| `UrgentAndEmergencyCareDiagnosis_SnomedCt`                                | 1                                         | `CDS_011_Emergency_Care-V4-0.xsd`               |
| `CodedClinicalEntrySequenceNumber`                                        | 1                                         | `CDS_011_Emergency_Care-V4-0.xsd`               |
| `UrgentAndEmergencyCareDiagnosisQualifier_SnomedCt`                       | 1                                         | `CDS_011_Emergency_Care-V4-0.xsd`               |
| `UrgentAndEmergencyCareClinicalInvestigation_SnomedCt`                    | 1                                         | `CDS_011_Emergency_Care-V4-0.xsd`               |
| `CodedProcedureTimestamp_UrgentAndEmergencyCareClinicalInvestigation`     | 1                                         | `CDS_011_Emergency_Care-V4-0.xsd`               |
| `UrgentAndEmergencyCareProcedure_SnomedCt`                                | 1                                         | `CDS_011_Emergency_Care-V4-0.xsd`               |
| `CodedProcedureTimestamp_UrgentAndEmergencyCareProcedure`                 | 1                                         | `CDS_011_Emergency_Care-V4-0.xsd`               |
| `ReferredToService_SnomedCt`                                              | 1                                         | `CDS_011_Emergency_Care-V4-0.xsd`               |
| `ActivityServiceRequestTimestamp_UrgentAndEmergencyCare`                  | 1                                         | `CDS_011_Emergency_Care-V4-0.xsd`               |
| `ReferredToServiceAssessmentTimestamp`                                    | 1                                         | `CDS_011_Emergency_Care-V4-0.xsd`               |
| `FitNoteAssessmentDate`                                                   | 1                                         | `CDS_011_Emergency_Care-V4-0.xsd`               |
| `FitNoteCondition_SnomedCt`                                               | 1                                         | `CDS_011_Emergency_Care-V4-0.xsd`               |
| `FitNoteDiagnosis_ICD`                                                    | 1                                         | `CDS_011_Emergency_Care-V4-0.xsd`               |
| `FitNoteStartDate`                                                        | 1                                         | `CDS_011_Emergency_Care-V4-0.xsd`               |
| `FitNoteEndDate`                                                          | 1                                         | `CDS_011_Emergency_Care-V4-0.xsd`               |
| `FitNoteDuration`                                                         | 1                                         | `CDS_011_Emergency_Care-V4-0.xsd`               |
| `FitNoteRecordedDate`                                                     | 1                                         | `CDS_011_Emergency_Care-V4-0.xsd`               |
| `FitNoteFollowUpIndicator`                                                | 1                                         | `CDS_011_Emergency_Care-V4-0.xsd`               |
| `FitNoteIssuer`                                                           | 3                                         | `CDS_011_Emergency_Care-V4-0.xsd`               |
| `DecidedToAdmitDateAndTime`                                               | 1                                         | `CDS_011_Emergency_Care-V4-0.xsd`               |
| `ActivityTreatmentFunctionCode_DecisionToAdmit`                           | 1                                         | `CDS_011_Emergency_Care-V4-0.xsd`               |
| `UrgentAndEmergencyCareClinicallyReadyToProceedTimestamp`                 | 1                                         | `CDS_011_Emergency_Care-V4-0.xsd`               |
| `UrgentAndEmergencyCareDischargeStatus_SnomedCt`                          | 1                                         | `CDS_011_Emergency_Care-V4-0.xsd`               |
| `UrgentAndEmergencyCareActivityEndTimestamp`                              | 1                                         | `CDS_011_Emergency_Care-V4-0.xsd`               |
| `SafeguardingConcern_SnomedCt`                                            | 1                                         | `CDS_011_Emergency_Care-V4-0.xsd`               |
| `UrgentAndEmergencyCareDischargeDestination_SnomedCt`                     | 1                                         | `CDS_011_Emergency_Care-V4-0.xsd`               |
| `OrganisationSiteIdentifier_DischargeFromUrgentAndEmergencyCare`          | 1                                         | `CDS_011_Emergency_Care-V4-0.xsd`               |
| `UrgentAndEmergencyCareDischargeFollowUp_SnomedCt`                        | 1                                         | `CDS_011_Emergency_Care-V4-0.xsd`               |
| `UrgentAndEmergencyCareDischargeInformationGivenIndicator`                | 1                                         | `CDS_011_Emergency_Care-V4-0.xsd`               |
| `ClinicalTrialIdentifier`                                                 | 1                                         | `CDS_011_Emergency_Care-V4-0.xsd`               |
| `DiseaseOutbreakNotificationDescription`                                  | 1                                         | `CDS_011_Emergency_Care-V4-0.xsd`               |
| `DiseaseOutbreakNotification_SnomedCt`                                    | 1                                         | `CDS_011_Emergency_Care-V4-0.xsd`               |
| `NHSNumberStatusIndicatorCode`                                            | 12                                        | `CDS_011_Emergency_Care-V4-0.xsd`               |
|                                                                           | 3                                         | `CDS-XML_Standard_Data_Elements-V4-0.xsd`       |
| `OrganisationIdentifier_ResidenceResponsibility`                          | 3                                         | `CDS_011_Emergency_Care-V4-0.xsd`               |
| `WithheldIdentityReason`                                                  | 2                                         | `CDS_011_Emergency_Care-V4-0.xsd`               |
|                                                                           | 1                                         | `CDS-XML_Standard_Data_Elements-V4-0.xsd`       |
| `CDSInterchangeSenderIdentity`                                            |                                           |                                                 |
| `CDSInterchangeReceiverIdentity`                                          |                                           |                                                 |
| `CDSInterchangeControlReference`                                          |                                           |                                                 |
| `CDSInterchangeDateOfPreparation`                                         |                                           |                                                 |
| `CDSInterchangeTimeOfPreparation`                                         |                                           |                                                 |
| `CDSInterchangeApplicationReference`                                      |                                           |                                                 |
| `CDSInterchangeTestIndicator`                                             | 20                                        | `CDS_000_Message_Headers_And_Trailers-V4-0.xsd` |
|                                                                           | 7                                         | `CDS-XML_Standard_Data_Elements-V4-0.xsd`       |
| `CDSInterchangeControlReference`                                          | 4                                         | `CDS_000_Message_Headers_And_Trailers-V4-0.xsd` |
| 1                                                                         | `CDS-XML_Standard_Data_Elements-V4-0.xsd` |                                                 |
| `CDSInterchangeControlCount`                                              | 2                                         | `CDS_000_Message_Headers_And_Trailers-V4-0.xsd` |
|                                                                           | 1                                         | `CDS-XML_Standard_Data_Elements-V4-0.xsd`       |
| `CDSInterchangeSenderIdentity`                                            | 4                                         | `CDS_000_Message_Headers_And_Trailers-V4-0.xsd` |
|                                                                           | 1                                         | `CDS-XML_Standard_Data_Elements-V4-0.xsd`       |
| `CDSInterchangeReceiverIdentity`                                          | 4                                         | `CDS_000_Message_Headers_And_Trailers-V4-0.xsd` |
|                                                                           | 1                                         | `CDS-XML_Standard_Data_Elements-V4-0.xsd`       |
| `CDSMessageType`                                                          | 2                                         | `CDS_000_Message_Headers_And_Trailers-V4-0.xsd` |
|                                                                           | 1                                         | `CDS-XML_Standard_Data_Elements-V4-0.xsd`       |
| `CDSMessageVersionNumber`                                                 | 2                                         | `CDS_000_Message_Headers_And_Trailers-V4-0.xsd` |
|                                                                           | 1                                         | `CDS-XML_Standard_Data_Elements-V4-0.xsd`       |
| `CDSMessageReferenceNumber`                                               | 4                                         | `CDS_000_Message_Headers_And_Trailers-V4-0.xsd` |
|                                                                           | 1                                         | `CDS-XML_Standard_Data_Elements-V4-0.xsd`       |
| `CDSMessageRecordIdentifier`                                              | 2                                         | `CDS_000_Message_Headers_And_Trailers-V4-0.xsd` |
|                                                                           | 1                                         | `CDS-XML_Standard_Data_Elements-V4-0.xsd`       |
| `CDSMessageReferenceNumber`                                               | 4                                         | `CDS_000_Message_Headers_And_Trailers-V4-0.xsd` |
|                                                                           | 1                                         | `CDS-XML_Standard_Data_Elements-V4-0.xsd`       |
| `CDSTypeCode`                                                             | 8                                         | `CDS_000_Message_Headers_And_Trailers-V4-0.xsd` |
|                                                                           | 1                                         | `CDS-XML_Standard_Data_Elements-V4-0.xsd`       |
| `CDSProtocolIdentifierCode`                                               | 8                                         | `CDS_000_Message_Headers_And_Trailers-V4-0.xsd` |
|                                                                           | 1                                         | `CDS-XML_Standard_Data_Elements-V4-0.xsd`       |
| `CDSUniqueIdentifier`                                                     | 4                                         | `CDS_000_Message_Headers_And_Trailers-V4-0.xsd` |
|                                                                           | 1                                         | `CDS-XML_Standard_Data_Elements-V4-0.xsd`       |
| `CDSBulkReplacementGroupCode`                                             | 6                                         | `CDS_000_Message_Headers_And_Trailers-V4-0.xsd` |
|                                                                           | 1                                         | `CDS-XML_Standard_Data_Elements-V4-0.xsd`       |
| `CDSExtractDate`                                                          | 2                                         | `CDS_000_Message_Headers_And_Trailers-V4-0.xsd` |
|                                                                           | 1                                         | `CDS-XML_Standard_Data_Elements-V4-0.xsd`       |
| `CDSExtractTime`                                                          | 2                                         | `CDS_000_Message_Headers_And_Trailers-V4-0.xsd` |
|                                                                           | 1                                         | `CDS-XML_Standard_Data_Elements-V4-0.xsd`       |
| `CDSReportPeriodStartDate`                                                | 2                                         | `CDS_000_Message_Headers_And_Trailers-V4-0.xsd` |
|                                                                           | 1                                         | `CDS-XML_Standard_Data_Elements-V4-0.xsd`       |
| `CDSReportPeriodEndDate`                                                  | 2                                         | `CDS_000_Message_Headers_And_Trailers-V4-0.xsd` |
|                                                                           | 1                                         | `CDS-XML_Standard_Data_Elements-V4-0.xsd`       |
| `CDSActivityDate`                                                         | 4                                         | `CDS_000_Message_Headers_And_Trailers-V4-0.xsd` |
|                                                                           | 2                                         | `CDS_011_Emergency_Care-V4-0.xsd`               |
|                                                                           | 3                                         | `CDS-XML_Standard_Data_Elements-V4-0.xsd`       |
| `OrganisationIdentifier_CDSSender`                                        | 2                                         | `CDS_000_Message_Headers_And_Trailers-V4-0.xsd` |
| `OrganisationIdentifier_CDSRecipient`                                     | 2                                         | `CDS_000_Message_Headers_And_Trailers-V4-0.xsd` |
| `CDSTypeCode`                                                             | 8                                         | `CDS_000_Message_Headers_And_Trailers-V4-0.xsd` |
|                                                                           | 1                                         | `CDS-XML_Standard_Data_Elements-V4-0.xsd`       |
| `CDSProtocolIdentifierCode`                                               | 8                                         | `CDS_000_Message_Headers_And_Trailers-V4-0.xsd` |
|                                                                           | 1                                         | `CDS-XML_Standard_Data_Elements-V4-0.xsd`       |
| `CDSUniqueIdentifier`                                                     | 4                                         | `CDS_000_Message_Headers_And_Trailers-V4-0.xsd` |
|                                                                           | 1                                         | `CDS-XML_Standard_Data_Elements-V4-0.xsd`       |
| `CDSUpdateType`                                                           | 2                                         | `CDS_000_Message_Headers_And_Trailers-V4-0.xsd` |
|                                                                           | 1                                         | `CDS-XML_Standard_Data_Elements-V4-0.xsd`       |
| `CDSApplicableDate`                                                       | 2                                         | `CDS_000_Message_Headers_And_Trailers-V4-0.xsd` |
|                                                                           | 1                                         | `CDS-XML_Standard_Data_Elements-V4-0.xsd`       |
| `CDSApplicableTime`                                                       | 2                                         | `CDS_000_Message_Headers_And_Trailers-V4-0.xsd` |
|                                                                           | 1                                         | `CDS-XML_Standard_Data_Elements-V4-0.xsd`       |
| `C  DSActivityDate`                                                       | 4                                         | `CDS_000_Message_Headers_And_Trailers-V4-0.xsd` |
|                                                                           | 2                                         | `CDS_011_Emergency_Care-V4-0.xsd`               |
|                                                                           | 3                                         | `CDS-XML_Standard_Data_Elements-V4-0.xsd`       |
| `OrganisationIdentifier_CDSSender`                                        | 2                                         | `CDS_000_Message_Headers_And_Trailers-V4-0.xsd` |
| `OrganisationIdentifier_CDSRecipient`                                     | 2                                         | `CDS_000_Message_Headers_And_Trailers-V4-0.xsd` |
| `NHSNumber`                                                               | 16                                        | `CDS_011_Emergency_Care-V4-0.xsd`               |
|                                                                           | 4                                         | `CDS-XML_Standard_Data_Elements-V4-0.xsd`       |
| `NHSNumberStatusIndicatorCode`                                            | 12                                        | `CDS_011_Emergency_Care-V4-0.xsd`               |
|                                                                           | 3                                         | `CDS-XML_Standard_Data_Elements-V4-0.xsd`       |
| `PostcodeOfUsualAddress`                                                  | 4                                         | `CDS_011_Emergency_Care-V4-0.xsd`               |
|                                                                           | 1                                         | `CDS-XML_Standard_Data_Elements-V4-0.xsd`       |
| `OrganisationIdentifier_ResidenceResponsibility`                          | 3                                         | `CDS_011_Emergency_Care-V4-0.xsd`               |
| `PersonBirthDate`                                                         | 4                                         | `CDS_011_Emergency_Care-V4-0.xsd`               |
|                                                                           | 2                                         | `CDS-XML_Standard_Data_Elements-V4-0.xsd`       |

## R and XML

Packages tested for working with XML data are detailed below. The article [Using xml schema and xslt in R |
R-bloggers](https://www.r-bloggers.com/2017/01/using-xml-schema-and-xslt-in-r/) may be a useful reference.

### [XMLSchema Package](https://www.omegahat.net/XMLSchema/)

This package has been removed from CRAN but is available on the [omegahat.net](https://www.omegahat.net/), you can read the
[documentation](https://rdrr.io/github/sckott/XMLSchema/).

Install with

``` R
install.packages("XMLSchema",
    repos = "http://www.omegahat.net/R", type = "source")
library(XMLSchema)


XMLSchema::readSchema()
```

### [xml2](https://www.rdocumentation.org/packages/xml2/)

High-level R package for working with HTML and XML data from R.

This may be useful if any significant manipulation of the data is required.

## Links

### Packages
### HowTos
+ [Using xml schema and xslt in R |
R-bloggers](https://www.r-bloggers.com/2017/01/using-xml-schema-and-xslt-in-r/)
