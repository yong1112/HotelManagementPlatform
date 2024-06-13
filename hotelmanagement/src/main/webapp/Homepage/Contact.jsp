<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <script src="/hotelmanagement/JavaScript/LocationReplace.js"></script>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <script src="https://code.jquery.com/jquery-3.1.1.min.js" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/semantic-ui@2.4.2/dist/semantic.min"></script>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/semantic-ui@2.4.2/dist/semantic.min.css">

        <title>Contact</title>
    </head>
    <body>
        <div>
            <!-- Top menu bar !-->
            <div class="ui inverted vertical center aligned segment">
                <div class="ui container">
                    <div class="ui large secondary inverted pointing menu">
                        <a onClick="ToHome()" class="item">
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
                        <a onClick="ToContact()" class="active item">
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
                <h2 class="ui header">CONTACT</h2>
            </div>
        </div>
    </body>
</html>
