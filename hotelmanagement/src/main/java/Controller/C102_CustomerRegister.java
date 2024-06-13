/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controller;

import DAO.MongoDBManager;
import Model.Customer;
import java.io.IOException;
import java.io.PrintWriter;
import java.nio.file.FileSystemNotFoundException;
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
@WebServlet(name = "C102_CustomerRegister", urlPatterns = {"/C102_CustomerRegister"})
public class C102_CustomerRegister extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        MongoDBManager db = (MongoDBManager) session.getAttribute("Query");

        if (db == null) {
            db = new MongoDBManager();
            session.setAttribute("Query", db);
        }

        // Capture form data from JSP
        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String email = request.getParameter("username");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");
        boolean  promotion;
        
        try {
            promotion = request.getParameter("terms").equals("true");
        } catch (NullPointerException ex) {
            promotion = false;
        }
        
        try {
            // Check password
            if (!password.equals(confirmPassword)) {
                session.setAttribute("PasswordErr", "Password is not the same"); // Validator for password
                response.sendRedirect("/hotelmanagement/Homepage/Register.jsp");
            } else {
                if (db.isUserExist(email)) { // Check email exists
                    session.setAttribute("UserErr", "Email already exists in the database"); // Validator for password
                    response.sendRedirect("/hotelmanagement/Homepage/Register.jsp");
                } else { // Create Customer account
                    db.CreateCustomer(new Customer(firstName, lastName, email, password, promotion)); // Create new Customer
                    session.setAttribute("createSuccess", "Success");
                    session.setAttribute("customerLoginCheck", "Please log in");
                    session.setAttribute("user", db.FindCustomer(email, password)); // Find User
                    response.sendRedirect("/hotelmanagement/Customer/CustomerIndex.jsp");
                }
            }
        } catch (NullPointerException ex) {
            System.out.println(ex);
        }

    }

}
