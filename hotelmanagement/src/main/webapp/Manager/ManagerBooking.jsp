<%@page import="DAO.MongoDBManager"%>
<%@page import="Model.Booking"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <script src="/hotelmanagement/JavaScript/LocationReplace.js"></script>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <script src="https://code.jquery.com/jquery-3.1.1.min.js" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/semantic-ui@2.4.2/dist/semantic.min"></script>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/semantic-ui@2.4.2/dist/semantic.min.css">

        <title>All Bookings</title>
    </head>
    <%
        String checkLogin = (String) session.getAttribute("managerLoginCheck");
    %>
    <body onload="checkLogin()">
        <div>
            <!-- Top menu bar !-->
            <div class="ui inverted vertical center aligned segment">
                <div class="ui container">
                    <div class="ui large secondary inverted pointing menu">
                        <a onClick="ToManagerIndex()" class="item">
                            HOME
                        </a>
                        <a onClick="ToManagerRoom()" class="item">
                            ROOMS
                        </a>
                        <a onClick="ToManagerRoomManage()" class="item">
                            ROOM MANAGEMENT
                        </a>
                        <a onClick="ToManagerDining()" class="item">
                            DINING 
                        </a>
                        <a onClick="ToManagerAbout()" class="item">
                            ABOUT US
                        </a>
                        <a onClick="ToManagerContact()" class="item">
                            CONTACT 
                        </a>
                        <a onClick="ToManagerBooking()" class="active item">
                            VIEW BOOKINGS
                        </a>
                        <a onClick="ToManagerAccountsList()" class="item">
                            VIEW ACCOUNTS
                        </a>
                        <a onClick="ToManagerRegister()" class="item">
                            CREATE AN ACCOUNT
                        </a>

                        <div class="right item">
                            <a onClick="ToManagerAccount()" class="ui right floated inverted button" style="margin-right: 10px">My Account</a>
                            <a onClick="ToHome()" class="ui right floated inverted button">Log Out</a>
                        </div>
                    </div>
                </div>   
            </div>
        </div>       
        <div style="margin-top: 10px; margin-left: 50px; margin-bottom: 50px;">
            <!-- Site content !-->
            <h1 class="ui header">All Bookings</h1>
            <button class ="ui blue button" type="submit" onClick="ToManEditBooking()">Edit a booking</button>
            <button class ="ui blue button" type="submit" onClick="ToManCancelBooking()">Cancel a booking</button>
        </div>
        <div style="margin-top: 20px; margin-right: 150px; margin-left: 150px">
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
                    </tr>
                    <%}%>
                </tbody>
            </table>
        </div>
    </body>
</html>
<script src="https://code.jquery.com/jquery-3.5.1.js" ></script>
<script src="https://cdn.datatables.net/1.10.25/js/jquery.dataTables.min.js" ></script>
<script src="https://cdn.datatables.net/1.10.25/js/dataTables.semanticui.min.js" ></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/semantic-ui/2.3.1/semantic.min.js" ></script>
<script>
        function checkLogin() {
            const checkManagerLogin = "" + "<%=checkLogin%>";
            if (checkManagerLogin === ("null")) {
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

