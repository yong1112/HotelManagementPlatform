package Model;

import org.apache.commons.mail.DefaultAuthenticator;
import org.apache.commons.mail.Email;
import org.apache.commons.mail.EmailException;
import org.apache.commons.mail.SimpleEmail;

/**
 *
 * @author oneilrangiuira
 */
// Java program to send simple email using apache commons email
// Uses the Gmail SMTP servers
public class EmailSender {

    private static final String HOST = "smtp.gmail.com";
    private static final int PORT = 465;
    private static final boolean SSL_FLAG = true;

    // This method will send a "Request to Reset Password" to the desired email address.
    public void resetPassword(String userEmail, String name, String token) {
        
        String userName = "hotelmanagementservice0@gmail.com";
        String password = "hotelmanagementis1";

        String fromAddress = "hotelmanagementservice0@gmail.com";
        String toAddress = userEmail;
        String subject = "Request to Reset Password";
        String message = "<p>Dear " + name + ",</p>";
        message += "<br><p>We received a request to reset your account password for Hotel Management</p>"
                + "<br><p>Please copy your unique token:    " + "<strong>" + token + "</strong><br>"
                + "and click on the link below to reset your password.</p>"
                + "<br><a href=\"http://localhost:8080/hotelmanagement/Homepage/ResetPassword.jsp\">Click here to Reset Password</a><br><br>"
                + "<p>Please note that your token will expire in 2 hours. If so, send another reset password request.</p>"
                + "<br><p>Regards,<br>"
                + "Hotel Management Team</p>";

        try {
            // Compile Email
            Email email = new SimpleEmail();
            email.setHostName(HOST);
            email.setSmtpPort(PORT);
            email.setAuthenticator(new DefaultAuthenticator(userName, password));
            email.setSSLOnConnect(SSL_FLAG);
            email.setFrom(fromAddress);
            email.setSubject(subject);
            email.setMsg(message);
            email.setContent(message, "text/html; charset=utf-8"); // To allow for html editting
            email.addTo(toAddress);
            email.send();
        } catch (EmailException ex) {
            System.out.println("Unable to send email");
            System.out.println("If your email doesnt work, turn off the error by using https://www.google.com/settings/security/lesssecureapps");
            System.out.println(ex);
        }
    }
}
