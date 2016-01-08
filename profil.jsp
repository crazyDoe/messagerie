<%@ page import="java.util.List" %>

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
    <div id="container">
      <div id="droite">
        <h2> Contacts </h2>

		<h4>
		  <%
			List<String> contacts = (List<String>)session.getAttribute("contacts");

			if(contacts != null){
			  for(String s : contacts)
				out.println(s + "<br />");
			}
		  %>
		 </h4>

      </div>
      <h2> Bievenue <%= pseudo %></h2>
      <img src="img/avatar.png">
    </div>
    <%@ include file="footer.html"%>
  </body>
</html>
