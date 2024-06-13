/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controller;

import DAO.MongoDBManager;
import Model.Booking;
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
 * @author Piseth
 */
@WebServlet(name = "C403_StaffCancelBooking", urlPatterns = {"/C403_StaffCancelBooking"})
public class C403_StaffCancelBooking extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        MongoDBManager db = (MongoDBManager) session.getAttribute("Query");

        //Delete room using room id
        ArrayList<String> allBooking = new ArrayList<String>();
        String bookingID = (String) request.getParameter("bookingID");
        db.cancelBooking(bookingID);
        allBooking = db.getAllBooking();

        //after deleted, redirect to cancelbooking
        session.setAttribute("allBooking", allBooking);
        response.sendRedirect("/hotelmanagement/Staff/CancelBooking.jsp");
    }

}
