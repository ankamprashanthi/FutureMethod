global class FutureMethodEmail {
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
      // mail.setPlainTextBody('Hello \n Your Contact Records Has been Updated \n Best Regards \n Ankam Prashanthi');
      String htmlBody='<!DOCTYPE Html>'+
          '<html>'+
          '<head>'+
          '<style>'+
          'body{ font-family: Arial,sans-serif;text-align: center}'+
          '</style>'+
          '</head>'+
          '<body>'+
          '<div>'+
          '    <p>Dear ' + c.FirstName + ',</p>' +
                '    <p>We wanted to let you know that your contact record has been successfully updated in our system.</p>' +
                '    <p>If you have any questions or need further assistance, feel free to reply to this email.</p>' +
                '    <p>Best regards,<br/>Ankam Prashanthi</p>' +
          '</div>'+
          '</body>'+
          '</html>';
         mail.setHtmlBody(htmlBody);
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