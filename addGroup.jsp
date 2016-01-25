<!DOCTYPE html>
<html>
  <head>
    <%@ include file="head.html"%>
    <meta charset="utf-8">
    <title>Search</title>
  </head>
  <body>
    <%@ include file="header.jsp"%> <br />

     <form action='servlet/AddContact' method='get' >
        Nom du groupe: <input type="text" name="nomGroupe"> <br />
        <div id="liste"></div>
        <input type="submit" value="Creer le groupe" name="creerGrp" class="btn btn-primary btn-lg">
     </form>
  </body>
  <%@ include file="footer.html"%>
  <script>
	$(document).ready(function(){
		ajax();
	});

  	function ajax() {
        $.ajax({
           type: "GET",
           url: "servlet/GetPeople",
           success: function(details){
    				var tab = details.split("\n");
    				var i;

            $('#liste').append("<br />");

    				for (i = 0; i < tab.length-1; i++){
    					$('#liste').append(tab[i]);
    					
    					var img = new Image();
    					var url = "img/" + tab[i] + "Avatar.png";
    					img.src = url;
    					if (img.height != 0) // Si l'image n'existe pas
    						$('#liste').append("  <img class='petitAvatar discu-avatar' src='img/" + tab[i] + "Avatar.png'>");
    					else
    						$('#liste').append("  <img class='petitAvatar discu-avatar' src='img/defaultAvatar.png'>");

              $('#liste').append(" <input type='checkbox' name ='checkboxes' value='" + tab[i] +"'><br /><br />");
    				}
           }
        });
    }
  
  </script>
</html>
