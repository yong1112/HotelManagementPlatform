<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="java.time.temporal.ChronoUnit"%>
<%@page import="java.time.LocalDate"%>
<%@page import="java.awt.Image"%>
<%@page import="java.util.LinkedList"%>
<%@page import="java.util.ArrayList"%>
<%@page import="Model.Room"%>
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

        <title>Room Management</title>
    </head>
    <script src="/hotelmanagement/JavaScript/LocationReplace.js"></script>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <script src="https://code.jquery.com/jquery-3.1.1.min.js" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/semantic-ui@2.4.2/dist/semantic.min"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/semantic-ui@2.4.2/dist/semantic.min.css">
    <title>Rooms</title>
    <%
        String checkLogin = (String) session.getAttribute("managerLoginCheck");
        String booked = "" + (String) session.getAttribute("booked");
        String found = "" + (String) session.getAttribute("found");
        String notFound = "" + (String) session.getAttribute("notFound");
        String noAmount = "" + (String) session.getAttribute("noAmount");
        String newFromDate = (String) session.getAttribute("fromDate");
        String newToDate = (String) session.getAttribute("toDate");
        String exsitingBooking = (String) session.getAttribute("same");
        // To start the page
        if (found.equals("null")) {
            found = "empty";
        } else {
            found = (String) session.getAttribute("found");
        }

        //Running MongoDB
        MongoDBManager db = (MongoDBManager) session.getAttribute("Query");
        if (db == null) {
            db = new MongoDBManager();
            session.setAttribute("Query", db);
        }
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
                        <a onClick="ToManagerRoomManage()" class="active item">
                            ROOM MANAGEMENT
                        </a>
                        <a onClick="ToManagerDining()" class="item">
                            DINING 
                        </a>
                        <a onClick="ToManagerAbout()" class=" item">
                            ABOUT US
                        </a>
                        <a onClick="ToManagerContact()" class="item">
                            CONTACT 
                        </a>
                        <a onClick="ToManagerBooking()" class="item">
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
        <div style="margin-top: 10px; margin-left: 50px">
            <!-- Header !-->
            <h1 class="ui header">ROOMS</h1>
        </div>
        <div style="margin-top: 20px; margin-right: 150px; margin-left: 150px">
            <!-- Site content !-->
            <button class ="ui blue button" type="button" onClick="ToCreateRoom()">Create Room</button>
        </div>

        <div style="margin-top: 20px; margin-right: 150px; margin-left: 150px">
            <table id ="example" class="ui large celled striped table">
                <thead>
                    <tr><th>Room Name</th>
                        <th>Room Number</th>
                        <th>Room Price</th>
                        <th>Adult Capacity</th>
                        <th>Child Capacity</th>
                        <th>Room status</th>
                        <th>Room description</th>
                        <th>Edit Room</th>
                        <th>Delete Room</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        if (db == null) {
                            db = new MongoDBManager();
                            session.setAttribute("Query", db);
                        }

                        ArrayList<String> RoomList = db.GetRoomList();
                        for (int i = 0; i < RoomList.size(); i += 8) {
                    %>
                    <tr>
                        <td><%=RoomList.get(i)%></td>
                        <td><%=RoomList.get(i + 1)%></td>
                        <td><%=RoomList.get(i + 2)%></td>
                        <td><%=RoomList.get(i + 3)%></td>
                        <td><%=RoomList.get(i + 4)%></td>
                        <td><%=RoomList.get(i + 5)%></td>
                        <td><%=RoomList.get(i + 6)%></td>
                <form action="/hotelmanagement/C204_EditRoom" method="GET">   
                    <td>
                        <button class ="ui blue button" type="submit" name="editButton" value="<%=RoomList.get(i + 1)%>">Edit</button>
                    </td>
                </form>
                <form action="/hotelmanagement/C203_DeleteRoom" method="post">
                    <td><button type="submit" class="ui red button" name="roomNum" value="<%=RoomList.get(i + 1)%>">Delete</button></td>
                </form>   
                <%}%>
                </tr>
                </tbody>
            </table>
        </div>

        <br>

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
                    const booked = "" + "<%=booked%>";
                    const notFound = "" + "<%=notFound%>";
                    const noAmount = "" + "<%=noAmount%>";
                    if (checkManagerLogin === ("null")) {
                        setTimeout(() => {
                            ;
                        }, 0);
                        window.location.href = "http://localhost:8080/hotelmanagement/";
                    } else if (userNotExist !== ("null")) {
                        alert("User does not exist in database.");
                    } else if (booked !== ("null")) {
                        alert("Booked room Successfully");
                    } else if (notFound !== ("null")) {
                        alert("There is no room avaiable during the period");
                    } else if (noAmount !== ("null")) {
                        alert("There is no adult or child numbers suit you");
                    } else if (exsitingBooking !== ("null")) {
                        alert("Selected booking period is unavaiable");
                    }
                }

                $(document).ready(function () {
                    $('#example').DataTable();
                });
                function ToEditRoom() {
                    window.location = "/hotelmanagement/Manager/EditRoom.jsp";
                }

</script>
<%
    session.removeAttribute("booked");
    session.removeAttribute("found");
    session.removeAttribute("notFound");
    session.removeAttribute("noAmount");
    session.removeAttribute("fromDate");
    session.removeAttribute("toDate");
    session.removeAttribute("same");
    session.removeAttribute("userNotExist");
%>
</html>
