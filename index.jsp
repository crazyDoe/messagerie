<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <title> Home </title>
  </head>
  <body>
    <%@ include file="header.jsp"%>
    <div id="page">
      <h2> Bievenue <%= session.getAttribute("pseudo")%></h2>
      <h4> Mon Profil </h4>
      <img src="img/avatar.png">
    </div>
    <%@ include file="footer.html"%>
  </body>
</html>
