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
    %>
    <body onload="disableButton()">
        <div>
            <!-- Top menu bar !-->
            <div class="ui inverted vertical center aligned segment">
                <div class="ui container">
                    <div class="ui large secondary inverted pointing menu">
                        <a onClick="ToHome()" class="active item">
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
                    String png = "/hotelmanagement/Image/" + bookingRoom.getRoomNum() + ".png";%>
                <div class="ui divided items" style="margin-top: 10px; margin-left: 10px">
                    <div class="item">
                        <div class="image">
                            <img src="<%=png%>"/>
                        </div>
                        <div class="content">
                            <a class="header"><%=bookingRoom.getRoomName()%></a>
                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            <input type="text" id="nights" name="nights" value="" class="ui primary button" readonly>
                            <input type="text" id="totalPrice" name="totalPrice" value="" class="ui primary button" readonly>
                            <%if (location.equals("staffIndex")) {%>
                            <input type="text" id="bookedfor" name="bookedfor" value="" class="ui primary button" placeholder="customer email" required>
                            <%}%>
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
            if (userNotExist !== ("null")){
                alert("User does not exist in database.");
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
</html>
