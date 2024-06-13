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
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.logging.Level;
import java.util.logging.Logger;
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
@WebServlet(name = "C301_RoomAvaiabilityCheck", urlPatterns = {"/C301_RoomAvaiabilityCheck"})
public class C301_RoomAvaiabilityCheck extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        MongoDBManager db = (MongoDBManager) session.getAttribute("Query");

        if (db == null) {
            db = new MongoDBManager();
            session.setAttribute("Query", db);
        }

        //ArrayList stored data from Database
        ArrayList<Room> roomList = db.GetRoomEdit();
        ArrayList<String> AllRoomId = new ArrayList<>();
        ArrayList<Room> avaiableRoomList = new ArrayList<>();
        ArrayList<String> unavaiablieroomId = new ArrayList<>();

        //Data retrieve from jsp
        String fromDate = (String) request.getParameter("fromDate");
        String toDate = (String) request.getParameter("toDate");
        String adult = (String) request.getParameter("adult");
        String child = (String) request.getParameter("child");
        String location = (String) request.getParameter("index");

        //Get all room id and store in AllRoomId
        for (int i = 0; i < roomList.size(); i++) {
            AllRoomId.add(roomList.get(i).getRoomNum());
        }

        //Get all room id that not avaiable which have a same period of stay or in a middle
        unavaiablieroomId = checkroomID(fromDate, toDate, db);

        //remove unavaiable room id out of all room id so that it will have only avaiable room id
        AllRoomId.removeAll(unavaiablieroomId);

        //Clear unavaiablieroomId since no need anymore and can reduce memory used
        unavaiablieroomId.clear();

        //After get only avaiable room id, then check for adult and child numbers and return to next jsp. Error messages will be displayed if no room fouond.
        returnAvaiableRoom(session, response, AllRoomId, avaiableRoomList,
                roomList, adult, child, location, fromDate, toDate);

    }

    public static ArrayList<String> checkroomID(String fromDate, String toDate, MongoDBManager db) {

        //New pattern for date
        SimpleDateFormat dateFormatter = new SimpleDateFormat("yyyy-MM-dd");
        //Get all booking from the database
        ArrayList<Booking> booking = db.getBooking();
        ArrayList<String> unavaiablieroomId = new ArrayList<>();

        try {
            //Covert date String to Date format
            Date newFromDate = dateFormatter.parse(fromDate);
            Date newtoDate = dateFormatter.parse(toDate);
           
            //Check if the selected start date and end date is in the middle or already existed in the database
            for (int i = 0; i < booking.size(); i++) {
                Date newStartDate = dateFormatter.parse(booking.get(i).getStartDate());
                Date newEndDate = dateFormatter.parse(booking.get(i).getEndDate());
                if (newFromDate.after(newEndDate) || newtoDate.before(newStartDate)) {
                } else {
                    //save all the unavaialbe room id
                    unavaiablieroomId.add(booking.get(i).getRoomId());
                }
            }

        } catch (ParseException ex) {
            Logger.getLogger(C301_RoomAvaiabilityCheck.class.getName()).log(Level.SEVERE, null, ex);
        }

        return unavaiablieroomId;
    }

    public static ArrayList<Room> findAvaiableRoomId(ArrayList<String> AllRoomId, ArrayList<Room> roomList, String adult, String child) {
        ArrayList<Room> avaiableRoomList = new ArrayList<>();
        
        //check for the adult and child capacity and avaiability
        for (int i = 0; i < roomList.size(); i++) {
            for (int j = 0; j < AllRoomId.size(); j++) {
                if (AllRoomId.get(j).equals(roomList.get(i).getRoomNum())
                        && roomList.get(i).getAdultCapacity().equals(adult)
                        && roomList.get(i).getChildCapacity().equals(child)
                        && roomList.get(i).getAvailability().equals("AVAILABLE")) {
                    //if meet the requirement then save that room in avaiablieRoomList
                    avaiableRoomList.add(roomList.get(i));
                }
            }
        }

        return avaiableRoomList;
    }

    public void returnAvaiableRoom(HttpSession session, HttpServletResponse response, ArrayList<String> AllRoomId, ArrayList<Room> avaiableRoomList,
            ArrayList<Room> roomList, String adult, String child, String location, String fromDate, String toDate) throws IOException {

        //Check the adult and children capacity
        if (!AllRoomId.isEmpty()) {

            avaiableRoomList = findAvaiableRoomId(AllRoomId, roomList, adult, child);

            if (!avaiableRoomList.isEmpty()) {
                if (location.equals(
                        "index")) {
                    response.sendRedirect("/hotelmanagement/Homepage/Room.jsp");
                    session.setAttribute("avaiableRoom", avaiableRoomList);
                    session.setAttribute("fromDate", fromDate);
                    session.setAttribute("toDate", toDate);
                    session.setAttribute("found", "found");
                } else if (location.equals(
                        "customerIndex")) {
                    response.sendRedirect("/hotelmanagement/Customer/CustomerRoom.jsp");
                    session.setAttribute("avaiableRoom", avaiableRoomList);
                    session.setAttribute("fromDate", fromDate);
                    session.setAttribute("toDate", toDate);
                    session.setAttribute("found", "found");
                } else if (location.equals(
                        "staffIndex")) {
                    response.sendRedirect("/hotelmanagement/Staff/StaffRoom.jsp");
                    session.setAttribute("avaiableRoom", avaiableRoomList);
                    session.setAttribute("fromDate", fromDate);
                    session.setAttribute("toDate", toDate);
                    session.setAttribute("found", "found");
                } else if (location.equals(
                        "managerIndex")) {
                    response.sendRedirect("/hotelmanagement/Manager/ManagerRoom.jsp");
                    session.setAttribute("avaiableRoom", avaiableRoomList);
                    session.setAttribute("fromDate", fromDate);
                    session.setAttribute("toDate", toDate);
                    session.setAttribute("found", "found");
                } else if (location.equals(
                        "adminIndex")) {
                    response.sendRedirect("/hotelmanagement/Admin/AdminRoomTwo.jsp");
                    session.setAttribute("avaiableRoom", avaiableRoomList);
                    session.setAttribute("fromDate", fromDate);
                    session.setAttribute("toDate", toDate);
                    session.setAttribute("found", "found");
                }
            } else {
                if (location.equals(
                        "index")) {
                    response.sendRedirect("/hotelmanagement/Homepage/Room.jsp");
                    session.setAttribute("noAmount", "noAmount");
                } else if (location.equals(
                        "customerIndex")) {
                    response.sendRedirect("/hotelmanagement/Customer/CustomerRoom.jsp");
                    session.setAttribute("noAmount", "noAmount");
                } else if (location.equals(
                        "staffIndex")) {
                    response.sendRedirect("/hotelmanagement/Staff/StaffRoom.jsp");
                    session.setAttribute("noAmount", "noAmount");
                } else if (location.equals(
                        "managerIndex")) {
                    response.sendRedirect("/hotelmanagement/Manager/ManagerRoom.jsp");
                    session.setAttribute("noAmount", "noAmount");
                } else if (location.equals(
                        "adminIndex")) {
                    response.sendRedirect("/hotelmanagement/Admin/AdminRoomTwo.jsp");
                    session.setAttribute("noAmount", "noAmount");
                }
            }
        } else {
            if (location.equals(
                    "index")) {
                response.sendRedirect("/hotelmanagement/Homepage/Room.jsp");
                session.setAttribute("notFound", "notFound");
            } else if (location.equals(
                    "customerIndex")) {
                response.sendRedirect("/hotelmanagement/Customer/CustomerRoom.jsp");
                session.setAttribute("notFound", "notFound");
            } else if (location.equals(
                    "staffIndex")) {
                response.sendRedirect("/hotelmanagement/Staff/StaffRoom.jsp");
                session.setAttribute("notFound", "notFound");
            } else if (location.equals(
                    "managerIndex")) {
                response.sendRedirect("/hotelmanagement/Manager/ManagerRoom.jsp");
                session.setAttribute("notFound", "notFound");
            } else if (location.equals(
                    "adminIndex")) {
                response.sendRedirect("/hotelmanagement/Admin/AdminRoomTwo.jsp");
                session.setAttribute("notFound", "notFound");
            }
        }
    }
}
