<%@page import="Model.Booking"%>
<%@page import="Model.Room"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.time.temporal.ChronoUnit"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="java.time.LocalDate"%>
<%@page import="DAO.MongoDBManager"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <script src="/hotelmanagement/JavaScript/LocationReplace.js"></script>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <script src="https://code.jquery.com/jquery-3.1.1.min.js" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/semantic-ui@2.4.2/dist/semantic.min"></script>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/semantic-ui@2.4.2/dist/semantic.min.css">

        <title>Hotel Management System</title>
    </head>
    <%
        String checkLogin = (String) session.getAttribute("staffLoginCheck");
    %>
    <body onload="checkLogin()">
        <div>
            <!-- Top menu bar !-->
            <div class="ui inverted vertical center aligned segment">
                <div class="ui container">
                    <div class="ui large secondary inverted pointing menu">
                        <a onClick="ToStaffIndex()" class="item">
                            HOME
                        </a>
                        <a onClick="ToStaffRoom()" class="item">
                            ROOMS
                        </a>
                        <a onClick="ToStaffDining()" class="item">
                            DINING 
                        </a>
                        <a onClick="ToStaffAbout()" class="item">
                            ABOUT US
                        </a>
                        <a onClick="ToStaffContact()" class="item">
                            CONTACT 
                        </a>
                        <a onClick="ToStaffBooking()" class="active item">
                            VIEW BOOKINGS
                        </a>
                        <a onClick="ToStaffViewAccounts()" class="item">
                            VIEW ACCOUNTS 
                        </a>
                        <div class="right item">
                            <a onClick="ToStaffAccount()" class="ui right floated inverted button" style="margin-right: 10px">My Account</a>
                            <a onClick="ToHome()" class="ui right floated inverted button">Log Out</a>
                        </div>
                    </div>   
                </div>
            </div>
        </div>
        <div style="margin-top: 10px; margin-left: 50px; margin-bottom: 20px;">
            <!-- Site content !-->
            <h1 class="ui header">Cancel a Booking</h1>
            <button class ="ui blue button" type="submit" onClick="ToChooseEditBooking()">Edit a booking</button>
            <button class ="ui blue button" type="submit" onClick="ToCancelBooking()">Cancel a booking</button>
        </div>

        <div style="margin-top: 20px; margin-right: 150px; margin-left: 150px">
            <form action="/hotelmanagement/C403_StaffCancelBooking" method="GET">
                <table id ="table" class="ui large celled striped table">
                    <thead>
                        <tr>
                            <th>Booking ID</th>
                            <th>Room Number</th>
                            <th>Price per night</th>
                            <th>Check In</th>
                            <th>Check Out</th>
                            <th>Period of stay</th>
                            <th>Total price</th>
                            <th>Booked for</th>
                            <th></th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            MongoDBManager db = (MongoDBManager) session.getAttribute("Query");

                            if (db == null) {
                                db = new MongoDBManager();
                                session.setAttribute("Query", db);
                            }

                            ArrayList<String> allBooking = db.getAllBooking();
                            for (int i = 0; i < allBooking.size(); i += 8) {
                        %>
                        <tr>
                            <td><%=allBooking.get(i)%></td>
                            <td><%=allBooking.get(i + 1)%></td>
                            <td><%=allBooking.get(i + 2)%></td>
                            <td><%=allBooking.get(i + 3)%></td>
                            <td><%=allBooking.get(i + 4)%></td>
                            <td><%=allBooking.get(i + 5)%></td>
                            <td><%=allBooking.get(i + 6)%></td>
                            <td><%=allBooking.get(i + 7)%></td>
                            <td><button type="submit" class="ui red button" name="bookingID" value="<%=allBooking.get(i)%>">Cancel</button></td>
                        </tr>
                        <%}%>
                    </tbody>
                </table>
            </form>
        </div>
    </body>
</html>
<script src="https://code.jquery.com/jquery-3.5.1.js" ></script>
<script src="https://cdn.datatables.net/1.10.25/js/jquery.dataTables.min.js" ></script>
<script src="https://cdn.datatables.net/1.10.25/js/dataTables.semanticui.min.js" ></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/semantic-ui/2.3.1/semantic.min.js" ></script>
<script>
    function checkLogin() {
        const checkStaffLogin = "" + "<%=checkLogin%>";
        if (checkStaffLogin === ("null")) {
            setTimeout(() => {
                ;
            }, 0);
            window.location.href = "http://localhost:8080/hotelmanagement/";
        }
    }
    $(document).ready(function () {
        $('#table').DataTable();
    });
</script>
</script>

