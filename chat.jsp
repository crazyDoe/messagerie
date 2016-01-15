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
    <div class="row recu">
      <div class="col-md-10">
          <% if (new File(request.getServletContext().getRealPath("/") + "img/" + pseudo + "Avatar.png").exists()){ %>
                <img class="moyenAvatar discu-avatar" src="img/${sessionScope.pseudo}Avatar.png">
          <% } else{ %>
           <img class="moyenAvatar discu-avatar" src="img/defaultAvatar.png">
          <% } %>
          <div class="text-recu" NAME="newMessage"></div>
    </div>
      <%@ include file="listeContacts.jsp" %>
    </div>
    <div class="row recu">
      <div class="col-md-10">
        <h2></h2>
        <% if (new File(request.getServletContext().getRealPath("/") + "img/" + friend + "Avatar.png").exists()){ %>
          <img class="moyenAvatar discu-avatar" src="img/${sessionScope.friend}Avatar.png">
        <% } else{ %>
        <img class="moyenAvatar discu-avatar" src="img/defaultAvatar.png">
        <% } %>
          <TEXTAREA class="text-envoi"NAME="newMessage" ROWS=5 COLS=80> <%= pseudo  %> dit :
           </TEXTAREA>
    </div>
  </div>
    <%@ include file="footer.html"%>
  </body>
</html>
