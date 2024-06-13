/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controller;

import DAO.MongoDBManager;
import Model.Room;
import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.util.ArrayList;
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
@WebServlet(name = "C202_RoomList", urlPatterns = {"/C202_RoomList"})
public class C202_RoomList extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        MongoDBManager db = (MongoDBManager) session.getAttribute("Query");

        
        ArrayList<Room> newRoom = new ArrayList<Room>();
        String roomNum = (String) request.getParameter("roomNum");

        //Get all rooms in the database and redirect to Manager/RoomList
        newRoom = db.GetRoomEdit();
        session.setAttribute("newRoom", newRoom);
        response.sendRedirect("/hotelmanagement/Manager/RoomList.jsp");

    }
}
