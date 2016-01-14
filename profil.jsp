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
    if(pseudo == null)
      response.sendRedirect("login.jsp"); %>
    <%@ include file="header.jsp" %>
    <div class="row" id="menu1">
      <div class="col-md-10">
        <h2> Bienvenue <%= pseudo %></h2>
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
      <div class="col-md-2 listeContacts">
          <h2> Contacts </h2>
    		<h4>
		      <%
			       List<String> contacts = (List<String>)session.getAttribute("contacts");
			       if(contacts != null){
               out.println("<ul>");
			        for(String s : contacts){
                if (new File(request.getServletContext().getRealPath("/") + "img/" + s + "Avatar.png").exists())
                  out.println("<li class='maListe'><a href=''><span class='contact'>"+s +"&nbsp <img class='petitAvatar' src='img/" + s + "Avatar.png'></span><br /></li></a>&nbsp");
                else
                  out.println("<li class ='maListe'><a href=''><span class='contact'>"+s +"&nbsp <img class='petitAvatar' src='img/defaultAvatar.png'></span><br /></li></a>&nbsp");
              }
              out.println("</ul>");
            }
		      %>
		    </h4>
      </div>
    </div> <!-- Fin de row -->
    <%@ include file="footer.html"%>
  </body>
</html>
