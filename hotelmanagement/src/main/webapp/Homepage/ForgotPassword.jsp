<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <script src="/hotelmanagement/JavaScript/LocationReplace.js"></script>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <script src="https://code.jquery.com/jquery-3.1.1.min.js" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/semantic-ui@2.4.2/dist/semantic.min"></script>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/semantic-ui@2.4.2/dist/semantic.min.css">
        <title>Forgot your password?</title>
    </head>
    <%
        String email = (String) session.getAttribute("EmailErr");
    %>
    <body onload="checkEmail()">
        <div class="ui middle aligned center aligned grid" 
             style="margin-top: 150px; margin-left: 500px; margin-right:500px">
            <div class="column">
                <h1>
                    <div class="content">
                        Reset your password
                    </div>
                </h1>
                <form class="ui large form" action="/hotelmanagement/C105_ForgotPassword" method="post">
                    <div class="ui stacked segment">
                        <div class="field">
                            <h5>Enter your user account's email address and we will send you a password reset link.</h5>
                            <div class="ui left icon input">
                                <i class="user icon"></i>
                                <input type="email" autocomplete="off" required name="email" placeholder="E-mail address">
                            </div>
                        </div>
                        <div class="field">
                            <button type="submit" class="ui fluid blue submit button" style="margin: auto; width: 70%">Send</button>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </body>
    <script>
        function checkEmail() {
            const checkAccount = "" + "<%=email%>";
            
            if (checkAccount === ("Email Sent")) {
                alert("Email has successfully been sent. \nPlease note that you have 2 hours before your token expires.");
                location.reload();
            } else if (checkAccount === ("Email not found")) {
                alert("Email does not seem to exist in the database");
                location.reload();
            }
        }
    </script>
</html>
<%
    session.removeAttribute("EmailErr");
%>