/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controller;

import DAO.MongoDBManager;
import Model.EmailSender;
import java.io.IOException;
import java.util.Date;
import java.util.UUID;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author oneilrangiuira
 */
@WebServlet(name = "C105_ForgotPassword", urlPatterns = {"/C105_ForgotPassword"})
public class C105_ForgotPassword extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        MongoDBManager db = (MongoDBManager) session.getAttribute("Query");

        if (db == null) {
            db = new MongoDBManager();
            session.setAttribute("Query", db);
        }

        String email = (String) request.getParameter("email");
        
        try {
            // Check if email exists in database
            if (db.isUserExist(email)) {
                // Create token to save in db
                String token = UUID.randomUUID().toString();
                db.createUserToken(email, token);
                
                // Get the user's name for personalised email
                String name = db.getNamebyToken(token);

                // Send mail
                EmailSender sender = new EmailSender();
                sender.resetPassword(email, name, token);
                
                session.setAttribute("EmailErr", "Email Sent");
            } else {
                session.setAttribute("EmailErr", "Email not found");
            }
        } catch (Error e) {
            System.out.print(e);
        } finally {
            response.sendRedirect("/hotelmanagement/Homepage/ForgotPassword.jsp");
        }
    }
}
