@isTest
public class TriggerTestClass {
    
    @testSetup
    static void setup(){
        Account testAcct1 = new Account(Name = 'Test Account');
       	Account testAcct2 = new Account(Name = 'Daisy', 
                                        BillingState = 'California',
                                      	BillingStreet = 'Jinx Lane',
                                       	BillingCountry = 'USA',
                                       	BillingPostalCode = '10333',
                                       	BillingCity = 'Hollywood');
        insert testAcct1;
        insert testAcct2;
        
        Contact testCon1 = new Contact(FirstName = 'Test', LastName = 'Account');
        Contact testCon2 = new Contact(FirstName = 'Lucy', LastName = 'Goodwill',  
                                       	MailingState = 'California',
                                      	MailingStreet = 'Jinx Lane',
                                       	MailingCountry = 'USA',
                                       	MailingPostalCode = '10333',
                                       	MailingCity = 'Hollywood');
        
        insert testCon1;
        insert testCon2;
        
    }
    
    @isTest
    static void ContactAccountMatchTest() {
        
        
        
        Contact con1 = [SELECT AccountId 
                        FROM Contact 
                        WHERE FirstName = 'Test' LIMIT 1];
        Account acc1 = [SELECT Id 
                        FROM Account 
                        WHERE Name = 'Test Account'  LIMIT 1];
       	System.assertEquals(acc1.Id, con1.AccountId);
        
        Contact con2 = [SELECT AccountId 
                        FROM Contact 
                        WHERE MailingStreet = 'Jinx Lane'];
        Account acc2 = [SELECT Id 
                        FROM Account 
                        WHERE BillingStreet = 'Jinx Lane'];
        System.assertEquals(acc2.Id, con2.AccountId);
        
    }

}