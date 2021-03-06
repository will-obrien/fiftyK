public class generateSnapShot
{
    private final Snapshot__c snap;
    
    public generateSnapShot(ApexPages.StandardController controller) {
        snap = (Snapshot__c)controller.getRecord();
    }

    
    public void createSnapShot()
    {
        // insert the snapshot record
        snap.SnapShot_Date__c = System.Today(); 
        insert snap;
        // execute apex batch
        
        // Query for contact
        String q = 'SELECT Id, KPI_Chapter_Associate_Director__c, KPI_Chapter_Committee_Member__c, KPI_Chapter_Director__c, KPI_Chapter_Meeting_Speaker__c,KPI_CPE_Credits__c, KPI_CPE_Current_Cycle__c, KPI_CPE_Last_Completed_Cycle__c, KPI_CPE_Participation__c, KPI_CPE_Requirement_Status__c, KPI_Current_Exam_Date__c, KPI_Current_Exam_Location__c, KPI_Current_Exam_Registration__c, KPI_Current_Exam_Registration_ADA__c, KPI_Current_Exam_Reg_Business_Type__c, KPI_Current_Exam_Registration_RA__c, KPI_Current_Exam_Reg_Scholarship__c, KPI_Current_Exam_Registration_Type__c, KPI_ERP_Candidate__c, KPI_ERP_Candidate_Business_Type__c, KPI_ERP_Candidate_Payment_Lapsed_Months__c, KPI_ERP_Candidate_Payment_Status__c, KPI_ERP_Certified__c, KPI_ERP_Certified_Date__c, KPI_ERP_Certified_Year__c, KPI_ERP_Enrollment_Date__c, KPI_ERP_Holder__c, KPI_Event_Speaker__c, KPI_FBR_Participant__c, KPI_FRM_Candidate__c, KPI_FRM_Candidate_Business_Type__c, KPI_FRM_Candidate_Payment_Lapsed_Months__c, KPI_FRM_Candidate_Payment_Status__c, KPI_FRM_Certified__c, KPI_FRM_Certified_Date__c, KPI_FRM_Certified_Year__c, KPI_FRM_Enrollment_Date__c, KPI_FRM_Holder__c, KPI_GARP_Board_Member__c, KPI_GARP_Committee_Member__c, KPI_ICBRR_Participant__c, KPI_ICBRR_Result__c, KPI_Item_Writer__c, KPI_J_Wiley__c, Name, KPI_Last_Exam_Check_In__c, KPI_Last_Exam_Date__c, KPI_Last_Exam_Location__c, KPI_Last_Exam_Registration__c, KPI_Last_Exam_Registration_ADA__c, KPI_Last_Exam_Registration_RA__c, KPI_Last_Exam_Registration_Scholarship__c, KPI_Last_Exam_Registration_Type__c, KPI_Last_Exam_Result__c, KPI_Last_Exam_Violation__c, KPI_Member__c, KPI_Membership_Auto_Renew_Orig_Status__c, KPI_Membership_Auto_Renew_Status__c, KPI_Membership_Business_Type__c, KPI_Membership_Expiration_Date__c, KPI_Membership_Original_Business_Type__c, KPI_Membership_Original_Source__c, KPI_Membership_Original_Type__c, KPI_Membership_Payment_Lapsed_Months__c, KPI_Membership_Payment_Status__c, KPI_Membership_Renewal_Count__c, KPI_Membership_Renewal_Type__c, KPI_Membership_Since__c, KPI_Membership_Source__c, KPI_Proctor__c, KPI_Proctor_Supervisor__c FROM Contact where isDeleted=false';
        Id batchInstanceId = Database.executeBatch(new CreateKPIDataPoint(q,snap.Id),2000);         
        
    }
}