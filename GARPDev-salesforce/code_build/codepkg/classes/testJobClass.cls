global class testJobClass{
    
    @future(callout=true)
    public static void testJobMethod() {
        
		List<Contact> clist = [select Id, Name, AccountId, KPI_Last_Updated_Date__c from Contact where KPI_Last_Updated_Date__c != :date.today() limit 100]; 
        
        system.debug('* * * clist: ' + clist);

        List<Id> ids = new List<Id>();
        for(Contact con : clist) {
            ids.add(con.AccountId);
        }
        
        List<Exam_Attempt__c> elist = [Select Id, Name, Member__c from Exam_Attempt__c where Member__C in :clist];
        List<Account> alist = [select Id, Name from Account where id in :ids]; 
        List<Contract> plist = [select Id, Name from Contract where Status='Activated' and accountId in :alist order by accountId]; 
        
        List<CPE_Claim__c> claimList = [select Id, Name, Candidate_Requirement__r.Candidate_Commitment__r.AccountId from CPE_Claim__c where Candidate_Requirement__r.Candidate_Commitment__r.AccountId in :ids];
        
        List<Contract> lstContract = new List<Contract>();
        List<Exam_Attempt__c> lstEa = new List<Exam_Attempt__c>();
        List<CPE_Claim__c> lstClaim = new List<CPE_Claim__c>();
        
        Id conId = null;
        for(Contract con : plist) {
            if(conId == null || conId != con.Id) {
                lstContract.add(con);
                system.debug('* * * Contracts: ' + con.Name);
            }
            conId = con.id;
        }
        update lstContract;

        Id eaId = null;
        for(Exam_Attempt__c ea : elist) {
            if(eaId == null || eaId != ea.Member__c) { 
                lstEa.add(ea);
                system.debug('* * * EA: ' + ea.Name);
            }
            eaId = ea.Member__c;
        }
        update lstEa;

        Id claimId = null;
        for(CPE_Claim__c claim : claimList) {
            if(claimId == null || claimId != claim.Candidate_Requirement__r.Candidate_Commitment__r.AccountId) { 
                lstClaim.add(claim);
                system.debug('* * * Claim: ' + claim.Name);
            }
            claimId = claim.Candidate_Requirement__r.Candidate_Commitment__r.AccountId;
        }
        update lstClaim;

       
        for(Contact con : clist)
            con.KPI_Last_Updated_Date__c = date.today();
        update clist;

		
    }

}