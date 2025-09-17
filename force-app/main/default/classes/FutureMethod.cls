global class FutureMethod {
@future
    public static void getContacts(List<Id> recordId)
    {
        List<Contact> con=[select FirstName,Email From Contact where Id IN: recordId and Email!=null];
         
        List<Messaging.SingleEmailMessage> emails=new List<Messaging.SingleEmailMessage>();
        for(Contact c:con)
        {
       Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
       String[] maidId = new String[]{c.Email};
       mail.setToAddresses(maidId);
       mail.setSubject('Contact Records Has Updated');
       mail.setPlainTextBody('Hello \n Your Contact Records Has been Updated \n Best Regards \n Ankam Prashanthi');
        emails.add(mail);
        }
        if(!emails.isEmpty())
        {
            try
            {
                Messaging.sendEmail(emails);
                System.debug('Email sent');
            }
            catch(Exception er)
            {
                System.debug(er);
            }
        }
        else
        {
            System.debug('Email is empty');
        }

    }
}