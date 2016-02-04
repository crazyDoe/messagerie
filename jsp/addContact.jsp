<!DOCTYPE html>
<html>
  <head>
    <%@ include file="../head.html"%>
    <meta charset="utf-8">
    <title>Search</title>
  </head>
  <body>
    <%@ include file="header.jsp"%>
    <h2> Liste des personnes </h2>
    Nom : <input type="text" id="nom" name="pseudo"><BR>
    <div id="liste" style="height:200px"></div>
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
				var tab = details.split("\n");
				var i;
				$('#liste').append('<br />');
				for (i = 0; i < tab.length-1; i++){
					$('#liste').append("<a style='color: black' href='../servlet/AddContact?nomSaisi=" + tab[i] + "'>" + tab[i] + "</a>");
					
					var img = new Image();
					var url = "../img/" + tab[i] + "Avatar.png";
					img.src = url;
					if (img.height != 0) // Si l'image existe
						$('#liste').append("<img class='petitAvatar discu-avatar' src='../img/" + tab[i] + "Avatar.png'>");
					else
						$('#liste').append("<img class='petitAvatar discu-avatar' src='../img/defaultAvatar.png'>");
				}
           }
        });
    }
  
  </script>
</html>
