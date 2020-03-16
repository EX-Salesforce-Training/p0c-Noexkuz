trigger ContactAccountMatch on Contact (before insert, after insert) {
    List<Account> accList = [SELECT Id, Name, BillingStreet, 
                             BillingCity, BillingState, BillingPostalCode, BillingCountry 
                     		FROM Account];
    List<Contact> updateCon = new List<Contact>();
    
    for(Contact a: [SELECT Id, AccountId, FirstName, LastName, 
                    MailingStreet, MailingCity, MailingState,
                    MailingPostalCode, MailingCountry 
                    FROM Contact 
                    WHERE Id IN :Trigger.new]){
     	for(Account x: accList){
            if(a.AccountId == null){
               	if( x.Name.contains(a.FirstName) || x.Name.contains(a.LastName)){
                   	a.AccountId = x.Id; 
                   	update a;
          		} else if (a.MailingStreet != null && x.BillingStreet == a.MailingStreet ||
                       a.MailingCity != null && x.BillingCity == a.MailingCity ||
                       a.MailingState != null && x.BillingState == a.MailingState ||
                       a.MailingPostalCode != null && x.BillingPostalCode == a.MailingPostalCode ||
                       a.MailingCountry != null && x.BillingCountry == a.MailingCountry){
                           a.AccountId = x.Id;
                           updateCon.add(a);
               }
            }
     	}
    }
    if(updateCon.size() > 0){
        update updateCon;
    }
}