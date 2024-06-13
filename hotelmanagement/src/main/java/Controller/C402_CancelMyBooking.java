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
@WebServlet(name = "C402_CancelMyBooking", urlPatterns = {"/C402_CancelMyBooking"})
public class C402_CancelMyBooking extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        MongoDBManager db = (MongoDBManager) session.getAttribute("Query");

        //Create a new arralist and retreive the data from jsp
        ArrayList<String> myBooking = new ArrayList<String>();
        String username = (String) session.getAttribute("username");
        String bookingID = (String) request.getParameter("bookingID");
        
        //Cancel booking using room number
        db.cancelBooking(bookingID);
        myBooking = db.getMyBooking(username);

        session.setAttribute("myBooking", myBooking);
        response.sendRedirect("/hotelmanagement/Customer/CancelMyBooking.jsp");
    }
}
