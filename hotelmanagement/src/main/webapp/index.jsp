<%@page import="java.time.temporal.ChronoUnit"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="java.time.LocalDate"%>
<%@page import="java.util.Date"%>
<%@page import="Model.Room"%>
<%@page import="java.util.ArrayList"%>
<%@page import="DAO.MongoDBManager"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <script src="/hotelmanagement/JavaScript/LocationReplace.js"></script>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <script src="https://code.jquery.com/jquery-3.1.1.min.js" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/semantic-ui@2.4.2/dist/semantic.min"></script>
        <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
        <link rel="stylesheet" href="/resources/demos/style.css">
        <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
        <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/semantic-ui@2.4.2/dist/semantic.min.css">

        <title>Hotel Management System</title>
    </head>
   

    <body onload="check()">
        <div>
            <!-- Top menu bar !-->
            <div class="ui inverted vertical center aligned segment">
                <div class="ui container">
                    <div class="ui large secondary inverted pointing menu">
                        <a onClick="ToHome()" class=" active item">
                            HOME
                        </a>
                        <a onClick="ToRooms()" class="item">
                            ROOMS
                        </a>
                        <a onClick="ToDining()" class="item">
                            DINING 
                        </a>
                        <a onClick="ToAbout()" class="item">
                            ABOUT US
                        </a>
                        <a onClick="ToContact()" class="item">
                            CONTACT 
                        </a>
                        <div class="right item">
                            <a onClick="ToLogin()" class="ui right floated inverted button" style="margin-right: 10px">Log in</a>
                            <a onClick="ToRegister()" class="ui right floated inverted button">Sign Up</a>
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
                        <input type="hidden" name="index" value="index">
                        <button type="submit" class="ui button">Search</button>
                    </div>
                </div>
            </form>
        </div>
        <br>
        <br>
    </body>      
</html>
