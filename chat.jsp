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
        <% if (new File(request.getServletContext().getRealPath("/") + "img/" + friend + "Avatar.png").exists()){ %>
          <img class="moyenAvatar discu-avatar" src="img/${sessionScope.friend}Avatar.png">
        <% } else{ %>
			<img class="moyenAvatar discu-avatar" src="img/defaultAvatar.png">
        <% } %>
        <div class="text-recu" id="recu" ></div>
    </div>
      <%@ include file="listeContacts.jsp" %>
    </div>
    <div class="row recu">
	  <div class="col-md-10">
		  <% if (new File(request.getServletContext().getRealPath("/") + "img/" + pseudo + "Avatar.png").exists()){ %>
                <img class="moyenAvatar discu-avatar" src="img/${sessionScope.pseudo}Avatar.png">
          <% } else{ %>
				<img class="moyenAvatar discu-avatar" src="img/defaultAvatar.png">
          <% } %>
          <TEXTAREA id="newMessage" class="text-envoi" ROWS=5 COLS=80></TEXTAREA>
	  </div>
	  <div class="col-md-2">
		<input id="envoyer" type='submit' value='Envoyer' class='btn btn-lg btn-success btn-block'>
	  </div>
	</div>
    <%@ include file="footer.html"%>
  </body>

  <script>
	$('#envoyer').click(function(){
		ajax();
	});
	$('#newMessage').keyup(function(e){
		if(e.keyCode == 13) // Touche entr�e
			ajax();
	});

  	function ajax() {
        $.ajax({
           type: "GET",
           url: "servlet/AddMessage?message="+$("#newMessage").val(),
           success: function(details){
            document.getElementById("recu").value=$("#newMessage").val();
            document.getElementById("newMessage").value='';
		      }
        });
    }
  </script>
</html>
