/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controller;

import DAO.MongoDBManager;
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
 * @author Piseth
 */
@WebServlet(name = "C405_EditBooking", urlPatterns = {"/C405_EditBooking"})
public class C405_EditBooking extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        MongoDBManager db = (MongoDBManager) session.getAttribute("Query");

        if (db == null) {
            db = new MongoDBManager();
            session.setAttribute("Query", db);
        }

        // Capture form data from JSP
        String bookingID = request.getParameter("bookingID");
        String roomId = request.getParameter("roomId");
        String price = request.getParameter("price");
        String startDate = request.getParameter("startDate");
        String endDate = request.getParameter("endDate");
        String totalStay = request.getParameter("totalStay");
        String totalPrice = request.getParameter("totalPrice");
        String bookedFor = request.getParameter("bookedFor");
        
        //Updated booking details in to the database
        db.editBooking(bookingID, roomId, price, startDate, endDate, totalStay, totalPrice, bookedFor);
        session.setAttribute("allBooking", db.getBooking());
        response.sendRedirect("/hotelmanagement/Staff/StaffBooking.jsp");
    }
}
