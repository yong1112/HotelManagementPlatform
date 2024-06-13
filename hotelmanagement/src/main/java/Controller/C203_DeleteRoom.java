/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controller;

import DAO.MongoDBManager;
import Model.Room;
import java.awt.Image;
import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.util.ArrayList;
import javax.imageio.ImageIO;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.swing.ImageIcon;

/**
 *
 * @author leeki
 */
@WebServlet(name = "C203_DeleteRoom", urlPatterns = {"/C203_DeleteRoom"})
public class C203_DeleteRoom extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        MongoDBManager db = (MongoDBManager) session.getAttribute("Query");

        ArrayList<Room> newRoom = new ArrayList<Room>();
        String roomNum = (String) request.getParameter("roomNum");

        //Delete room using room id 
        db.deleteRoom(roomNum);
        newRoom = db.GetRoomEdit();
        session.setAttribute("newRoom", newRoom);
        response.sendRedirect("/hotelmanagement/Manager/ManagerRoom.jsp");

    }
}
