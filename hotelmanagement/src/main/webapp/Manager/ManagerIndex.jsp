<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="java.time.temporal.ChronoUnit"%>
<%@page import="java.time.LocalDate"%>
<%@page import="Model.Room"%>
<%@page import="java.util.ArrayList"%>
<%@page import="DAO.MongoDBManager"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <script src="/hotelmanagement/JavaScript/LocationReplace.js" > </script> 
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <script src="https://code.jquery.com/jquery-3.1.1.min.js" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/semantic-ui@2.4.2/dist/semantic.min"></script>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/semantic-ui@2.4.2/dist/semantic.min.css">

        <title>Hotel Management System</title>
    </head>
    <%
        String checkLogin = (String) session.getAttribute("managerLoginCheck");
        String booked = "" + (String) session.getAttribute("booked");
        String found = "" + (String) session.getAttribute("found");
        String notFound = "" + (String) session.getAttribute("notFound");
        String noAmount = "" + (String) session.getAttribute("noAmount");
        String newFromDate = (String) session.getAttribute("fromDate");
        String newToDate = (String) session.getAttribute("toDate");
        String exsitingBooking = (String) session.getAttribute("same");
        String userNotExist = (String) session.getAttribute("userNotExist");

        //To start the page
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
                        <a onClick="ToManagerIndex()" class="active item">
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
            <!-- Site content !-->
            <h1 class="ui header">WELCOME TO HOTEL MANAGEMENT SYSTEM</h1>
        </div>
        <form action="/hotelmanagement/C301_RoomAvaiabilityCheck" method="post">
            <div style="margin-top: 10px; margin-left: 50px">
                <!-- Site content !-->
                <h3>Select Date:</h3>
                <div class="ui fluid action input">
                    <label for="from">From</label>
                    <div class="ui input">
                        <input type="date" name="fromDate" required>
                    </div>
                    <label for="to">to</label>
                    <div class="ui input">
                        <input type="date" name="toDate" required="">
                    </div>
                    &nbsp;
                    <select class="ui dropdown" required name="adult">
                        <option value="0">0</option>
                        <option value="1">1</option>
                        <option value="2">2</option>
                        <option value="3">3</option>
                        <option value="4">4</option>
                        <option value="5">5</option>
                    </select>
                    &nbsp;
                    <select class="ui dropdown" required name="child">
                        <option value="0">0</option>
                        <option value="1">1</option>
                        <option value="2">2</option>
                        <option value="3">3</option>
                        <option value="4">4</option>
                        <option value="5">5</option>
                    </select>
                    <input type="hidden" name="index" value="managerIndex">
                    <button type="submit" class="ui button">Search</button>
                </div>
            </div>
        </form>
        <%--<%if (found.equals("empty") || notFound.equals("notFound") || noAmount.equals("noAmount")) {
                ArrayList<Room> existingRoom = db.GetRoomEdit();
                for (int i = 0; i < existingRoom.size(); i++) {
        %>
        <form action="/hotelmanagement/C302_DisplayConfirmation" method="post">
            <div class="ui link cards">
                <div class="card">
                    <div class="image">
                        <img src="/images/avatar2/large/matthew.png">
                    </div>
                    <div class="content">
                        <div class="header"><%=existingRoom.get(i).getRoomName()%></div>
                        <div class="meta">
                            <a>$ <%=existingRoom.get(i).getRoomPrice()%> per night</a>
                        </div>
                        <div class="description">
                            Matthew is an interior designer living in New York.
                        </div>
                    </div>
                    <div class="extra content">
                        <span class="right floated">
                            Adult <%=existingRoom.get(i).getAdultCapacity()%>
                        </span>
                        <span>
                            <i class="user icon"></i>
                            Child <%=existingRoom.get(i).getChildCapacity()%>
                        </span>
                    </div>
                    <input type="hidden" name="roomId" value="<%=existingRoom.get(i).getRoomNum()%>">
                    <input type="hidden" name="location" value="managerIndex">
                    <button type="submit" class="ui primary button">
                        Book Now!
                    </button>
                </div>
            </div>
        </form>
        <br> 
        <%}
        } else {

            LocalDate dBefore = LocalDate.parse(newFromDate, DateTimeFormatter.ISO_LOCAL_DATE);
            LocalDate dAfter = LocalDate.parse(newToDate, DateTimeFormatter.ISO_LOCAL_DATE);
            long diff = ChronoUnit.DAYS.between(dBefore, dAfter);

            ArrayList<Room> existingRoom = (ArrayList<Room>) session.getAttribute("avaiableRoom");
            for (int i = 0; i < existingRoom.size(); i++) {%>
        <form action="/hotelmanagement/C303_ConfirmBooking" method="post">
            <div class="ui link cards">
                <div class="card">
                    <div class="image">
                        <img src="/images/avatar2/large/matthew.png">
                    </div>
                    <div class="content">
                        <div class="header"><%=existingRoom.get(i).getRoomName()%></div>
                        <div class="meta">
                            <a>$ <%=existingRoom.get(i).getRoomPrice()%> per night</a>
                        </div>
                        <div class="description">
                            Matthew is an interior designer living in New York.
                        </div>
                    </div>
                    <div class="extra content">
                        <span class="right floated">
                            Adult <%=existingRoom.get(i).getAdultCapacity()%>
                        </span>
                        <span>
                            <i class="user icon"></i>
                            Child <%=existingRoom.get(i).getChildCapacity()%>
                        </span>
                    </div>
                    <input type="hidden" name="roomId" value="<%=existingRoom.get(i).getRoomNum()%>">
                    <input type="hidden" name="location" value="managerIndexFound">
                    <input type="hidden" name="price" value="<%=existingRoom.get(i).getRoomPrice()%>">
                    <input type="hidden" name="fromDate" value="<%=newFromDate%>">
                    <input type="hidden" name="toDate" value="<%=newToDate%>">
                    <input type="text" id="nights" name="nights" value="Total Stay:  <%=diff%>" class="ui primary button" readonly>
                    <input type="text" id="totalPrice" name="totalPrice" value="Total Price:  $<%=diff * Long.parseLong(existingRoom.get(i).getRoomPrice())%>" class="ui primary button" readonly>
                    <input type="text" id="bookedfor" name="bookedfor" placeholder="customer email" required>
                    <button type="submit" class="ui primary button">
                        Book Now!
                    </button>
                </div>
            </div>
        </form>
        <br>
        <%}
            }%>--%>
        <script>
            function checkLogin() {
                const checkManagerLogin = "" + "<%=checkLogin%>";
                const booked = "" + "<%=booked%>";
                const notFound = "" + "<%=notFound%>";
                const noAmount = "" + "<%=noAmount%>";
                const userNotExist = "" + "<%=userNotExist%>";
                const exsitingBooking = "" + "<%=exsitingBooking%>";
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
    </body>
</html>
