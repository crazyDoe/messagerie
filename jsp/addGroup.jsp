<%@ page import="java.util.List, java.io.File" %>

<!DOCTYPE html>
<html>
  <head>
    <%@ include file="head.html" %>
    <meta charset="UTF-8"/>
    <title>AddGroup - Quoi d'neuf</title>
  </head>
  <body>
    <%@ include file="header.jsp"%> <br />
    <h2> Creation d'un Groupe </h2>
    <div class="row">
      <div class="col-md-8">
         <form action='servlet/AddContact' method='get' role="form" >
           <div class="form-group">
             <div class="row">
               <label class="control-label" for="nomGroupe">Nom du groupe: </label><input type="text" name="nomGroupe" id="nomGroupe"> <br />
               <span class="" style="" id="error"></span>
            </div>
          </div>
            <div id="liste"></div>
            <input type="submit" value="Creer le groupe" name="creerGrp" class="btn btn-primary btn-lg">
         </form>
     </div>
     <div class="col-md-4">
       <img src="img/pinT.png" style="margin-left:100px;margin-bottom:70px;">
     </div>
   </div>
  </body>
  <%@ include file="footer.html"%>
  <script>
  $("#nomGroupe").blur(function() {
      var compteur = $(this).val().length;
      console.log(compteur);
      if(compteur >= 10){
        $("#nomGroupe").css("border-color", "red");
        $("#nomGroupe").css("background-color", "rgba(205,38,38,0.5)");
        $("#error").html("<p style='color:red'> Le nom de groupe ne doit dépasser 10 caractères </p>");
      }
      else{
      $("#nomGroupe").css("border-color", "green");
      $("#nomGroupe").css("background-color", "rgba(102,205,0,0.5)");
      $("#error").html("<p style='color:green'> Nom de groupe Valide </p>");}
  });

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
                $('#liste').append("<table><tr>")
    					if (img.height != 0) // Si l'image existe
    						$('#liste').append("  <td><img class='petitAvatar discu-avatar' src="+url+"></td>");
    					else
    						$('#liste').append(" <td> <img class='petitAvatar discu-avatar' src='img/defaultAvatar.png'></td>");

              $('#liste').append("<td> <input type='checkbox' name ='checkboxes' value='" + tab[i] +"'><br /><br /></td></tr></table>");
    				}
           }
        });
    }
  </script>
</html>
