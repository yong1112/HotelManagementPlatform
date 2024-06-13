<%@page import="Model.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <script src="/hotelmanagement/JavaScript/LocationReplace.js"></script>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <script src="https://code.jquery.com/jquery-3.1.1.min.js" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/semantic-ui@2.4.2/dist/semantic.min"></script>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/semantic-ui@2.4.2/dist/semantic.min.css">
        <title>Edit Booking Details</title>
    </head>
    <%
        Booking booking = (Booking) session.getAttribute("booking");
        String checkLogin = (String) session.getAttribute("staffLoginCheck");
    %>
    <body onload="registerCheck()">
        <div class="ui middle aligned grid" 
             style="margin-top: 50px; margin-left: 20px; margin-right:20px">
            <div class="column">
                <h1>
                    <div class="content">
                        Edit Booking Details
                    </div>
                </h1>
                <form class="ui form segment" action="/hotelmanagement/C405_EditBooking" method="post">
                    <div class="field">
                        <label>Booking ID</label>
                        <input value="<%=booking.getBookingId()%>" id="bookingID" autocomplete="off" required name="bookingID" type="text" readonly>
                    </div>
                    <div class="two fields">
                        <div class="field">
                            <label>Room Number</label>
                            <input value="<%=booking.getRoomId()%>" id="roomId" autocomplete="off" required name="roomId" type="text" readonly>
                        </div>
                        <div class="field">
                            <label>Price per night</label>
                            <input value="<%=booking.getRoomPrice()%>" id="price" autocomplete="off" required name="price" type="text" readonly>
                        </div>
                    </div>
                    <div class="field">
                        <label>Check In</label>
                        <input value="<%=booking.getStartDate()%>" id="startDate" autocomplete="off" required name="startDate" type="text">
                    </div>
                    <div class="field">
                        <label>Check Out</label>
                        <input value="<%=booking.getEndDate()%>" id="endDate" onChange="minusDate()" autocomplete="off" required name="endDate" type="text">
                    </div>
                    <div class="field">
                        <label>Period of stay</label>
                        <input value="<%=booking.getTotalStay()%>" id="totalStay" autocomplete="off" required name="totalStay" type="text" readonly>
                    </div>
                    <div class="field">
                        <label>Total price</label>
                        <input value="<%=booking.getTotalPrice()%>" id="totalPrice" autocomplete="off" required name="totalPrice" type="text" readonly>
                    </div>
                    <div class="field">
                        <label>Booked by</label>
                        <input value="<%=booking.getBookedFor()%>" id="bookedFor" autocomplete="off" required name="bookedFor" type="text" readonly>
                    </div>
                    <div class="two fields" style="margin-left: 1px">
                        <button type="submit" class="ui green medium submit button">Confirm Changes</button>
                        <button type="button" onClick="ToChooseEditBooking()" class="ui medium button">Cancel</button>
                    </div>
                </form>
            </div>
        </div>
        <script>
            function registerCheck()
            {
                disableButton();
                const checkStaffLogin = "" + "<%=checkLogin%>";
                if (checkStaffLogin === ("null")) {
                    setTimeout(() => {
                        ;
                    }, 0);
                    window.location.href = "http://localhost:8080/hotelmanagement/";
                }
            }

            function disableButton() {
                document.getElementById("totalStay").style.visibility = "hidden";
                document.getElementById("totalPrice").style.visibility = "hidden";
            }


            function minusDate() {
                var startDate = document.getElementById("startDate");
                var endDate = document.getElementById("endDate");
                var newStartDate = new Date(startDate.value);
                var newEndDate = new Date(endDate.value);
                var minusDate = new Date(newEndDate.setDate(newEndDate.getDate() - newStartDate.getDate()));
                var afterMinusDate = minusDate.getDate().toLocaleString();
                calculateStay(afterMinusDate);

                document.getElementById("totalStay").value = afterMinusDate;


            }

            function calculateStay(afterMinusDate) {

                var roomPrice =  "" + "<%=booking.getRoomPrice()%>";
                var calculation = roomPrice * afterMinusDate;
                document.getElementById("totalPrice").value = calculation;
                document.getElementById("totalStay").style.visibility = "visible";
                document.getElementById("totalPrice").style.visibility = "visible";
            }
        </script>
    </body>
</html>
