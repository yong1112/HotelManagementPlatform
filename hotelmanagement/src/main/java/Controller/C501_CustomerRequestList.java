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
 * @author leeki
 */
@WebServlet(name = "C501_CustomerRequestList", urlPatterns = {"/C501_CustomerRequestList"})
public class C501_CustomerRequestList extends HttpServlet {

   protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        MongoDBManager db = (MongoDBManager) session.getAttribute("Query");

        if (db == null) {
            db = new MongoDBManager();
            session.setAttribute("Query", db);
        }

        // Capture form data from JSP
        String bookingID = request.getParameter("bookingID");
        
        int pillow = Integer.parseInt(request.getParameter("pillow"));
                
        int blanket = Integer.parseInt(request.getParameter("blanket"));
        
        int slippers = Integer.parseInt(request.getParameter("slippers"));
        
        int towel = Integer.parseInt(request.getParameter("towel"));
        
        String others = request.getParameter("others");
        
        boolean pickUpService = Boolean.parseBoolean(request.getParameter("pickUpService"));
        
        db.customerRequest(bookingID, pillow, blanket, slippers, towel, others, pickUpService);
        //session.setAttribute("booking", db.getItemList());
        response.sendRedirect("/hotelmanagement/Customer/MyBooking.jsp");

    }

}
