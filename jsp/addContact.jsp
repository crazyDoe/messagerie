<!DOCTYPE html>
<html>
  <head>
    <%@ include file="../head.html"%>
    <meta charset="utf-8">
    <title>Search</title>
  </head>
  <body>
    <%@ include file="header.jsp"%>
    <div class="row">
      <div class="col-md-7">
        <h2> Liste des personnes </h2>
        Nom : <input type="text" id="nom" name="pseudo"><BR>
      </div>
      <div class="col-md-6">
      <table class="table table-striped">
          <thead>
            <tr>
              <th> Pseudo </th>
              <th> Image Profil </th>
            </tr>
          </thead>
          <tbody id="liste">
          </tbody>
      </table>
    </div>
  </div>
  </body>
  <%@ include file="../footer.html"%>
  <script>
	$(document).ready(function(){
		ajax();
	});

  $('#nom').keyup(function(e){
    ajax();
  });

  	function ajax() {
        $.ajax({
           type: "GET",
           url: "../servlet/AddAjax?name="+$("#nom").val(),
           success: function(details){
				$('#liste').text("");
        $("liste").append("</br>");
				var tab = details.split("\n");
				var i;
				for (i = 0; i < tab.length-1; i++){
          $('#liste').append('<tr>');
					$('#liste').append("<td><a style='color: black' href='../servlet/AddContact?nomSaisi=" + tab[i] + "'>" + tab[i] + "</a></td>");

					var img = new Image();
					var url = "../img/" + tab[i] + "Avatar.png";
					img.src = url;
					if (img.height != 0) // Si l'image existe
						$('#liste').append("<td><img class='petitAvatar discu-avatar' src='../img/" + tab[i] + "Avatar.png'></td>");
					else
						$('#liste').append("<td><img class='petitAvatar discu-avatar' src='../img/defaultAvatar.png'></td>");

          $('#liste').append("</tr>")
          $("#liste").append("<tr><td></td><td></td></tr>");

				}
           }
        });
    }

  </script>
</html>
