<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="java.time.temporal.ChronoUnit"%>
<%@page import="java.time.LocalDate"%>
<%@page import="java.awt.Image"%>
<%@page import="java.util.LinkedList"%>
<%@page import="java.util.ArrayList"%>
<%@page import="Model.Room"%>
<%@page import="DAO.MongoDBManager"%>
<%@page import="Model.Room"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <script src="/hotelmanagement/JavaScript/LocationReplace.js"></script>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <script src="https://code.jquery.com/jquery-3.1.1.min.js" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/semantic-ui@2.4.2/dist/semantic.min"></script>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/semantic-ui@2.4.2/dist/semantic.min.css">

        <title>About</title>
    </head>
    <%
        String location = (String) session.getAttribute("location");
        String userNotExist = (String) session.getAttribute("userNotExist");
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
    <body onload="disableButton()">
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
                        <a onClick="TomanagerAbout()" class="active item">
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
            <h2 class="ui header">Booking Confirmation</h2>
            <form action="/hotelmanagement/C303_ConfirmBooking" method="post">
                <div style="margin-top: 10px; margin-left :300px">
                    <div class="ui fluid action input">
                        <label for="from">From</label>
                        <div class="ui input">
                            <input type="date" id="fromDate" name="fromDate" required>
                        </div>
                        <label for="to">to</label>
                        <div class="ui input">
                            <input type="date" id="toDate" onChange="minusDate()" name="toDate" required="">
                        </div>
                        &nbsp;
                    </div>
                </div>
                <% Room bookingRoom = (Room) session.getAttribute("bookingRoom");
                String png = "/hotelmanagement/Image/" + bookingRoom.getRoomNum() + ".png";%> %>
                <div class="ui divided items">
                    <div class="item">
                        <div class="image">
                            <img src="<%=png%>">
                        </div>
                        <div class="content">
                            <a class="header"><%=bookingRoom.getRoomName()%></a>
                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            <input type="text" id="nights" name="nights" value="" class="ui primary button" readonly>
                            <input type="text" id="totalPrice" name="totalPrice" value="" class="ui primary button" readonly>
                            <input type="text" id="bookedfor" name="bookedfor" value="" class="ui primary button" placeholder="customer email" required>
                            <div class="meta">
                                <span class="cinema">$<%=bookingRoom.getRoomPrice()%> per night</span>
                            </div>
                            <div class="description">
                                <p>Put Description later on</p>
                            </div>
                            <div class="ui label">Child <%=bookingRoom.getChildCapacity()%></div>
                            <div class="ui label">Adult <%=bookingRoom.getAdultCapacity()%></div>
                        </div>
                    </div>               
                </div><div class="ui label">Limited</div>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <input type="hidden" name="location" value="<%=location%>">
                <button type="submit" class="ui primary button">
                    Book Now!
                </button>
                <button type="submit" class="ui primary button">
                    Cancel
                </button>
            </form>
        </div>
    </body>

    <script>
        function disableButton() {
            document.getElementById("nights").style.visibility = "hidden";
            document.getElementById("totalPrice").style.visibility = "hidden";
            const userNotExist = "" + "<%=userNotExist%>";
            const checkManagerLogin = "" + "<%=checkLogin%>";
            const booked = "" + "<%=booked%>";
            const notFound = "" + "<%=notFound%>";
            const noAmount = "" + "<%=noAmount%>";
            if (userNotExist !== ("null")) {
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


        function minusDate() {
            var fromDate = document.getElementById("fromDate");
            var toDate = document.getElementById("toDate");
            var newFromDate = new Date(fromDate.value);
            var newToDate = new Date(toDate.value);
            var minusDate = new Date(newToDate.setDate(newToDate.getDate() - newFromDate.getDate()));
            var afterMinusDate = minusDate.getDate().toLocaleString();
            calculateStay(afterMinusDate);

            document.getElementById("nights").value = "Total stay: " + afterMinusDate;


        }

        function calculateStay(afterMinusDate) {

            var roomPrice = "" + "<%=bookingRoom.getRoomPrice()%>";
            var calCulation = roomPrice * afterMinusDate;
            document.getElementById("totalPrice").value = "Total price: $" + calCulation;
            document.getElementById("nights").style.visibility = "visible";
            document.getElementById("totalPrice").style.visibility = "visible";
        }
    </script>
    <%
        session.removeAttribute("userNotExist");
        session.removeAttribute("booked");
        session.removeAttribute("found");
        session.removeAttribute("notFound");
        session.removeAttribute("noAmount");
        session.removeAttribute("fromDate");
        session.removeAttribute("toDate");
        session.removeAttribute("same");
    %>

</html>
