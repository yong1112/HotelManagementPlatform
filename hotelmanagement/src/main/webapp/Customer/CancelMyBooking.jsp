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
        String checkLogin = (String) session.getAttribute("customerLoginCheck");
    %>
    <body onload="registerCheck()">
        <div>
            <!-- Top menu bar !-->
            <div class="ui inverted vertical center aligned segment">
                <div class="ui container">
                    <div class="ui large secondary inverted pointing menu">
                        <a onClick="ToCustomerIndex()" class="item">
                            HOME
                        </a>
                        <a onClick="ToCustomerRoom()" class="item">
                            ROOMS
                        </a>
                        <a onClick="ToCustomerDining()" class="item">
                            DINING 
                        </a>
                        <a onClick="ToCustomerAbout()" class="item">
                            ABOUT US
                        </a>
                        <a onClick="ToCustomerContact()" class="item">
                            CONTACT 
                        </a>
                        <a onClick="ToMyBooking()" class="active item">
                            MY BOOKING
                        </a>
                        <div class="right item">
                            <a onClick="ToCustomerAccount()" class="ui right floated inverted button" style="margin-right: 10px">My Account</a>
                            <a onClick="ToHome()" class="ui right floated inverted button">Log Out</a>
                        </div>
                    </div>   
                </div>
            </div>
        </div>
        <div style="margin-top: 10px; margin-left: 50px; margin-bottom: 50px;">
            <!-- Site content !-->
            <h1 class="ui header">Cancel a Booking</h1>
            <a onClick="ToCancelMyBooking()" class="ui right floated inverted button" style="margin-right: 10px">Cancel</a>
        </div>
        <form action="/hotelmanagement/C402_CancelMyBooking" method="GET">
            <div style="margin-left: 300px; margin-right:300px">
                <table class="ui celled table">
                    <thead>
                        <tr>
                            <th>Booking ID</th>
                            <th>Room Number</th>
                            <th>Check In</th>
                            <th>Check Out</th>
                            <th>Period of stay</th>
                            <th>Total price</th>
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

                            String username = (String) session.getAttribute("username");
                            ArrayList<String> myBooking = db.getMyBooking(username);
                            for (int i = 0; i < myBooking.size(); i += 6) {
                        %>
                        <tr>
                            <td><%=myBooking.get(i)%></td>
                            <td><%=myBooking.get(i + 1)%></td>
                            <td><%=myBooking.get(i + 2)%></td>
                            <td><%=myBooking.get(i + 3)%></td>
                            <td><%=myBooking.get(i + 4)%></td>
                            <td><%=myBooking.get(i + 5)%></td>
                            <td><button type="submit" class="ui red button" name="bookingID" value="<%=myBooking.get(i)%>">Cancel</button></td>
                        </tr>
                        <%}%>
                    </tbody>
                </table>
            </div>
        </form>

        <script>
            function registerCheck()
            {
                const checkCustomerLogin = "" + "<%=checkLogin%>";
                if (checkCustomerLogin === ("null")) {
                    setTimeout(() => {
                        ;
                    }, 0);
                    window.location.href = "http://localhost:8080/hotelmanagement/";
                }
        </script>
    </body>
</html>
