global class FutureMethodWithHtmlTemplate {
@future
    public static void getContacts(List<Id> recordId)
    {
        List<Contact> con=[select FirstName,Email From Contact where Id IN: recordId and Email!=null];
         
        List<Messaging.SingleEmailMessage> emails=new List<Messaging.SingleEmailMessage>();
        EmailTemplate template = [SELECT Id FROM EmailTemplate WHERE DeveloperName = 'Contact_Update_Notification' LIMIT 1];

        for(Contact c:con)
        {
       Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
       
            mail.setTargetObjectId(c.Id);
            mail.setTemplateId(template.Id);
           
        emails.add(mail);
        }
        if(!emails.isEmpty())
        {
            try
            {
                System.debug('Email sent');
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

