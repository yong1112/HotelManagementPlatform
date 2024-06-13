/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controller;

import DAO.MongoDBManager;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(name = "C502_CustomerRequest", urlPatterns = {"/C502_CustomerRequest"})
public class C502_CustomerRequest extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        MongoDBManager db = (MongoDBManager) session.getAttribute("Query");

        if (db == null) {
            db = new MongoDBManager();
            session.setAttribute("Query", db);
        }
        
        //get the booking list by booking ID
        String myBookingID = request.getParameter("Btn");
        System.out.println("this is my booking id: "+ myBookingID);
        
        session.setAttribute("request", db.getBookingRequest(myBookingID));
        response.sendRedirect("/hotelmanagement/Customer/CustomerRequest.jsp");
    }
}
