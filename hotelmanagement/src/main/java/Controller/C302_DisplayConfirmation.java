/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controller;

import DAO.MongoDBManager;
import Model.Room;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author sorak
 */
@WebServlet(name = "C302_DisplayConfirmation", urlPatterns = {"/C302_DisplayConfirmation"})
public class C302_DisplayConfirmation extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session;
        session = request.getSession();
        MongoDBManager db = (MongoDBManager) session.getAttribute("Query");

        if (db == null) {
            db = new MongoDBManager();
            session.setAttribute("Query", db);
        }

        //Declare variables
        String roomId = "";
        String fromDate = "";
        String toDate = "";
        String location = "";

        //Get from JSP
        roomId = request.getParameter("roomId");
        fromDate = request.getParameter("fromDate");
        toDate = request.getParameter("toDate");
        location = request.getParameter("location");

        session.setAttribute("location", location);
        Room bookingRoom = db.GetRoomById(roomId);
        session.setAttribute("bookingRoom", bookingRoom);
        
        //return to confirmbooking
        if (location.equals("index")) {
            response.sendRedirect("/hotelmanagement/ConfirmationBooking/confirmBooking.jsp");
        } else if (location.equals("customerIndex")){
            response.sendRedirect("/hotelmanagement/Customer/CustomerConfirmBooking.jsp");
        } else if (location.equals("staffIndex")){
            response.sendRedirect("/hotelmanagement/Staff/StaffConfirmBooking.jsp");
        } else if (location.equals("managerIndex")){
            response.sendRedirect("/hotelmanagement/Manager/ManagerConfirmBooking.jsp");
        } else if (location.equals("adminIndex")){
            response.sendRedirect("/hotelmanagement/Admin/AdminConfirmBooking.jsp");
        }

    }

}
