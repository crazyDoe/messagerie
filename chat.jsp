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
    window.onload = function() {
 		getCurrentGroup();
		getMessages();
    };
 	$(document).ready(function(e){
 		getCurrentGroup();
		getMessages();
	});
	$('#envoyer').click(function(){
		ajax();
	});
	$('#newMessage').keyup(function(e){
		if(e.keyCode == 13) // Touche entree
			ajax();
	});


  	function getCurrentGroup() {
        $.ajax({
           type: "GET",
           url: "servlet/GetCurrentGroup",
        });
    }
	

  	function ajax() {
        $.ajax({
           type: "GET",
           url: "servlet/AddMessage?message="+$("#newMessage").val(),
           success: function(details){
				// Update la zone de reception
				var textSplitted = details.split(" ");
				var text = "";
					
				for (j = 0; j < textSplitted.length; j++){
					if(j == 6)
						text += "<span style='color: red'>" + textSplitted[j] + "<span> ";
					else
						text += "<span style='color: black'>" + textSplitted[j] + "<span> ";							
				}


				$('#recu').append(text + "<br />");
				
				// Clear la zone d'envoi
				document.getElementById("newMessage").value='';
		   }
        });
    }
	
	function getMessages() {
	    $.ajax({
           type: "GET",
           url: "servlet/GetMessages?pseudo=${sessionScope.pseudo}",
           success: function(details){				
				var tab = details.split("\n");
				var i, j;
				var text = "";
				
				/* nombre de lignes */
				for (i = 0; i < tab.length; i++){
					var textSplitted = tab[i].split(" ");
					

					/* Split sur espace, par ligne */
					for (j = 0; j < textSplitted.length; j++){
						if(textSplitted[j] === "${sessionScope.pseudo}")
							text += "<span style='color: red'>" + textSplitted[j] + "</span> ";
						else
							text += "<span style='color: black'>" + textSplitted[j] + "</span> ";		
					} 

					if(i != tab.length-1)
						text += "<br />";
				
					$('#recu').html(text);
				}
		   }
        });
	}
  </script>
</html>
