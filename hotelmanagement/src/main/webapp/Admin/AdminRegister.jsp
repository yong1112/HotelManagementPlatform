<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <script src="/hotelmanagement/JavaScript/LocationReplace.js"></script>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <script src="https://code.jquery.com/jquery-3.1.1.min.js" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/semantic-ui@2.4.2/dist/semantic.min"></script>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/semantic-ui@2.4.2/dist/semantic.min.css">
        <title>Register</title>
    </head>
    <%
        String usernameCheck = (String) session.getAttribute("usernameMsg");
        String samePassword = (String) session.getAttribute("passwordMsg");
        String createSuccess = (String) session.getAttribute("SucessMsg");
        String adminLoginCheck = (String) session.getAttribute("adminLoginCheck");
    %>
    <body onload="adminRegisterCheck()">
        <div class="ui middle aligned grid" 
             style="margin-top: 100px; margin-left: 400px; margin-right:400px">
            <div class="column">
                <h1>
                    <div class="content">
                        Create an account
                    </div>
                </h1>
                <form class="ui form segment" id="formId" action="/hotelmanagement/C103_AdminRegister" method="post" >
                    <div class="two fields">
                        <div class="field">
                            <label>First name</label>
                            <input placeholder="First Name" autocomplete="off" required name="firstName" type="text">
                        </div>
                        <div class="field">
                            <label>Last name</label>
                            <input placeholder="Last Name" autocomplete="off" required name="lastName" type="text">
                        </div>
                    </div>
                    <div class="field">
                        <label>Username</label>
                        <input placeholder="example@example.com" autocomplete="off" required name="username" type="email">
                    </div>
                    <div class="field">
                        <label>Password</label>
                        <input placeholder="8-10 characters in length" autocomplete="off" required name="password" type="password">
                    </div>
                    <div class="field">
                        <label>Confirm password</label>
                        <input placeholder="8-10 characters in length" autocomplete="off" required name="confirmPassword" type="password">
                    </div>
                    <div class="field">
                        <label>Role</label>
                        <div class="inline fields" required>
                            <div class="ui radio checkbox">
                                <input type="radio" id="adminButton" name="role" value="Admin">
                                <label>Admin</label>
                            </div>
                            <div class="ui radio checkbox" style="margin-left: 20px">
                                <input type="radio" id="managerButton" name="role" value="Manager">
                                <label>Manager</label>
                            </div>
                            <div class="ui radio checkbox" style="margin-left: 20px">
                                <input type="radio" id="staffButton" name="role" value="Team member">
                                <label>Staff</label>
                            </div>
                        </div>
                    </div>
                    <div class="two fields" style="margin-left: 1px">
                        <button type="submit" class="ui green medium submit button">Sign up</button>
                        <button onClick="ToAdminIndex()" class="ui medium button">Cancel</button>
                    </div>
                </form>
            </div>
        </div>
        <script>
            function adminRegisterCheck()
            {
                const emailCheck = "" + "<%=usernameCheck%>";
                const passwordCheck = "" + "<%=samePassword%>";
                const success = "" + "<%=createSuccess%>";
                const checkAdminLogin = "" + "<%=adminLoginCheck%>";
                if (checkAdminLogin === ("null")) {
                    setTimeout(() => {
                        ;
                    }, 0);
                    window.location.href = "http://localhost:8080/hotelmanagement/";
                } else if (emailCheck === ("Email already exists in the database")) {
                    alert("Email already exists in the database");
                    location.reload();
                } else if (passwordCheck === ("Password is not the same")) {
                    alert("Password is not the same");
                    location.reload();
                } else if (success !== ("null")) {
                    alert(success);
                    location.reload();
                }
            }

            //Function to check role selection
            document.getElementById('formId').onsubmit = function () {
                if (document.getElementById("adminButton").checked === false && document.getElementById("managerButton").checked === false
                        && document.getElementById("adminButton").checked === false)
                {
                    alert("Please select position");
                    return false; // Cancel submit
                } else {
                    return true; // if any button selected then -> submit the form
                }
            }
        </script>
        <%
            session.removeAttribute("usernameMsg");
            session.removeAttribute("passwordMsg");
            session.removeAttribute("SucessMsg");
        %>
    </body>
</html>
