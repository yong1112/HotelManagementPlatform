/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controller;

import DAO.MongoDBManager;
import Model.Admin;
import Model.Staff;
import java.io.IOException;
import java.io.PrintWriter;
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
@WebServlet(name = "C103_AdminRegister", urlPatterns = {"/C103_AdminRegister"})
public class C103_AdminRegister extends HttpServlet {

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
        String role = request.getParameter("role");
       
        // Check password
        if (!password.equals(confirmPassword)) {
            session.setAttribute("passwordMsg", "Password is not the same"); // Validator for password
            response.sendRedirect("/hotelmanagement/Admin/AdminRegister.jsp");
        } else {
            try {
                if (db.isUserExist(email)) {
                    System.out.println("Exist");// Check email exists
                    session.setAttribute("usernameMsg", "Email already exists in the database"); // Validator for password
                    response.sendRedirect("/hotelmanagement/Admin/AdminRegister.jsp");
                    System.out.println("User exists in database");
                } else { // Create 
                    if (!role.equals("null")) {
                        System.out.println("Can create");
                        switch (role) {
                            case "Admin":
                                db.CreateAdmin(new Admin(email, password));
                                break;
                            case "Manager":
                            case "Team member":
                                db.CreateStaff(new Staff(firstName, lastName, email, password, role));
                                break;
                            default:
                                session.setAttribute("ErrorMsg", "You did not select an available role");
                                request.getRequestDispatcher("/Admin/AdminRegister.jsp").include(request, response);
                                break;
                        }
                    }
                    session.setAttribute("SucessMsg", "You have sucessfully created a " + role + "user");
                    response.sendRedirect("/hotelmanagement/Admin/AdminRegister.jsp");
                }
            } catch (NullPointerException ex) {
                System.out.println(ex.getMessage());
            }
        }

    }

}
