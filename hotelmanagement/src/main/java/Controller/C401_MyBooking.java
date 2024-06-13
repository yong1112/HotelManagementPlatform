/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controller;

import DAO.MongoDBManager;
import Model.Booking;
import Model.Room;
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
@WebServlet(name = "C401_MyBooking", urlPatterns = {"/C401_MyBooking"})
public class C401_MyBooking extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        MongoDBManager db = (MongoDBManager) session.getAttribute("Query");

        //Create a new arraylist
        ArrayList<String> myBooking = new ArrayList<String>();
        String username = (String) session.getAttribute("username");

        //return to the mybooking after room was booked
        myBooking = db.getMyBooking(username);
        
        session.setAttribute("myBooking", myBooking);
        session.setAttribute("username", username);
        response.sendRedirect("/hotelmanagement/Customer/MyBooking.jsp");
    }
}
