/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controller;

import DAO.MongoDBManager;
import Model.Admin;
import Model.Booking;
import Model.Room;
import Model.User;
import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashSet;
import java.util.Set;
import java.util.UUID;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.apache.commons.lang3.RandomStringUtils;

/**
 *
 * @author sorak
 */
@WebServlet(name = "C303_ConfirmBooking", urlPatterns = {"/C303_ConfirmBooking"})
public class C303_ConfirmBooking extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            HttpSession session;
            session = request.getSession();
            MongoDBManager db = (MongoDBManager) session.getAttribute("Query");

            if (db == null) {
                db = new MongoDBManager();
                session.setAttribute("Query", db);
            }
            //Date Formatter
            SimpleDateFormat dateFormatter = new SimpleDateFormat("yyyy-MM-dd");

            //Get data from database
            Room bookingRoom = (Room) session.getAttribute("bookingRoom");
            ArrayList<Booking> booking = db.getBooking();
            ArrayList<String> avaiableroomId = new ArrayList<String>();
            ArrayList<String> unavaiablieroomId = new ArrayList<String>();

            //Get Datd from Jsp
            String location = request.getParameter("location");
            String fromDate = request.getParameter("fromDate");
            String toDate = request.getParameter("toDate");
            String totalStay = request.getParameter("nights");
            String totalPrice = request.getParameter("totalPrice");
            String bookingID = RandomStringUtils.randomNumeric(8).toString();
            
            
            //Change the format of fromDate and toDate
            Date newFromDate = dateFormatter.parse(fromDate);
            Date newtoDate = dateFormatter.parse(toDate);
            boolean canBook = true;

            //Check fromDate and toDate with the database
            for (int i = 0; i < booking.size(); i++) {
                System.out.println(booking.size());
                
                Date newStartDate = dateFormatter.parse(booking.get(i).getStartDate());
                Date newEndDate = dateFormatter.parse(booking.get(i).getEndDate());
                if (newFromDate.after(newEndDate) || newtoDate.before(newStartDate)) {
                    avaiableroomId.add(booking.get(i).getRoomId());
                } else {
                    unavaiablieroomId.add(booking.get(i).getRoomId());
                }
            }
            //remove unused avaiableroom id to reduce a memory used
            avaiableroomId.clear();

            //If the location is from Index
            if (location.equals("index")) {
                for (int i = 0; i < unavaiablieroomId.size(); i++) {
                    //Check if unavaiable room is equlas to all room id that means the selected date cannot be booked
                    if (unavaiablieroomId.get(i).equals(bookingRoom.getRoomNum())) {
                        canBook = false;
                        break;
                    } else {
                        canBook = true;
                    }
                }
                //if canBook then save the booking details in the database
                if (canBook) {
                    db.CreateBooking(bookingID, bookingRoom.getRoomNum(), bookingRoom.getRoomPrice(),
                            totalStay.replace("Total stay: ", ""),
                            totalPrice.replace("Total price: $", ""), fromDate, toDate, "anonymous customer",
                            0, 0, 0, 0,"", false);
                    session.setAttribute("booked", "booked");
                    response.sendRedirect("/hotelmanagement/Homepage/Room.jsp");
                } else {
                    session.setAttribute("same", "same");
                    response.sendRedirect("/hotelmanagement/Homepage/Room.jsp");
                }
                //If the location is from customer index
            } else if (location.equals("customerIndex")) {
                for (int i = 0; i < unavaiablieroomId.size(); i++) {
                    if (unavaiablieroomId.get(i).equals(bookingRoom.getRoomNum())) {
                        canBook = false;
                        break;
                    } else {
                        canBook = true;
                    }
                }
                if (canBook) {
                    System.out.println("I am here");
                    User user = (User) session.getAttribute("user");
                    System.out.println(user);
                    System.out.println(user.getUsername());
                    db.CreateBooking(bookingID, bookingRoom.getRoomNum(), bookingRoom.getRoomPrice(),
                            totalStay.replace("Total stay: ", ""),
                            totalPrice.replace("Total price: $", ""), fromDate, toDate, user.getUsername(),
                            0, 0, 0, 0,"", false);
                    session.setAttribute("booked", "booked");
                    response.sendRedirect("/hotelmanagement//C401_MyBooking");
                } else {
                    session.setAttribute("same", "same");
                    response.sendRedirect("/hotelmanagement/Customer/CustomerRoom.jsp");
                }

                //If the location is from staff index
            } else if (location.equals("staffIndex")) {
                String bookedfor = request.getParameter("bookedfor");
                //if (db.isUserExist(bookedfor)) {
                for (int i = 0; i < unavaiablieroomId.size(); i++) {
                    if (unavaiablieroomId.get(i).equals(bookingRoom.getRoomNum())) {
                        canBook = false;
                        break;
                    } else {
                        canBook = true;
                    }
                }
                if (canBook) {
                    System.out.println("I am here");
                    User user = (User) session.getAttribute("user");
                    System.out.println(user);
                    System.out.println(user.getUsername());
                    db.CreateStaffBooking(bookingID, bookingRoom.getRoomNum(), bookingRoom.getRoomPrice(),
                            totalStay.replace("Total stay: ", ""),
                            totalPrice.replace("Total price: $", ""), fromDate, toDate, user.getUsername(), bookedfor);
                    session.setAttribute("booked", "booked");
                    response.sendRedirect("/hotelmanagement/Staff/StaffRoom.jsp");
                } else {
                    session.setAttribute("same", "same");
                    response.sendRedirect("/hotelmanagement/Staff/StaffRoom.jsp");
                }
            } //If the customer does not exist
            /*else {
                    session.setAttribute("userNotExist", "User does not exist in the Database.");
                    response.sendRedirect("/hotelmanagement/Staff/StaffConfirmBooking.jsp");*/ // If the index is manager
            else if (location.equals("managerIndex")) {
                String bookedfor = request.getParameter("bookedfor");
                //if (db.isUserExist(bookedfor)) {
                for (int i = 0; i < unavaiablieroomId.size(); i++) {
                    if (unavaiablieroomId.get(i).equals(bookingRoom.getRoomNum())) {
                        canBook = false;
                        break;
                    } else {
                        canBook = true;
                    }
                }
                if (canBook) {
                    System.out.println("I am here");
                    User user = (User) session.getAttribute("user");
                    System.out.println(user);
                    System.out.println(user.getUsername());
                    db.CreateStaffBooking(bookingID,bookingRoom.getRoomNum(), bookingRoom.getRoomPrice(),
                            totalStay.replace("Total stay: ", ""),
                            totalPrice.replace("Total price: $", ""), fromDate, toDate, user.getUsername(), bookedfor);
                    session.setAttribute("booked", "booked");
                    response.sendRedirect("/hotelmanagement/Manager/ManagerRoom.jsp");
                } else {
                    session.setAttribute("same", "same");
                    response.sendRedirect("/hotelmanagement/Manager/ManagerRoom.jsp");
                }
                /*} //If the customer does not exist
                else {
                    session.setAttribute("userNotExist", "User does not exist in the Database.");
                    response.sendRedirect("/hotelmanagement/Manager/ManagerConfirmBooking.jsp");*/
                //}
            } //If the Index is ADMIN
            else if (location.equals("adminIndex")) {
                String bookedfor = request.getParameter("bookedfor");
                //if (db.isUserExist(bookedfor)) {
                for (int i = 0; i < unavaiablieroomId.size(); i++) {
                    if (unavaiablieroomId.get(i).equals(bookingRoom.getRoomNum())) {
                        canBook = false;
                        break;
                    } else {
                        canBook = true;
                    }
                }
                if (canBook) {
                    System.out.println("I am here");
                    User user = (User) session.getAttribute("user");
                    System.out.println(user);
                    System.out.println(user.getUsername());
                    db.CreateStaffBooking(bookingID, bookingRoom.getRoomNum(), bookingRoom.getRoomPrice(),
                            totalStay.replace("Total stay: ", ""),
                            totalPrice.replace("Total price: $", ""), fromDate, toDate, user.getUsername(), bookedfor);
                    session.setAttribute("booked", "booked");
                    response.sendRedirect("/hotelmanagement/Admin/AdminRoomTwo.jsp");
                } else {
                    session.setAttribute("same", "same");
                    response.sendRedirect("/hotelmanagement/Admin/AdminRoomTwo.jsp");
                }
                /*} //If the customer does not exist
                else {
                    session.setAttribute("userNotExist", "User does not exist in the Database.");
                    response.sendRedirect("/hotelmanagement/Admin/AdminConfirmBooking.jsp");
                }*/
            } //If the index is found
            else if (location.equals(
                    "indexFound")) {
                String roomId = request.getParameter("roomId");
                String roomPrice = request.getParameter("price");
                for (int i = 0; i < unavaiablieroomId.size(); i++) {
                    if (unavaiablieroomId.get(i).equals(roomId)) {
                        canBook = false;
                        break;
                    } else {
                        canBook = true;
                    }
                }
                if (canBook) {
                    db.CreateBooking(bookingID, roomId, roomPrice,
                            totalStay.replace("Total Stay:  ", ""),
                            totalPrice.replace("Total Price:  $", ""), fromDate, toDate, "anonymous customer",
                            0, 0, 0, 0,"", false);
                    session.setAttribute("booked", "booked");
                    response.sendRedirect("/hotelmanagement/Homepage/Room.jsp");
                } else {
                    session.setAttribute("same", "same");
                    response.sendRedirect("/hotelmanagement/Homepage/Room.jsp");
                }

                //CUSTOMER
            } else if (location.equals(
                    "customerIndexFound")) {
                User user = (User) session.getAttribute("user");
                String roomId = request.getParameter("roomId");
                String roomPrice = request.getParameter("price");
                for (int i = 0; i < unavaiablieroomId.size(); i++) {
                    if (unavaiablieroomId.get(i).equals(roomId)) {
                        canBook = false;
                        break;
                    } else {
                        canBook = true;
                    }
                }
                if (canBook) {
                    db.CreateBooking(bookingID, roomId, roomPrice,
                            totalStay.replace("Total Stay:  ", ""),
                            totalPrice.replace("Total Price:  $", ""), fromDate, toDate, user.getUsername(),
                            0, 0, 0, 0,"", false);
                    session.setAttribute("booked", "booked");
                    response.sendRedirect("/hotelmanagement//C401_MyBooking");
                } else {
                    session.setAttribute("same", "same");
                    response.sendRedirect("/hotelmanagement/Customer/CustomerRoom.jsp");
                }

                //STAFF
            } else if (location.equals(
                    "staffIndexFound")) {
                User user = (User) session.getAttribute("user");
                String roomId = request.getParameter("roomId");
                String roomPrice = request.getParameter("price");
                String bookedfor = request.getParameter("bookedfor");
                //if (db.isUserExist(bookedfor)) {
                for (int i = 0; i < unavaiablieroomId.size(); i++) {
                    if (unavaiablieroomId.get(i).equals(roomId)) {
                        canBook = false;
                        break;
                    } else {
                        canBook = true;
                    }
                }
                if (canBook) {
                    db.CreateStaffBooking(bookingID, roomId, roomPrice,
                            totalStay.replace("Total Stay:  ", ""),
                            totalPrice.replace("Total Price:  $", ""), fromDate, toDate, user.getUsername(), bookedfor);
                    session.setAttribute("booked", "booked");
                    response.sendRedirect("/hotelmanagement/Staff/StaffRoom.jsp");
                } else {
                    session.setAttribute("same", "same");
                    response.sendRedirect("/hotelmanagement/Staff/StaffRoom.jsp");
                }
                /*} else {
                    session.setAttribute("userNotExist", "User does not exist in the Database.");
                    response.sendRedirect("/hotelmanagement/Staff/StaffIndex.jsp");
                }*/

            } //MANAGER
            else if (location.equals(
                    "managerIndexFound")) {
                User user = (User) session.getAttribute("user");
                String roomId = request.getParameter("roomId");
                String roomPrice = request.getParameter("price");
                String bookedfor = request.getParameter("bookedfor");
                //if (db.isUserExist(bookedfor)) {
                for (int i = 0; i < unavaiablieroomId.size(); i++) {
                    if (unavaiablieroomId.get(i).equals(roomId)) {
                        canBook = false;
                        break;
                    } else {
                        canBook = true;
                    }
                }
                if (canBook) {
                    db.CreateStaffBooking(bookingID, roomId, roomPrice,
                            totalStay.replace("Total Stay:  ", ""),
                            totalPrice.replace("Total Price:  $", ""), fromDate, toDate, user.getUsername(), bookedfor);
                    session.setAttribute("booked", "booked");
                    response.sendRedirect("/hotelmanagement/Manager/ManagerRoom.jsp");
                } else {
                    session.setAttribute("same", "same");
                    response.sendRedirect("/hotelmanagement/Manager/ManagerRoom.jsp");
                }
                /*}
                else {
                    session.setAttribute("userNotExist", "User does not exist in the Database.");
                    response.sendRedirect("/hotelmanagement/Manager/ManagerIndex.jsp");
                }*/
            } //ADMIN
            else if (location.equals(
                    "adminIndexFound")) {
                Admin admin = (Admin) session.getAttribute("user");
                String roomId = request.getParameter("roomId");
                String roomPrice = request.getParameter("price");
                String bookedfor = request.getParameter("bookedfor");
                //if (db.isUserExist(bookedfor)) {
                for (int i = 0; i < unavaiablieroomId.size(); i++) {
                    if (unavaiablieroomId.get(i).equals(roomId)) {
                        canBook = false;
                        break;
                    } else {
                        canBook = true;
                    }
                }
                if (canBook) {
                    System.out.print(admin.getUsername());
                    db.CreateStaffBooking(bookingID, roomId, roomPrice,
                            totalStay.replace("Total Stay:  ", ""),
                            totalPrice.replace("Total Price:  $", ""), fromDate, toDate, admin.getUsername(), bookedfor);
                    session.setAttribute("booked", "booked");
                    response.sendRedirect("/hotelmanagement/Admin/AdminRoomTwo.jsp");
                } else {
                    session.setAttribute("same", "same");
                    response.sendRedirect("/hotelmanagement/Admin/AdminRoomTwo.jsp");
                }
                /*} else {
                    session.setAttribute("userNotExist", "User does not exist in the Database.");
                    response.sendRedirect("/hotelmanagement/Admin/AdminIndex.jsp");
                }*/
            }

        } catch (ParseException ex) {
            Logger.getLogger(C303_ConfirmBooking.class
                    .getName()).log(Level.SEVERE, null, ex);
        }
    }

    public static ArrayList<String> createStaffBookingTest(String bookingID, String roomId, String roomPrice, String totalStay,
            String totalPrice, String fromDate, String toDate, String bookedBy, String bookedFor) {

        ArrayList<String> booking = new ArrayList<>();
        booking.add(bookingID);
        booking.add(roomId);
        booking.add(roomPrice);
        booking.add(totalStay);
        booking.add(totalPrice);
        booking.add(fromDate);
        booking.add(toDate);
        booking.add(bookedBy);
        booking.add(bookedFor);

        return booking;
    }

}
