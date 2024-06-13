<%-- 
    Document   : ResetPassword
    Created on : 06/10/2021, 1:06:51 AM
    Author     : oneilrangiuira
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <script src="/hotelmanagement/JavaScript/LocationReplace.js"></script>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <script src="https://code.jquery.com/jquery-3.1.1.min.js" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/semantic-ui@2.4.2/dist/semantic.min"></script>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/semantic-ui@2.4.2/dist/semantic.min.css">
        <title>Reset Password</title>
    </head>
    <%
        String token = (String) session.getAttribute("tokenErr");
    %>
    <body onload="checkToken()">
        <div class="ui middle aligned grid" 
             style="margin-top: 100px; margin-left: 400px; margin-right:400px">
            <div class="column">
                <h1>
                    <div class="content">
                        Reset Password
                    </div>
                </h1>
                <form class="ui form segment" action="/hotelmanagement/C106_ResetPassword" method="post">
                    <div class="field">
                        <label>Token</label>
                        <input type="text" placeholder="Please enter the token" autocomplete="off" required name="token">     
                    </div>       
                    <div class="field">
                        <label>New Password</label>
                        <input placeholder="New password 8-10 characters in length" autocomplete="off" required name="password" type="password">
                    </div>
                    <div class="field">
                        <label>Confirm password</label>
                        <input placeholder="Confirm password 8-10 characters in length" autocomplete="off" required name="confirmPassword" type="password">
                    </div>
                    <div class="two fields" style="margin-left: 1px">
                        <button type="submit" class="ui green medium submit button">Reset</button>
                        <button type="button" onClick="window.location.replace('http://localhost:8080/hotelmanagement/')" class="ui medium button">Cancel</button>
                    </div>
                </form>
            </div>
        </div>
    </body>
    <script>
        function checkToken() {
            const checkAccount = "" + "<%=token%>";
            
            if (checkAccount === ("Token not found")) {
                alert("Token cannot be found in the database");
                location.reload();
            } else if (checkAccount === ("Password not the same")) {
                alert("Password are not the same. Please try again.");
                location.reload();
            } else if (checkAccount === ("Token has expired")) {
                alert("Sorry, your token has expired. Please request for a new token.");
                location.reload();
            } else if (checkAccount === ("Reset password successful")) {
                alert("You have sucessfully reset password. You will now be logged in.");
                location.reload();
            }
        }
    </script>
</html>
<%
    session.removeAttribute("tokenErr");
%>