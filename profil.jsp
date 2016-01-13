<%@ page import="java.util.List, java.io.File" %>

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
          <div id="ContactList">
		      <%
			       List<String> contacts = (List<String>)session.getAttribute("contacts");
			       if(contacts != null){
			        for(String s : contacts){
                if (new File(request.getServletContext().getRealPath("/") + "img/" + s + "Avatar.png").exists())
                  out.println("<span>"+s + "<img class='petitAvatar' src='img/" + s + "Avatar.png'></span><br />");
                else
                  out.println("<span>"+s + "<img class='petitAvatar' src='img/defaultAvatar.png'></span><br />");
              }
            }
		      %>
        </div>
		    </h4>

      </div>

      <h2> Bievenue <%= pseudo %></h2>

        <div id="col-md-4">
          <form method="POST" action="servlet/UploadImage" enctype="multipart/form-data"  >
            <div class="form-group">
              <%
                if (new File(request.getServletContext().getRealPath("/") +
                  "img/" + pseudo + "Avatar.png").exists()){ %>
                  <img class="avatar" src="img/${sessionScope.pseudo}Avatar.png">
              <% } else{ %>
                  <img class="avatar" src="img/defaultAvatar.png">
              <% } %>
            </div>
            <div class="form-group">
              <label>File Input </label>
              <input type="file" name="file" id="file" />
            </div>
            <input type="submit" value="Upload" name="upload" class="btn btn-primary btn-lg">
          </form>
        </div>
    </div> <!-- Fin de container -->
    <%@ include file="footer.html"%>
  </body>
</html>
