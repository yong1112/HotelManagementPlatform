/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controller;

import DAO.MongoDBManager;
import java.io.IOException;
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
@WebServlet(name = "C204_EditRoom", urlPatterns = {"/C204_EditRoom"})
public class C204_EditRoom extends HttpServlet {

@Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        MongoDBManager db = (MongoDBManager) session.getAttribute("Query");

        if (db == null) {
            db = new MongoDBManager();
            session.setAttribute("Query", db);
        }

        //Edit room details using room id
        String roomNumber = request.getParameter("editButton");
        session.setAttribute("rooms", db.GetRoomDetails(roomNumber)); 
        response.sendRedirect("/hotelmanagement/Manager/EditRoomDetails.jsp");
    }

}
