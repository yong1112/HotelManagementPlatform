<%@page import="java.time.temporal.ChronoUnit"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="java.time.LocalDate"%>
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

        <title>Rooms</title>
    </head>
    <%
        String createSuccess = (String) session.getAttribute("createSuccess");
        String booked = "" + (String) session.getAttribute("booked");
        String found = "" + (String) session.getAttribute("found");
        String notFound = "" + (String) session.getAttribute("notFound");
        String noAmount = "" + (String) session.getAttribute("noAmount");
        String newFromDate = (String) session.getAttribute("fromDate");
        String newToDate = (String) session.getAttribute("toDate");
        String exsitingBooking = (String) session.getAttribute("same");

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
    <body onload="check()">
        <div>
            <!-- Top menu bar !-->
            <div class="ui inverted vertical center aligned segment">
                <div class="ui container">
                    <div class="ui large secondary inverted pointing menu">
                        <a onClick="ToHome()" class="item">
                            HOME
                        </a>
                        <a onClick="ToRooms()" class="active item">
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
            <div style="margin-top: 10px; margin-left: 50px">
                <!-- Site content !-->
                <h2 class="ui header">ROOMS</h2>
            </div>
            <%if (found.equals("empty") || notFound.equals("notFound") || noAmount.equals("noAmount")) {
                    ArrayList<Room> existingRoom = db.GetRoomEdit();
                    for (int i = 0; i < existingRoom.size(); i++) {
                        String png = "/hotelmanagement/Image/" + existingRoom.get(i).getRoomNum() + ".png";
            %>
            <form action="/hotelmanagement/C302_DisplayConfirmation" method="post">
                <div class="ui link cards" style="margin-top: 10px; margin-left: 50px">
                    <div class="card">
                        <div class="image">
                            <img src="<%=png%>"/>
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
                        <input type="hidden" name="location" value="index">
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
                for (int i = 0; i < existingRoom.size(); i++) {
                    String png = "/hotelmanagement/Image/" + existingRoom.get(i).getRoomNum() + ".png";
            %>

            <form action="/hotelmanagement/C303_ConfirmBooking" method="post">
                <div class="ui link cards" style="margin-top: 10px; margin-left: 50px">
                    <div class="card">
                        <div class="image">
                            <img src="<%=png%>"/>
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
                        <input type="hidden" name="location" value="indexFound">
                        <input type="hidden" name="price" value="<%=existingRoom.get(i).getRoomPrice()%>">
                        <input type="hidden" name="fromDate" value="<%=newFromDate%>">
                        <input type="hidden" name="toDate" value="<%=newToDate%>">
                        <input type="text" id="nights" name="nights" value="Total Stay:  <%=diff%>" class="ui primary button" readonly>
                        <input type="text" id="totalPrice" name="totalPrice" value="Total Price:  $<%=diff * Long.parseLong(existingRoom.get(i).getRoomPrice())%>" class="ui primary button" readonly>
                        <button type="submit" class="ui primary button">
                            Book Now!
                        </button>
                    </div>
                </div>
            </form>
            <br>
            <%}
                }%>
            </body>
            <script>
                function check()
                {
                    const booked = "" + "<%=booked%>";
                    const notFound = "" + "<%=notFound%>";
                    const noAmount = "" + "<%=noAmount%>";
                    const exsitingBooking = "" + "<%=exsitingBooking%>";
                    if (booked !== ("null")) {
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
            %>
