/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controller;

import DAO.MongoDBManager;
import Model.User;
import java.io.IOException;
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
@WebServlet(name = "C106_ResetPassword", urlPatterns = {"/C106_ResetPassword"})
public class C106_ResetPassword extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        MongoDBManager db = (MongoDBManager) session.getAttribute("Query");

        if (db == null) {
            db = new MongoDBManager();
            session.setAttribute("Query", db);
        }

        String token = (String) request.getParameter("token");
        String password = (String) request.getParameter("password");
        String confirmPassword = (String) request.getParameter("confirmPassword");
        
        // Token Expiry date set for 2 hours - Note the getTime returns milliseconds
        long expiryTime = 2 * 60 * 60 * 1000;

        // Check if password is the same
        if (!password.equals(confirmPassword)) {
            session.setAttribute("tokenErr", "Password not the same");
            response.sendRedirect("/hotelmanagement/Homepage/ResetPassword.jsp");
        } else if (!db.isTokenExist(token)) { // Check if token exists
            session.setAttribute("tokenErr", "Token not found");
            response.sendRedirect("/hotelmanagement/Homepage/ResetPassword.jsp");
        } else if (db.getTokenTimeDiff(token) > expiryTime) { // Checks if time is expired
            db.deleteUserToken(token);
            session.setAttribute("tokenErr", "Token has expired");
            response.sendRedirect("/hotelmanagement/Homepage/ResetPassword.jsp");
        } else {
            // Reset Password
            db.resetPasswordbyToken(token, password);
            
            session.setAttribute("LoginErr", "Reset password succesful");
            response.sendRedirect("/hotelmanagement/Homepage/Login.jsp");
        }
    }
}
