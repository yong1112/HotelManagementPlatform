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
@WebServlet(name = "C205_EditRoomDetails", urlPatterns = {"/C205_EditRoomDetails"})
public class C205_EditRoomDetails extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        MongoDBManager db = (MongoDBManager) session.getAttribute("Query");

        if (db == null) {
            db = new MongoDBManager();
            session.setAttribute("Query", db);
        }

        // Capture form data from JSP
        String roomName = request.getParameter("roomName");
        String roomNum = request.getParameter("roomNum");
        String roomPrice = request.getParameter("roomPrice");
        String adultCapacity = request.getParameter("adultCapacity");
        String childCapacity = request.getParameter("childCapacity");
        String description = request.getParameter("description");

        
        db.editRoomDetails(roomName, roomNum, roomPrice, adultCapacity, childCapacity, description);
        session.setAttribute("roomList", db.GetRoomList());
        response.sendRedirect("/hotelmanagement/Manager/ManagerRoom.jsp");

    }
}