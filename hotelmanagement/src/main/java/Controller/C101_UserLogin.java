/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controller;

import DAO.MongoDBManager;
import Model.Booking;
import Model.Staff;
import Model.User;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
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
@WebServlet(name = "C101_UserLogin", urlPatterns = {"/C101_UserLogin"})
public class C101_UserLogin extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        MongoDBManager db = (MongoDBManager) session.getAttribute("Query");

        if (db == null) {
            db = new MongoDBManager();
            session.setAttribute("Query", db);
        }

        String username = (String) request.getParameter("username");
        String password = (String) request.getParameter("password");
        ArrayList<String> myBooking = db.getMyBooking(username);
        ArrayList<String> allBooking = db.getAllBooking();
        try {

            if (db.isAdmin(username, password)) {
                session.setAttribute("user", db.FindAdmin(username, password));
                session.setAttribute("staff", db.getAllStaff());
                session.setAttribute("customer", db.getAllCustomers()); 
                session.setAttribute("manager", db.getAllManagers()); 
                //MAKE ONE FOR MANAGER
                session.setAttribute("adminLoginCheck", "Please log in");
                response.sendRedirect("/hotelmanagement/Admin/AdminIndex.jsp");
            } else if (db.isCustomer(username, password)) {
                session.setAttribute("username", username);
                session.setAttribute("myBooking", myBooking);
                session.setAttribute("user", db.FindCustomer(username, password));
                session.setAttribute("customerLoginCheck", "Please log in");
                response.sendRedirect("/hotelmanagement/Customer/CustomerIndex.jsp");
            } else if (db.isStaff(username, password)) {
                Staff staff = db.FindStaff(username, password);

                if (staff.getPosition().equals("Manager")) {
                    session.setAttribute("user", db.FindStaff(username, password));
                    session.setAttribute("staff", db.getAllStaff());
                    session.setAttribute("customer", db.getAllCustomers()); 
                    session.setAttribute("allBooking", allBooking);
                    session.setAttribute("managerLoginCheck", "Please log in");
                    response.sendRedirect("/hotelmanagement/Manager/ManagerIndex.jsp");
                } else if (staff.getPosition().equals("Team member")) {
                    session.setAttribute("user", db.FindStaff(username, password)); //use this one to display account details
                    session.setAttribute("customer", db.getAllCustomers()); 
                    session.setAttribute("allBooking", allBooking);
                    session.setAttribute("staffLoginCheck", "Please log in");
                    response.sendRedirect("/hotelmanagement/Staff/StaffIndex.jsp");
                }
            }
        } catch (IOException | NullPointerException ex) {
            session.setAttribute("LoginErr", "Login failed");
            response.sendRedirect("/hotelmanagement/Homepage/Login.jsp");
            System.out.println(ex);
        }
    }
}
