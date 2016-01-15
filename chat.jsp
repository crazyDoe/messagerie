<%@ page import="java.util.List, java.io.File" %>

<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <title> Home </title>
    <%@ include file="head.html"%>
  </head>
  <body>
    <% Object pseudo = session.getAttribute("pseudo");
       Object friend = request.getParameter("friend");

    session.setAttribute("friend", friend);
    
    if(friend == null)
      response.sendRedirect("login.jsp"); %>
    <%@ include file="header.jsp" %>

    <div class="row" id="menu1">


      <div class="col-md-10">
          
            
          <div class="col-md-9">
            <br /><br /><br />
            <TEXTAREA NAME="messages" ROWS=15 COLS=65>
            </TEXTAREA>
          </div>

          <div class="col-md-3">
            <h2> <%= pseudo %></h2>
            <% if (new File(request.getServletContext().getRealPath("/") + "img/" + pseudo + "Avatar.png").exists()){ %>
                  <img class="moyenAvatar" src="img/${sessionScope.pseudo}Avatar.png">
            <% } else{ %>
             <img class="moyenAvatar" src="img/defaultAvatar.png">
            <% } %>
          </div>
          
        <br /><br /><br /><br />
            
          <div class="col-md-9">
           <br /><br /><br /><br /><br />
           <TEXTAREA NAME="newMessage" ROWS=3 COLS=65>
           </TEXTAREA>
          </div>

          <div class="col-md-3">
            <h2> <%= friend %></h2>
            <% if (new File(request.getServletContext().getRealPath("/") + "img/" + friend + "Avatar.png").exists()){ %>
              <img class="moyenAvatar" src="img/${sessionScope.friend}Avatar.png">
            <% } else{ %>
            <img class="moyenAvatar" src="img/defaultAvatar.png">
            <% } %>
          </div>
          
        <br /><br />
        
      </div>
      <%@ include file="listeContacts.jsp" %>
    </div>

    </div> <!-- Fin de row -->
    <%@ include file="footer.html"%>
  </body>
</html>
