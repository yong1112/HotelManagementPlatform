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
        String createSuccess = (String) session.getAttribute("createSuccess");
        String checkLogin = (String) session.getAttribute("customerLoginCheck");
    %>
    <body onload="registerCheck()">
        <div>
            <!-- Top menu bar !-->
            <div class="ui inverted vertical center aligned segment">
                <div class="ui container">
                    <div class="ui large secondary inverted pointing menu">
                        <a onClick="ToCustomerIndex()" class="active item">
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
                        <a onClick="ToMyBooking()" class="item">
                            MY BOOKING
                        </a>
                        <div class="right item">
                            <a onClick="ToCustomerAccount()" class="ui right floated inverted button" style="margin-right: 10px">My Account</a>
                            <a onClick="ToHome()" class="ui right floated inverted button">Log Out</a>
                        </div>
                    </div>   
                </div>
            </div>
            <form action="/hotelmanagement/C301_RoomAvaiabilityCheck" method="post">
                <div style="margin-top: 10px; margin-left: 50px">
                    <!-- Site content !-->
                    <h2 class="ui header">Welcome to XYZ Hotel</h2>
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
                        <input type="hidden" name="index" value="customerIndex">
                        <button type="submit" class="ui button">Search</button>
                    </div>
                </div>
            </form>
        </div>
        <br>
        <br>
    </body>
</html>
<script>
    function registerCheck()
    {
    const checkCustomerLogin = "" + "<%=checkLogin%>";
            const success = "" + "<%=createSuccess%>";
            if (checkCustomerLogin === ("null")) {
    setTimeout(() => {
    ;
    }, 0);
            window.location.href = "http://localhost:8080/hotelmanagement/";
    } else if (success === ("Success")) {
    alert("New account has been created");
            location.reload();
    }
</script>
<%
    session.removeAttribute("createSuccess");
    %>
