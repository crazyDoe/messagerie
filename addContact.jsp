<!DOCTYPE html>
<html>
  <head>
    <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1/jquery.min.js"></script>
    <meta charset="utf-8">
    <title>Search</title>
  </head>
  <body>
    <%@ include file="header.jsp"%>
    <h2> Recherche nom </h2>
    <form action="servlet/AddContact" method="POST">
      Nom : <input type="text" id="nom" name="pseudo"><BR>
      <textarea id="titre" style="height:200px"></textarea>
      <input type='submit' value="Valider">
    </form>
  </body>
  <%@ include file="footer.html"%>
  <script>
  $(function() {
     $('#nom').keyup(function() {
        $.ajax({
           type: "GET",
           url: "servlet/Add?name="+$("#nom").val(),
           success: function(details)
           {
              $('#titre').text(details);
           }
        });
     });
  });
  </script>
</html>
