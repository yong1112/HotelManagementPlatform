<%@page import="java.util.ArrayList"%>
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
        <title>Edit Details</title>
    </head>
    <body> 
        <%
            Booking b = (Booking) session.getAttribute("request");
        %>
        <div class="ui middle aligned grid" 
             style="margin-top: 20px; margin-left: 20%; margin-right:20%">
            <div class="column">
                <h1>
                    <div class="content">
                        Request additional items and service
                    </div>
                </h1>
                <center>
                    <form class="ui form segment" action="/hotelmanagement/C501_CustomerRequestList" method="Get">
                        <div class="five wide field">
                            <label>Booking ID</label>
                            <input value="<%=b.getBookingID()%>" required name="bookingID" type="text" readOnly>
                        </div>
                        <div class="five wide field">
                            <label>Pillow</label>
                            <input value="<%=b.getPillow()%>" required name="pillow" type="number" max="5">
                        </div>
                        <div class="five wide field">
                            <label>Blanket</label>
                            <input value="<%=b.getBlanket()%>" required name="blanket" type="number" max="5">
                        </div>
                        <div class="five wide field">
                            <label>Slippers</label>
                            <input value="<%=b.getSlippers()%>" required name="slippers" type="number" max="5">
                        </div>
                        <div class="five wide field">
                            <label>Towel</label>
                            <input value="<%=b.getTowel()%>" required name="towel" type="number" max="5">
                        </div>
                        <div class="five wide field">
                            <label>Others</label>
                            <input value="<%=b.getOthers()%>" name="others" type="text" value="">
                        </div>
                        <div class="inline field">
                            <div class="ui checkbox">
                                <input value="<%=b.isPickUpService()%>" id="checkbox1" name="pickUpService" type="checkbox" class="" name="acceptRules">
                                 <label for="pickUpService">Pick up Service</label>
                            </div>
                        </div>
                        <div >
                            <button type="submit" class="ui green medium submit button">Confirm Changes</button>
                            <button type="button" onClick="ToMyBooking()" class="ui medium button">Cancel</button>
                        </div>

                    </form>
                </center>
            </div>
        </div>
    </body>
</html>
<script>
    src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"
    
$('#checkbox-value').text($('#checkbox1').val());

$("#checkbox1").on('change', function() {
  if ($(this).is(':checked')) {
    $(this).attr('value', 'true');
  } else {
    $(this).attr('value', 'false');
  }
  
  $('#checkbox-value').text($('#checkbox1').val());
});

</script>