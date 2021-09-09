package mail;
import javax.mail.Authenticator;
import javax.mail.PasswordAuthentication;

public class GoogleAuthentication extends Authenticator {
	PasswordAuthentication passAuth;
    
    public GoogleAuthentication(){
        passAuth = new PasswordAuthentication("yujinh94@gmail.com", "wjsbtkcykikbbaaw");
    }
 
    public PasswordAuthentication getPasswordAuthentication() {
        return passAuth;
    }
}
