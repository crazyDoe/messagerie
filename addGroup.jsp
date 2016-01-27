<!DOCTYPE html>
<html>
  <head>
    <%@ include file="head.html"%>
    <meta charset="utf-8">
    <title>Search</title>
  </head>
  <body>
    <%@ include file="header.jsp"%> <br />
    <h2> Creation d'un Groupe </h2>
    <div class="row">
      <div class="col-md-8">
         <form action='servlet/AddContact' method='get' role="form" >
           <div class="form-group">
             <div class="row">
               <label class="control-label" for="Nom du groupe">Nom du groupe: </label><input type="text" name="nomGroupe" id="nomGroupe"> <br />
               <span class="" style="">X</span>
            </div>
          </div>
            <div id="liste"></div>
            <input type="submit" value="Creer le groupe" name="creerGrp" class="btn btn-primary btn-lg">
         </form>
     </div>
     <div class="col-md-4">
       <img src="img/chat.png" style="margin-left:100px;margin-bottom:70px;">
     </div>

   </div>
  </body>
  <%@ include file="footer.html"%>
  <script>
  $("#nomGroupe").keypress(function() {
      var compteur = $(this).val().length;
      console.log(compteur);
      if(compteur >= 10){
        $(this).addClass("error-form");
      }
      else
        $(this).removeClass("error-form");
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
