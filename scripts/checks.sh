#!/bin/bash
#
# Script to check for the presence of different terms


PATIENT_IDENTITY=("NHSNumber"
                  "NHSNumberStatusIndicatorCode"
                  "PostcodeOfUsualAddress"
                  "OrganisationIdentifier_ResidenceResponsibility"
                  "PersonBirthDate")
PATIENT_CHARATERISTICS=("PreferredSpokenLanguage_SnomedCt"
                        "AccessibleInformationProfessionalRequiredCode_SnomedCt"
                        "InterpreterLanguage_SnomedCt"
                        "OverseasVisitorChargingCategoryAtCDSActivityDate")
SOCIAL_AND_PERSONAL_CRUCMST=("SocPer_SnomedCt"
                             "SocPerRecordedTimestamp")
MENTAL_HEALTH_ACT=("MentalHealthActLegalStatusClassificationAssignmentPeriodStartTimestamp"
                   "MentalHealthActLegalStatusClassificationExpiryTimestamp"
                   "MentalHealthActLegalStatusClassificationCode")
GP_REGISTRATION=("GeneralMedicalPractitioner_Specified"
                 "GeneralMedicalPractice_PatientRegistration")
ATTENDANCE_LOCATION=("OrganisationSiteIdentifier_OfTreatment"
                     "UrgentAndEmergencyCareActivityType")
AMBULANCE_DETAILS=("AmbulanceCallIdentifier"
                   "OrganisationIdentifier_ConveyingAmbulanceTrust"
                   "CareContactIdentifier_AmbulanceService")
EXPECTED_DATE_AND_TIME_OF_TRE=("EmergencyCareExpectedDateAndTimestampOfTreatment"
                               "EmergencyCareTreatmentAllocationTimestamp")
ATTENDANCE_ACTIVITY=("UrgentAndEmergencyCareActivityIdentifier"
                     "ConsultationMechanism_UrgentAndEmergencyCare"
                     "UrgentAndEmergencyCareArrivalMode_SnomedCt"
                     "UrgentAndEmergencyCareAttendanceCategory"
                     "UrgentAndEmergencyCareAttendanceSource_SnomedCt"
                     "OrganisationSiteIdentifier_UrgentAndEmergencyCareAttendanceSource"
                     "UrgentAndEmergencyCareActivityStartDateAndTime"
                     "AgeAtCDSActivityDate"
                     "UrgentAndEmergencyCareInitialAssessmentTimestamp"
                     "UrgentAndEmergencyCareAcuity_SnomedCt"
                     "UrgentAndEmergencyCareChiefComplaint_SnomedCt"
                     "UrgentAndEmergencyCareTimestampSeenForTreatment"
                     "UrgentAndEmergencyCareExtendedCareEpisodeIdentifier")
ASSESSMENT_TOOL=("CodedAssessmentToolType_SnomedCt"
                 "PersonScore"
                 "AssessmentToolValidationTimestamp")
CODED_CLINICAL_OBSERVATIONS=("CodedObservation_SnomedCt"
                             "ObservationValue"
                             "UnitOfMeasurement_UCUM"
                             "CodedObservationTimestamp")
CODED_CLINICAL_FINDINGS=("CodedFinding_SnomedCt"
                         "CodedFindingTimestamp")
INJURY_CHARACTERISTICS=("InjuryDateAndTime"
                        "EmergencyCarePlaceOfInjury_SnomedCt"
                        "EmergencyCarePlaceOfInjury_Latitude"
                        "EmergencyCarePlaceOfInjury_Longitude"
                        "EmergencyCareInjuryIntent_SnomedCt"
                        "EmergencyCareInjuryActivityStatus_SnomedCt"
                        "EmergencyCareInjuryActivityType_SnomedCt"
                        "EmergencyCareInjuryMechanism_SnomedCt"
                        "EmergencyCareInjuryAlcoholOrDrugInvolvement_SnomedCt"
                        "AssaultLocationDescription")
PATIENT_CLINICAL_HISTORY=("Comorbidity_SnomedCt")
SERVICE_AGREEMENT_DETAILS=("OrganisationIdentifier_CodeOfProvider"
                           "OrganisationIdentifier_CodeOfCommissioner"
                           "StartDate_CommissionerAssignmentPeriod"
                           "EndDate_CommissionerAssignmentPeriod"
                           "NHSServiceAgreementIdentifier"
                           "NHSServiceAgreementLineIdentifier"
                           "ProviderReferenceIdentifier"
                           "CommissionerReferenceIdentifier"
                           "ServiceCode")
CARE_PROFESSIONALS=("ProfessionalRegistrationIssuerCode
ProfessionalRegistrationEntryIdentifier
CareProfessionalTier_UrgentAndEmergencyCare
CareProfessionalDischargeResponsibilityIndicator_UrgentAndEmergencyCare
CareProfessionalClinicalResponsibilityTimestamp")
DIAGNOSIS=("UrgentAndEmergencyCareDiagnosis_SnomedCt"
           "CodedClinicalEntrySequenceNumber"
           "UrgentAndEmergencyCareDiagnosisQualifier_SnomedCt")
INVESTIGATIONS=("UrgentAndEmergencyCareClinicalInvestigation_SnomedCt"
                "CodedProcedureTimestamp_UrgentAndEmergencyCareClinicalInvestigation")
TREATMENTS=("UrgentAndEmergencyCareProcedure_SnomedCt"
            "CodedProcedureTimestamp_UrgentAndEmergencyCareProcedure")
REFERRALS_TO_OTHER_SERVICES=("ReferredToService_SnomedCt"
                             "ActivityServiceRequestTimestamp_UrgentAndEmergencyCare"
                             "ReferredToServiceAssessmentTimestamp")
EMED3_FIT_NOTE=("FitNoteAssessmentDate"
                "FitNoteCondition_SnomedCt"
                "FitNoteDiagnosis_ICD"
                "FitNoteStartDate"
                "FitNoteEndDate"
                "FitNoteDuration"
                "FitNoteRecordedDate"
                "FitNoteFollowUpIndicator"
                "FitNoteIssuer")
DISCHARGE=("DecidedToAdmitDateAndTime"
           "ActivityTreatmentFunctionCode_DecisionToAdmit"
           "UrgentAndEmergencyCareClinicallyReadyToProceedTimestamp"
           "UrgentAndEmergencyCareDischargeStatus_SnomedCt"
           "UrgentAndEmergencyCareActivityEndTimestamp"
           "SafeguardingConcern_SnomedCt"
           "UrgentAndEmergencyCareDischargeDestination_SnomedCt"
           "OrganisationSiteIdentifier_DischargeFromUrgentAndEmergencyCare"
           "UrgentAndEmergencyCareDischargeFollowUp_SnomedCt"
           "UrgentAndEmergencyCareDischargeInformationGivenIndicator")
RESEARCH_AND_DISEASE_OUTBREAK=("ClinicalTrialIdentifier"
                               "DiseaseOutbreakNotificationDescription"
                               "DiseaseOutbreakNotification_SnomedCt")
DATA_SET_SUMMARY=("NHSNumberStatusIndicatorCode"
                  "OrganisationIdentifier_ResidenceResponsibility"
                  "WithheldIdentityReason")
CDS_INTERCHANGE_HEADER=("CDSInterchangeSenderIdentity
CDSInterchangeReceiverIdentity
CDSInterchangeControlReference
CDSInterchangeDateOfPreparation
CDSInterchangeTimeOfPreparation
CDSInterchangeApplicationReference
CDSInterchangeTestIndicator")
CDS_INTERCHANGE_TRAILER=("CDSInterchangeControlReference"
                         "CDSInterchangeControlCount"
                         "CDSInterchangeSenderIdentity"
                         "CDSInterchangeReceiverIdentity")
CDS_MESSAGE_HEADER=("CDSMessageType"
                    "CDSMessageVersionNumber"
                    "CDSMessageReferenceNumber"
                    "CDSMessageRecordIdentifier")
CDS_MESSAGE_TRAILER=("CDSMessageReferenceNumber")
CDS_TRANS_HEADER_BULK=("CDSTypeCode"
                       "CDSProtocolIdentifierCode"
                       "CDSUniqueIdentifier"
                       "CDSBulkReplacementGroupCode"
                       "CDSExtractDate"
                       "CDSExtractTime"
                       "CDSReportPeriodStartDate"
                       "CDSReportPeriodEndDate"
                       "CDSActivityDate"
                       "OrganisationIdentifier_CDSSender"
                       "OrganisationIdentifier_CDSRecipient")
CDS_TRANS_HEADER_NET=("CDSTypeCode"
                      "CDSProtocolIdentifierCode"
                      "CDSUniqueIdentifier"
                      "CDSUpdateType"
                      "CDSApplicableDate"
                      "CDSApplicableTime"
                      "CDSActivityDate"
                      "OrganisationIdentifier_CDSSender"
                      "OrganisationIdentifier_CDSRecipient")

for x in "${PATIENT_IDENTITY[@]}"; do
      echo -n "${x},"
      grep -on "${x}" data/xml/ecds/ecdsxml/*.xsd | awk -F':' '{ print $1 }'  | sort | uniq -c | sed -e 's/[[:space:]]+/,/g'
done
 for x in "${PATIENT_CHARATERISTICS[@]}"; do
      echo -n "${x},"
      grep -on "${x}" data/xml/ecds/ecdsxml/*.xsd | awk -F':' '{ print $1 }'  | sort | uniq -c | sed -e 's/[[:space:]]+/,/g'
done
 for x in "${SOCIAL_AND_PERSONAL_CRUCMST[@]}"; do
      echo -n "${x},"
      grep -on "${x}" data/xml/ecds/ecdsxml/*.xsd | awk -F':' '{ print $1 }'  | sort | uniq -c | sed -e 's/[[:space:]]+/,/g'
done
 for x in "${MENTAL_HEALTH_ACT[@]}"; do
      echo -n "${x},"
      grep -on "${x}" data/xml/ecds/ecdsxml/*.xsd | awk -F':' '{ print $1 }'  | sort | uniq -c | sed -e 's/[[:space:]]+/,/g'
done

for x in "${GP_REGISTRATION[@]}"; do
      echo -n "${x},"
      grep -on "${x}" data/xml/ecds/ecdsxml/*.xsd | awk -F':' '{ print $1 }'  | sort | uniq -c | sed -e 's/[[:space:]]+/,/g'
done
 for x in "${ATTENDANCE_LOCATION[@]}"; do
      echo -n "${x},"
      grep -on "${x}" data/xml/ecds/ecdsxml/*.xsd | awk -F':' '{ print $1 }'  | sort | uniq -c | sed -e 's/[[:space:]]+/,/g'
done
 for x in "${AMBULANCE_DETAILS[@]}"; do
      echo -n "${x} "
      grep -on "${x}" data/xml/ecds/ecdsxml/*.xsd | awk -F':' '{ print $1 }'  | sort | uniq -c |
        awk -F'[[:space:]]+' '{ print $1","$2","$3 }'
done
 for x in "${EXPECTED_DATE_AND_TIME_OF_TRE[@]}"; do
      echo -n "${x},"
      grep -on "${x}" data/xml/ecds/ecdsxml/*.xsd | awk -F':' '{ print $1 }'  | sort | uniq -c | sed -e 's/[[:space:]]+/,/g'
done
 for x in "${ATTENDANCE_ACTIVITY[@]}"; do
      echo -n "${x},"
      grep -on "${x}" data/xml/ecds/ecdsxml/*.xsd | awk -F':' '{ print $1 }'  | sort | uniq -c | sed -e 's/[[:space:]]+/,/g'
done
 for x in "${ASSESSMENT_TOOL[@]}"; do
      echo -n "${x},"
      grep -on "${x}" data/xml/ecds/ecdsxml/*.xsd | awk -F':' '{ print $1 }'  | sort | uniq -c | sed -e 's/[[:space:]]+/,/g'
done
 for x in "${CODED_CLINICAL_OBSERVATIONS[@]}"; do
      echo -n "${x},"
      grep -on "${x}" data/xml/ecds/ecdsxml/*.xsd | awk -F':' '{ print $1 }'  | sort | uniq -c | sed -e 's/[[:space:]]+/,/g'
done
 for x in "${CODED_CLINICAL_FINDINGS[@]}"; do
      echo -n "${x},"
      grep -on "${x}" data/xml/ecds/ecdsxml/*.xsd | awk -F':' '{ print $1 }'  | sort | uniq -c | sed -e 's/[[:space:]]+/,/g'
done
 for x in "${INJURY_CHARACTERISTICS[@]}"; do
      echo -n "${x},"
      grep -on "${x}" data/xml/ecds/ecdsxml/*.xsd | awk -F':' '{ print $1 }'  | sort | uniq -c | sed -e 's/[[:space:]]+/,/g'
done

for x in "${PATIENT_CLINICAL_HISTORY[@]}"; do
      echo -n "${x},"
      grep -on "${x}" data/xml/ecds/ecdsxml/*.xsd | awk -F':' '{ print $1 }'  | sort | uniq -c | sed -e 's/[[:space:]]+/,/g'
done
 for x in "${SERVICE_AGREEMENT_DETAILS[@]}"; do
      echo -n "${x},"
      grep -on "${x}" data/xml/ecds/ecdsxml/*.xsd | awk -F':' '{ print $1 }'  | sort | uniq -c | sed -e 's/[[:space:]]+/,/g'
done
 for x in "${CARE_PROFESSIONALS[@]}"; do
      echo -n "${x},"
      grep -on "${x}" data/xml/ecds/ecdsxml/*.xsd | awk -F':' '{ print $1 }'  | sort | uniq -c | sed -e 's/[[:space:]]+/,/g'
done
 for x in "${DIAGNOSIS[@]}"; do
      echo -n "${x},"
      grep -on "${x}" data/xml/ecds/ecdsxml/*.xsd | awk -F':' '{ print $1 }'  | sort | uniq -c | sed -e 's/[[:space:]]+/,/g'
done
 for x in "${INVESTIGATIONS[@]}"; do
      echo -n "${x},"
      grep -on "${x}" data/xml/ecds/ecdsxml/*.xsd | awk -F':' '{ print $1 }'  | sort | uniq -c | sed -e 's/[[:space:]]+/,/g'
done

for x in "${TREATMENTS[@]}"; do
      echo -n "${x},"
      grep -on "${x}" data/xml/ecds/ecdsxml/*.xsd | awk -F':' '{ print $1 }'  | sort | uniq -c | sed -e 's/[[:space:]]+/,/g'
done
 for x in "${REFERRALS_TO_OTHER_SERVICES[@]}"; do
      echo -n "${x},"
      grep -on "${x}" data/xml/ecds/ecdsxml/*.xsd | awk -F':' '{ print $1 }'  | sort | uniq -c | sed -e 's/[[:space:]]+/,/g'
done
 for x in "${EMED3_FIT_NOTE[@]}"; do
      echo -n "${x},"
      grep -on "${x}" data/xml/ecds/ecdsxml/*.xsd | awk -F':' '{ print $1 }'  | sort | uniq -c | sed -e 's/[[:space:]]+/,/g'
done
 for x in "${DISCHARGE[@]}"; do
      echo -n "${x},"
      grep -on "${x}" data/xml/ecds/ecdsxml/*.xsd | awk -F':' '{ print $1 }'  | sort | uniq -c | sed -e 's/[[:space:]]+/,/g'
done
 for x in "${RESEARCH_AND_DISEASE_OUTBREAK[@]}"; do
      echo -n "${x},"
      grep -on "${x}" data/xml/ecds/ecdsxml/*.xsd | awk -F':' '{ print $1 }'  | sort | uniq -c | sed -e 's/[[:space:]]+/,/g'
done

for x in "${DATA_SET_SUMMARY[@]}"; do
      echo -n "${x},"
      grep -on "${x}" data/xml/ecds/ecdsxml/*.xsd | awk -F':' '{ print $1 }'  | sort | uniq -c | sed -e 's/[[:space:]]+/,/g'
done
 for x in "${CDS_INTERCHANGE_HEADER[@]}"; do
      echo -n "${x},"
      grep -on "${x}" data/xml/ecds/ecdsxml/*.xsd | awk -F':' '{ print $1 }'  | sort | uniq -c | sed -e 's/[[:space:]]+/,/g'
done
 for x in "${CDS_INTERCHANGE_TRAILER[@]}"; do
      echo -n "${x},"
      grep -on "${x}" data/xml/ecds/ecdsxml/*.xsd | awk -F':' '{ print $1 }'  | sort | uniq -c | sed -e 's/[[:space:]]+/,/g'
done
 for x in "${CDS_MESSAGE_HEADER[@]}"; do
      echo -n "${x},"
      grep -on "${x}" data/xml/ecds/ecdsxml/*.xsd | awk -F':' '{ print $1 }'  | sort | uniq -c | sed -e 's/[[:space:]]+/,/g'
done
 for x in "${CDS_MESSAGE_TRAILER[@]}"; do
      echo -n "${x},"
      grep -on "${x}" data/xml/ecds/ecdsxml/*.xsd | awk -F':' '{ print $1 }'  | sort | uniq -c | sed -e 's/[[:space:]]+/,/g'
done
 for x in "${CDS_TRANS_HEADER_BULK[@]}"; do
      echo -n "${x},"
      grep -on "${x}" data/xml/ecds/ecdsxml/*.xsd | awk -F':' '{ print $1 }'  | sort | uniq -c | sed -e 's/[[:space:]]+/,/g'
done
 for x in "${CDS_TRANS_HEADER_NET[@]}"; do
      echo -n "${x},"
      grep -on "${x}" data/xml/ecds/ecdsxml/*.xsd | awk -F':' '{ print $1 }'  | sort | uniq -c | sed -e 's/[[:space:]]+/,/g'
done



for x in "${PATIENT_IDENTITY[@]}"; do
      echo -n "${x},"
      grep -on "${x}" data/xml/ecds/ecdsxml/*.xsd | awk -F':' '{ print $1 }'  | sort | uniq -c | sed -e 's/[[:space:]]+/,/g'
done
