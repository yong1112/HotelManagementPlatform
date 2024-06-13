/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DAO;

import Model.Admin;
import Model.Booking;
import Model.Customer;
import Model.PasswordEncryption;
import Model.Room;
import Model.Staff;
import Model.User;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoDatabase;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import org.bson.Document;

/**
 *
 * @author sorak
 */
public class MongoDBManager {

    MongoDBConnector Mongo = new MongoDBConnector();
    private final MongoDatabase db = Mongo.DBConnect();
    private ArrayList<Document> DatabaseList = new ArrayList();

    MongoCollection<Document> Employee = db.getCollection("Employee");
    MongoCollection<Document> User = db.getCollection("User");
    MongoCollection<Document> Room = db.getCollection("Room");
    MongoCollection<Document> Booking = db.getCollection("Booking");
    Document WhereDocs;

    public void test(String name) {
        WhereDocs = new Document()
                .append("Name", name);
        Employee.insertOne(WhereDocs);
    }

    /* Creates a new Admin user in the Admin table */
    public void CreateAdmin(Admin admin) {
        WhereDocs = new Document()
                .append("email", admin.getUsername())
                .append("password", new PasswordEncryption().getHash(admin.getPassword()))
                .append("type", "Admin");
        User.insertOne(WhereDocs);
    }

    /*  Creates a new Staff member in the User table.
        This includes both "normal" staff member and "Manager" which are defined by position attribute 
     */
    public void CreateStaff(Staff staff) {
        WhereDocs = new Document()
                .append("firstName", staff.getFirstName())
                .append("lastName", staff.getLastName())
                .append("email", staff.getUsername())
                .append("password", new PasswordEncryption().getHash(staff.getPassword()))
                .append("type", "Staff")
                .append("position", staff.getPosition()) // Will be either team member or manager
                .append("active", true);
        User.insertOne(WhereDocs);
    }

    /* Creates a new Customer in the User table. */
    public void CreateCustomer(Customer customer) {
        WhereDocs = new Document()
                .append("firstName", customer.getFirstName())
                .append("lastName", customer.getLastName())
                .append("email", customer.getUsername())
                .append("password", new PasswordEncryption().getHash(customer.getPassword()))
                .append("type", "Customer")
                .append("promotion", customer.isPromotion())
                .append("active", true);
        User.insertOne(WhereDocs);
    }

    //Booking Functions
    //adding customer request
    public void CreateBooking(String bookingID, String roomId, String roomPrice, String totalStay,
            String totalPrice, String fromDate, String toDate, String bookedFor,
            int pillow, int blanket, int slippers, int towel, String others, boolean pickUpService) {
        WhereDocs = new Document()
                .append("bookingID", bookingID)
                .append("roomId", roomId)
                .append("price", roomPrice)
                .append("startDate", fromDate)
                .append("endDate", toDate)
                .append("totalStay", totalStay)
                .append("totalPrice", totalPrice)
                .append("bookedFor", bookedFor)
                .append("pillow", pillow)
                .append("blanket", blanket)
                .append("slippers", slippers)
                .append("towel", towel)
                .append("others", others)
                .append("pickUpService", pickUpService);               
        Booking.insertOne(WhereDocs);
    }

    public ArrayList<Booking> getBooking() {
        WhereDocs = new Document();
        ArrayList<Booking> booking = new ArrayList<Booking>();
        for (Document result : Booking.find(WhereDocs)) {
            booking.add(new Booking(
                    (String) result.get("bookingID"),
                    (String) result.get("roomId"),
                    (String) result.get("price"),
                    (String) result.get("startDate"),
                    (String) result.get("endDate"),
                    (String) result.get("totalStay"),
                    (String) result.get("totalPrice"),
                    (String) result.get("bookedFor"))
            );
        }
        return booking;
    }

    public void CreateStaffBooking(String bookingID, String roomId, String roomPrice, String totalStay,
            String totalPrice, String fromDate, String toDate, String bookedBy, String bookedfor) {
        WhereDocs = new Document()
                .append("bookingID", bookingID)
                .append("roomId", roomId)
                .append("price", roomPrice)
                .append("startDate", fromDate)
                .append("endDate", toDate)
                .append("totalStay", totalStay)
                .append("totalPrice", totalPrice)
                .append("bookedBy", bookedBy)
                .append("bookedFor", bookedfor);
        Booking.insertOne(WhereDocs);
    }

    /* Check if the user is Admin */
    public boolean isAdmin(String username, String password) {
        return User.find(new Document().append("email", username).append("password", new PasswordEncryption().getHash(password))).first().get("type").equals("Admin");
    }
    //
    public boolean isCustomer(String email, String password) {
        return User.find(new Document().append("email", email).append("password", new PasswordEncryption().getHash(password))).first().get("type").equals("Customer");
    }

    public boolean isStaff(String email, String password) {
        return User.find(new Document().append("email", email).append("password", new PasswordEncryption().getHash(password))).first().get("type").equals("Staff");
    }

    /* Find users by username or email 
        Remember that Username is the same as email
     */
//    public User FindUser(String email, String password) {
//        WhereDocs = User.find(new Document().append("email", email).append("password", password)).first();
//        if (WhereDocs.get("type").equals("Customer")) {
//            Customer customer = new Customer(
//                    (String) WhereDocs.get("firstName"),
//                    (String) WhereDocs.get("lastName"),
//                    (String) WhereDocs.get("email"),
//                    (String) WhereDocs.get("password"),
//                    (String) WhereDocs.get("type"),
//                    (boolean) WhereDocs.get("promotion"),
//                    (boolean) WhereDocs.get("active"));
//            return customer;
//
//        } else if (WhereDocs.get("type").equals("Staff")) {
//            Staff staff = new Staff(
//                    (String) WhereDocs.get("firstName"),
//                    (String) WhereDocs.get("lastName"),
//                    (String) WhereDocs.get("email"),
//                    (String) WhereDocs.get("password"),
//                    (String) WhereDocs.get("type"),
//                    (String) WhereDocs.get("position"),
//                    (boolean) WhereDocs.get("active"));
//            return staff;
//        } else {
//            return null;
//        }
//    }
//    
//    public Admin FindStaff(String username, String password) {
//        
//    }
    public Admin FindAdmin(String username, String password) {
        WhereDocs = new Document().append("email", username).append("password", new PasswordEncryption().getHash(password));
        Admin admin = null;

        for (Document result : User.find(WhereDocs)) {
            admin = new Admin(
                    (String) result.get("email"),
                    (String) result.get("password"),
                    (String) result.get("type")
            );
        }

        return admin;
    }

    public Staff FindStaff(String username, String password) {
        WhereDocs = new Document().append("email", username).append("password", new PasswordEncryption().getHash(password));
        Staff staff = null;

        for (Document result : User.find(WhereDocs)) {
            staff = new Staff(
                    (String) result.get("firstName"),
                    (String) result.get("lastName"),
                    (String) result.get("email"),
                    (String) result.get("password"),
                    (String) result.get("type"),
                    (String) result.get("position"),
                    (boolean) result.get("active")
            );
        }

        return staff;
    }

    public Customer FindCustomer(String username, String password) {
        WhereDocs = new Document().append("email", username).append("password", new PasswordEncryption().getHash(password));
        Customer customer = null;

        for (Document result : User.find(WhereDocs)) {
            customer = new Customer(
                    (String) result.get("firstName"),
                    (String) result.get("lastName"),
                    (String) result.get("email"),
                    (String) result.get("password"),
                    (String) result.get("type"),
                    (boolean) result.get("promotion"),
                    (boolean) result.get("active")
            );
        }

        return customer;
    }
    
    /* Delete User - for testing purpose only */
    public void deleteUser(String email) {
        User.deleteOne(new Document("email", email));
    }

    /* Checks for User */
    public boolean isUserExist(String email) {
        return User.find(new Document().append("email", email)).first() != null;
    }
    
    /* Creates a token for the user to recover password */
    public void createUserToken(String email, String token) {
        WhereDocs = User.find(new Document("email", email)).first();
        Date date = new Date();
        
        User.updateOne(
                WhereDocs,
                new Document("$set", new Document("token", token).append("tokenDate", date))
        );
    }
    
    /* Get Name for token */
    public String getNamebyToken(String token) {
        WhereDocs = User.find(new Document("token", token)).first();
        
        String type = WhereDocs.get("type", String.class);
        
        if (type.equals("Admin")) {
            return "Admin";
        } else {
            return WhereDocs.get("firstName", String.class);
        }
    }
    
    /* Deletes the token if expired */
    public void deleteUserToken(String token) {
        User.updateOne(
                new Document("token", token),
                new Document("$unset", new Document("token", "").append("tokenDate", ""))
        );    
    }
    
    /* Check if the token exists in the database */
    public boolean isTokenExist(String token) {
        return User.find(new Document("token", token)).first() != null;
    }
    
    /* Gets token time difference e.g. tokenDate - currentDate = diffInTime*/
    public long getTokenTimeDiff(String token) {
        WhereDocs = User.find(new Document("token", token)).first();
        Date currentDate = new Date();
        Date tokenDate = WhereDocs.get("tokenDate", Date.class);
        
        return currentDate.getTime() - tokenDate.getTime();
    }
    
    /* Reset Password from token */
    public void resetPasswordbyToken(String token, String password) {
        String newPassword = new PasswordEncryption().getHash(password);
        
        WhereDocs = User.findOneAndUpdate(
                new Document()
                        .append("token", token),
                new Document()
                        .append("$set", new Document("password", newPassword))
                        .append("$unset", new Document("token", "").append("tokenDate", ""))
        );
    }

    public boolean isRoomIdExist(String roomNo) {
        return Room.find(new Document().append("roomNum", roomNo)).first() != null;
    }

    //Room management
    public void createRoom(Room room) {
        WhereDocs = new Document()
                .append("roomName", room.getRoomName())
                .append("roomNum", room.getRoomNum())
                .append("roomPrice", room.getRoomPrice())
                .append("adultCapacity", room.getAdultCapacity())
                .append("childCapacity", room.getChildCapacity())
                .append("description", room.getDescription())
                .append("availability", room.getAvailability());
        Room.insertOne(WhereDocs);
    }

    //testing create booking
    /*public ArrayList<Room> createRoomTest(String roomName, String roomNum, String roomPrice, String adultCapacity, String childCapacity) {
        WhereDocs = new Document()
                .append("roomName", roomName)
                .append("roomNum", roomNum)
                .append("roomPrice", roomPrice)
                .append("adultCapacity", adultCapacity)
                .append("childCapacity", childCapacity);
        Room.insertOne(WhereDocs);
    }*/
    public ArrayList<Room> GetRoomEdit() {
        WhereDocs = new Document();
        ArrayList<Room> room = new ArrayList<Room>();
        for (Document result : Room.find(WhereDocs)) {
            room.add(new Room(
                    (String) result.get("roomName"),
                    (String) result.get("roomNum"),
                    (String) result.get("roomPrice"),
                    (String) result.get("adultCapacity"),
                    (String) result.get("childCapacity"),
                    (String) result.get("description"),
                    (String) result.get("availability"),
                    (String) result.get("roomImage"))
            );
        }
        return room;
    }

    public Room GetRoomById(String roomId) {
        WhereDocs = new Document("roomNum", roomId);
        Room room = null;
        for (Document result : Room.find(WhereDocs)) {
            room = new Room(
                    (String) result.get("roomName"),
                    (String) result.get("roomNum"),
                    (String) result.get("roomPrice"),
                    (String) result.get("adultCapacity"),
                    (String) result.get("childCapacity"),
                    (String) result.get("description"),
                    (String) result.get("availability"),
                    (String) result.get("roomImage")
            );
        }
        return room;
    }

    public void deleteRoom(String roomNumber) {
        WhereDocs = new Document("roomNum", roomNumber);
        Room.deleteOne(WhereDocs);
    }


    /*public ArrayList<Room> GetRoomByNum(String roomNum) {
        WhereDocs = new Document().append("roomNum", roomNum);
        ArrayList<Room> room = new ArrayList<Room>();
        for (Document result : Room.find(WhereDocs)) {
            room.add(new Room(
                    (String) result.get("roomName"),
                    (String) result.get("roomNum"),
                    (String) result.get("roomPrice"),
                    (String) result.get("roomCapacity"),
                    (String) result.get("availability"))
            );
        }
        return room;
    }*/
    public ArrayList<String> GetRoomList() {
        ArrayList<String> RoomList = new ArrayList<String>();
        WhereDocs = new Document();
        for (Document result : Room.find(WhereDocs)) {
            RoomList.add((String) result.get("roomName"));
            RoomList.add((String) result.get("roomNum"));
            RoomList.add((String) result.get("roomPrice"));
            RoomList.add((String) result.get("adultCapacity"));
            RoomList.add((String) result.get("childCapacity"));
            RoomList.add((String) result.get("description"));
            RoomList.add((String) result.get("availability"));
            RoomList.add((String) result.get("roomImage"));
        }
        return RoomList;
    }

    public Room GetRoomDetails(String roomNumber) {
        WhereDocs = new Document().append("roomNum", roomNumber);
        Room room = null;

        for (Document result : Room.find(WhereDocs)) {
            room = new Room(
                    (String) result.get("roomName"),
                    (String) result.get("roomNum"),
                    (String) result.get("roomPrice"),
                    (String) result.get("adultCapacity"),
                    (String) result.get("childCapacity"),
                    (String) result.get("description"),
                    (String) result.get("availability"),
                    (String) result.get("roomImage")
            );
        }
        return room;
    }

    public Room editRoomDetails(String newRoomName, String roomNum, String newRoomPrice,
            String newAdultCapacity, String newChildCapacity, String newDescription) {

        Room room = null;
        Document changing = new Document()
                .append("$set", new Document()
                        .append("roomName", newRoomName)
                        .append("roomPrice", newRoomPrice)
                        .append("adultCapacity", newAdultCapacity)
                        .append("childCapacity", newChildCapacity)
                        .append("description", newDescription));

        Document lookingFor = new Document().append("roomNum", roomNum);

        Room.updateOne(lookingFor, changing);
        WhereDocs = new Document().append("roomNum", roomNum);
        for (Document result : Room.find(WhereDocs)) {
            room = new Room(
                    (String) result.get("roomName"),
                    (String) result.get("roomNum"),
                    (String) result.get("roomPrice"),
                    (String) result.get("adultCapacity"),
                    (String) result.get("childCapacity"),
                    (String) result.get("description"));
        }

        return room;
    }

    
    public Customer editCustomerDetails(String username, String newFirstName, String newLastName, String newPassword) {

        Customer user = null;
        Document changing = new Document()
                .append("$set", new Document()
                        .append("firstName", newFirstName)
                        .append("lastName", newLastName)
                        .append("password", new PasswordEncryption().getHash(newPassword)));

        Document lookingFor = new Document().append("email", username);

        User.updateOne(lookingFor, changing);
        WhereDocs = new Document().append("email", username);
        for (Document result : User.find(WhereDocs)) {
            user = new Customer(
                    (String) result.get("firstName"),
                    (String) result.get("lastName"),
                    (String) result.get("email"),
                    (String) result.get("password"),
                    (String) result.get("type"),
                    (boolean) result.get("promotion"),
                    (boolean) result.get("active"));
        }

        return user;

        /*Document HereDocs;
            WhereDocs = new Document()
                    .append("email", username);
            HereDocs = new Document()
                    .append("email", newuser);
            User.find(WhereDocs);
            User.updateOne(WhereDocs, HereDocs);    
         */
    }

    public ArrayList<String> GetUserList() {
        ArrayList<String> UserList = new ArrayList<String>();
        WhereDocs = new Document();
        for (Document result : User.find(WhereDocs)) {
            UserList.add((String) result.get("firstName"));
            UserList.add((String) result.get("lastName"));
            UserList.add((String) result.get("email"));
            UserList.add((String) result.get("password"));
            UserList.add((String) result.get("type"));
        }
        return UserList;
    }

    public ArrayList<Staff> GetStaffEdit() {
        WhereDocs = new Document();
        ArrayList<Staff> staff = new ArrayList<Staff>();
        for (Document result : User.find(WhereDocs)) {
            staff.add(new Staff(
                    (String) result.get("firstName"),
                    (String) result.get("lastName"),
                    (String) result.get("email"),
                    (String) result.get("password"),
                    (String) result.get("type"))
            );
        }
        return staff;
    }

    public ArrayList<Customer> getAllCustomers() {
        WhereDocs = new Document().append("type", "Customer");
        ArrayList<Customer> customer = new ArrayList<Customer>();
        for (Document result : User.find(WhereDocs)) {
            customer.add(new Customer(
                    (String) result.get("firstName"),
                    (String) result.get("lastName"),
                    (String) result.get("email"),
                    (String) result.get("password"),
                    (String) result.get("type"),
                    (boolean) result.get("promotion"),
                    (boolean) result.get("active")));
        }
        return customer;
    }

    public Customer FindCustomerDetails(String username) {
        WhereDocs = new Document().append("email", username);
        Customer customer = null;

        for (Document result : User.find(WhereDocs)) {
            customer = new Customer(
                    (String) result.get("firstName"),
                    (String) result.get("lastName"),
                    (String) result.get("email"),
                    (String) result.get("password"),
                    (String) result.get("type"),
                    (boolean) result.get("promotion"),
                    (boolean) result.get("active")
            );
        }
        return customer;
    }

    public ArrayList<Staff> getAllStaff() {
        WhereDocs = new Document().append("position", "Team member");
        ArrayList<Staff> staff = new ArrayList<Staff>();
        for (Document result : User.find(WhereDocs)) {
            staff.add(new Staff(
                    (String) result.get("firstName"),
                    (String) result.get("lastName"),
                    (String) result.get("email"),
                    (String) result.get("password"),
                    (String) result.get("type"),
                    (String) result.get("position"),
                    (boolean) result.get("active")));
        }
        return staff;
    }

    public Staff FindStaffDetails(String username) {
        WhereDocs = new Document().append("email", username);
        Staff staff = null;

        for (Document result : User.find(WhereDocs)) {
            staff = new Staff(
                    (String) result.get("firstName"),
                    (String) result.get("lastName"),
                    (String) result.get("email"),
                    (String) result.get("password"),
                    (String) result.get("type"),
                    (String) result.get("position"),
                    (boolean) result.get("active")
            );
        }
        return staff;
    }

    public Staff editStaffDetails(String username, String newFirstName, String newLastName, String newPassword) {

        Staff staff = null;
        Document changing = new Document()
                .append("$set", new Document()
                        .append("firstName", newFirstName)
                        .append("lastName", newLastName)
                        .append("password", new PasswordEncryption().getHash(newPassword)));

        Document lookingFor = new Document().append("email", username);

        User.updateOne(lookingFor, changing);
        WhereDocs = new Document().append("email", username);
        for (Document result : User.find(WhereDocs)) {
            staff = new Staff(
                    (String) result.get("firstName"),
                    (String) result.get("lastName"),
                    (String) result.get("email"),
                    (String) result.get("password"),
                    (String) result.get("type"),
                    (String) result.get("position"),
                    (boolean) result.get("active"));
        }

        return staff;
    }

    public Admin editAdminDetails(String username, String newPassword) {

        Admin admin = null;
        Document changing = new Document()
                .append("$set", new Document()
                        .append("password", new PasswordEncryption().getHash(newPassword)));

        Document lookingFor = new Document().append("email", username);

        User.updateOne(lookingFor, changing);
        WhereDocs = new Document().append("email", username);
        for (Document result : User.find(WhereDocs)) {
            admin = new Admin(
                    (String) result.get("email"),
                    (String) result.get("password"),
                    (String) result.get("type"));
        }

        return admin;
    }

    public ArrayList<Staff> getAllManagers() {
        WhereDocs = new Document().append("position", "Manager");
        ArrayList<Staff> staff = new ArrayList<Staff>();
        for (Document result : User.find(WhereDocs)) {
            staff.add(new Staff(
                    (String) result.get("firstName"),
                    (String) result.get("lastName"),
                    (String) result.get("email"),
                    (String) result.get("password"),
                    (String) result.get("type"),
                    (String) result.get("position"),
                    (boolean) result.get("active")));
        }
        return staff;
    }

    public Staff manEditStaff(String username, String newFirstName, String newLastName, String newPassword, String newPosition) {

        Staff staff = null;
        Document changing = new Document()
                .append("$set", new Document()
                        .append("firstName", newFirstName)
                        .append("lastName", newLastName)
                        .append("password", new PasswordEncryption().getHash(newPassword))
                        .append("position", newPosition));

        Document lookingFor = new Document().append("email", username);

        User.updateOne(lookingFor, changing);
        WhereDocs = new Document().append("email", username);
        for (Document result : User.find(WhereDocs)) {
            staff = new Staff(
                    (String) result.get("firstName"),
                    (String) result.get("lastName"),
                    (String) result.get("email"),
                    (String) result.get("password"),
                    (String) result.get("type"),
                    (String) result.get("position"),
                    (boolean) result.get("active"));
        }

        return staff;
    }
    //Booking History

    public ArrayList<String> getMyBooking(String email) {
        WhereDocs = new Document().append("bookedFor", email);
        ArrayList<String> myBooking = new ArrayList<String>();
        for (Document result : Booking.find(WhereDocs)) {
            myBooking.add((String) result.get("bookingID"));
            myBooking.add((String) result.get("roomId"));
            myBooking.add((String) result.get("startDate"));
            myBooking.add((String) result.get("endDate"));
            myBooking.add((String) result.get("totalStay"));
            myBooking.add((String) result.get("totalPrice"));
        }
        return myBooking;
    }

    public ArrayList<String> getAllBooking() {
        ArrayList<String> allBooking = new ArrayList<String>();
        WhereDocs = new Document();
        for (Document result : Booking.find(WhereDocs)) {
            allBooking.add((String) result.get("bookingID"));
            allBooking.add((String) result.get("roomId"));
            allBooking.add((String) result.get("price"));
            allBooking.add((String) result.get("startDate"));
            allBooking.add((String) result.get("endDate"));
            allBooking.add((String) result.get("totalStay"));
            allBooking.add((String) result.get("totalPrice"));
            allBooking.add((String) result.get("bookedFor"));
        }
        return allBooking;
    }

    public ArrayList<String> getBookingID() {
        WhereDocs = new Document();
        ArrayList<String> bookingID = new ArrayList<String>();
        for (Document result : Booking.find(WhereDocs)) {
            bookingID.add((String) result.get("bookingID"));
        }
        return bookingID;
    }

    public void cancelBooking(String bookingID) {
        WhereDocs = new Document()
                .append("bookingID", bookingID);
        Booking.deleteOne(WhereDocs);
    }

    public Booking FindBookingDetails(String bookingID) {
        WhereDocs = new Document().append("bookingID", bookingID);

        Booking booking = null;

        for (Document result : Booking.find(WhereDocs)) {
            booking = new Booking(
                    (String) result.get("bookingID"),
                    (String) result.get("roomId"),
                    (String) result.get("price"),
                    (String) result.get("startDate"),
                    (String) result.get("endDate"),
                    (String) result.get("totalStay"),
                    (String) result.get("totalPrice"),
                    (String) result.get("bookedFor")
            );
        }
        return booking;
    }

    public Booking editBooking(String bookingID, String roomId, String roomPrice, String newStartDate, String newEndDate, String newTotalStay, String newTotalPrice, String bookedFor) {

        Booking booking = null;
        Document changing = new Document()
                .append("$set", new Document()
                        .append("startDate", newStartDate)
                        .append("endDate", newEndDate)
                        .append("totalStay", newTotalStay)
                        .append("totalPrice", newTotalPrice));

        Document lookingFor = new Document()
                .append("bookingID", bookingID)
                .append("roomId", roomId)
                .append("price", roomPrice)
                .append("bookedFor", bookedFor);

        Booking.updateOne(lookingFor, changing);
        WhereDocs = new Document()
                .append("bookingID", bookingID)
                .append("roomId", roomId)
                .append("roomPrice", roomPrice)
                .append("bookedFor", bookedFor);
        for (Document result : Booking.find(WhereDocs)) {
            booking = new Booking(
                    (String) result.get("bookingID"),
                    (String) result.get("roomId"),
                    (String) result.get("price"),
                    (String) result.get("startDate"),
                    (String) result.get("endDate"),
                    (String) result.get("totalStay"),
                    (String) result.get("totalPrice"),
                    (String) result.get("bookedFor"));
        }

        return booking;
    }

    public boolean BookingExistence(String cusEmail, String startDate, String staffEmail) {

        Document lookingFor = new Document().append("bookingFor", cusEmail)
                .append("startDate", startDate)
                .append("bookedBy", staffEmail);
        ArrayList<String> results = new ArrayList<String>();

        /*for (Document result : Booking.find(lookingFor)) {
            results.add((String) result.get("roomId"));
            results.add((String) result.get("price"));
            results.add((String) result.get("startDate"));
            results.add((String) result.get("endDate"));
            results.add((String) result.get("totalStay"));
            results.add((String) result.get("totalPrice"));
            results.add((String) result.get("bookedFor"));
            results.add((String) result.get("bookedBy"));
        }*/
        return (Booking.find(lookingFor) != null);
    }

    public boolean BookingNotExist(String bookingID) {

        Document lookingFor = new Document().append("bookingID", bookingID);

        return (Booking.find(lookingFor) == null);
    }
    
    //extra service and items
    public Booking customerRequest(String bookingID, int newPillow, int newBlanket, int newSlippers, int newTowel, String newOthers, boolean newPickUpService) {

        Booking booking = null;
        Document changing = new Document()
                .append("$set", new Document()
                        .append("pillow", newPillow)
                        .append("blanket", newBlanket)
                        .append("slippers", newSlippers)
                        .append("towel", newTowel)
                        .append("others", newOthers)
                        .append("pickUpService", newPickUpService));

        Document lookingFor = new Document().append("bookingID", bookingID);

        Booking.updateOne(lookingFor, changing);
        WhereDocs = new Document().append("bookingID", bookingID);
        for (Document result : Booking.find(WhereDocs)) {
            booking = new Booking(
                    (String)result.get("bookingID"),
                    (int) result.get("pillow"),
                    (int) result.get("blanket"),
                    (int) result.get("slippers"),
                    (int) result.get("towel"),
                    (String) result.get("others"),
                    (boolean) result.get("pickUpService"));
                    
        }

        return booking;
    }
    
    //yong
    //get booking list by ID for customer request C501
    //List can contain all types of data, Arraylist can only contain string
    public Booking getBookingRequest(String myBookingID) {
        WhereDocs = new Document().append("bookingID", myBookingID);
        Booking booking = null;

        for (Document result : Booking.find(WhereDocs)) {
            booking = new Booking(
                    (String) result.get("bookingID"),
                    (int) result.get("pillow"),
                    (int) result.get("blanket"),
                    (int) result.get("slippers"),
                    (int) result.get("towel"),
                    (String) result.get("others"),
                    (boolean) result.get("pickUpService")
                    
            );
        }
        return booking;
    }
    
       /* public ArrayList<Object> getItemList() {
        ArrayList<Object> itemList = new ArrayList<Object>();
        WhereDocs = new Document();
        for (Document result : Booking.find(WhereDocs)) {
            itemList.add((String) result.get("bookingID"));
            itemList.add((int) result.get("pillow"));
            itemList.add((int) result.get("blanket"));
            itemList.add((int) result.get("slippers"));
            itemList.add((int) result.get("towel"));
            itemList.add((String) result.get("others"));
            itemList.add((boolean) result.get("pickUpService"));
        }
        return itemList;
    }*/

}
