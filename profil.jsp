<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <title> Home </title>
  </head>
  <body>
    <% Object pseudo = session.getAttribute("pseudo");
      
    if(pseudo == null)
      response.sendRedirect("login.jsp"); %>

    <%@ include file="header.jsp"%>
    <div>
      <div id="droite">
        <h2> Contacts </h2>
        <form action="servlet/SelectContacts" method="POST">
          <input type="submit" name="selectContacts" value="contacts"/>
        </form>
      </div>
      <h2> Bievenue <%= pseudo %></h2>
      <h4> Mon Profil </h4>
      <img src="img/avatar.png">
    </div>
    <%@ include file="footer.html"%>
  </body>
</html>
