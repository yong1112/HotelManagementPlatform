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

        <title>Hotel Management System</title>
    </head>
    <%
        String checkLogin = (String) session.getAttribute("customerLoginCheck");
        String location = (String) session.getAttribute("location");
        String userNotExist = (String) session.getAttribute("userNotExist");
        String found = "" + (String) session.getAttribute("found");
        String notFound = "" + (String) session.getAttribute("notFound");
        String noAmount = "" + (String) session.getAttribute("noAmount");
        String newFromDate = (String) session.getAttribute("fromDate");
        String newToDate = (String) session.getAttribute("toDate");
        String exsitingBooking = (String) session.getAttribute("same");
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
                        <a onClick="ToCustomerAbout()" class="active item">
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
                    String png = "/hotelmanagement/Image/" + bookingRoom.getRoomNum() + ".png";%>%>
                <div class="ui divided items">
                    <div class="item">
                        <div class="image">
                            <img src="<%=png%>"/>
                        </div>
                        <div class="content">
                            <a class="header"><%=bookingRoom.getRoomName()%></a>
                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            <input type="text" id="nights" name="nights" value="" class="ui primary button" readonly>
                            <input type="text" id="totalPrice" name="totalPrice" value="" class="ui primary button" readonly>
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
                <input type="hidden" name="roomId" value="<%=bookingRoom.getRoomNum()%>">
                <button type="submit" class="ui primary button">
                    Book Now!
                </button>
                <button type="submit" class="ui primary button">
                    Cancel
                </button>
            </form>
        </div>
        <script>
            function registerCheck()
            {
                const checkCustomerLogin = "" + "<%=checkLogin%>";
                const notFound = "" + "<%=notFound%>";
                const noAmount = "" + "<%=noAmount%>";
                const exsitingBooking = "" + "<%=exsitingBooking%>";
                document.getElementById("nights").style.visibility = "hidden";
                document.getElementById("totalPrice").style.visibility = "hidden";
                const userNotExist = "" + "<%=userNotExist%>";
                if (userNotExist !== ("null")) {
                    alert("User does not exist in database.");
                } else
                if (checkCustomerLogin === ("null")) {
                    setTimeout(() => {
                        ;
                    }, 0);
                    window.location.href = "http://localhost:8080/hotelmanagement/";
                }
                if (notFound !== ("null")) {
                    alert("There is no room avaiable during the period");
                } else if (noAmount !== ("null")) {
                    alert("There is no adult or child numbers suit you");
                } else if (exsitingBooking !== ("null")) {
                    alert("Selected booking period is unavaiable");
                } else if (checkCustomerLogin === ("null")) {
                    setTimeout(() => {
                        ;
                    }, 0);
                    window.location.href = "http://localhost:8080/hotelmanagement/";
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
        <%session.removeAttribute("userNotExist");%>
        <%
            session.removeAttribute("booked");
            session.removeAttribute("found");
            session.removeAttribute("notFound");
            session.removeAttribute("noAmount");
            session.removeAttribute("fromDate");
            session.removeAttribute("toDate");
            session.removeAttribute("same");
        %>
    </body>
</html>
