<!DOCTYPE html>
<html>
	<head>
		<link rel="stylesheet" href="css/bootstrap.css">
		<script src="//code.jquery.com/jquery-1.12.0.min.js"></script>
		<script src="//code.jquery.com/jquery-migrate-1.2.1.min.js"></script>
		<script src="js/bootstrap.js"></script>
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.5.0/css/font-awesome.min.css">
		<%@ page pageEncoding="utf-8" %>
		<title >Home </title>
	</head>
    <body>
			<BR><BR><BR><BR><BR>
		<div class="container">
			<div class="row">
				<div class='col-md-4 col-md-offset-4'>
					<div class="login-panel panel panel-default">
						<div class="panel-heading">
							<img src="img/pinT.png" alt="logo-lapin">
							<h1> Inscription</h1>
							<br />
              				<% if (session.getAttribute("erreur")!=null) { %>
                				<h4 style="color:red"> Erreur :  ${sessionScope.erreur} </h4>
                					<%  session.setAttribute("erreur",null);
               				}%>
							<h3 class="panel-title">Entrez vos informations</h3>
						</div>
						<div class="panel-body">
							<form action ='servlet/InsertUser' method='POST'>
								<fieldset>
								<div class="form-group">
									<input class="form-control" placeholder="Login" name="pseudo" autofocus="" type="text" id="pseudo">
									<div id="error"></div>
								</div>
								<div class="form-group">
									<input class="form-control" placeholder="Password" name="mdp" value="" type="password" id="pwd1">
								</div>
                				<div class="form-group">
									<input class="form-control" placeholder="Verif Password" name="mdp2" value="" type="password" id="pwd2">
									<div id="error-pwd"></div>
								</div>
								<input type='submit' value='Valider' class='btn btn-lg btn-success btn-block'>
								<a href="jsp/profil.jsp" class="btn btn-danger btn-lg btn-block"> Annuler </a>
								</fieldset>
							</form>
						</div>
					</div>
				</div>
			</div>
		</div>
	</body>
	<script>
	$("#pseudo").blur(function() {
			var log = $(this).val();
			$.ajax({
				 type: "GET",
				 url: "servlet/verifLogin",
				 data: "pseudo="+log,
				 success: function(details){
					 if(details == 1){
					 $("#pseudo").css("border-color", "red");
					 $("#pseudo").css("background-color", "rgba(205,38,38,0.5)");
					 $("#error").html("<p style='color:red'> Ce pseudo existe deja </p>");
				 }
				 if (details == 0){
					 $("#pseudo").css("border-color", "green");
					 $("#pseudo").css("background-color", "rgba(102,205,0,0.5)");
					 $("#error").html("<p style='color:green'> Pseudo libre </p>");
				 }
				}
			});
	});

	$("#pwd2").blur(function() {
		var pwd1 = $("#pwd2").val();
		var pwd2 = $("#pwd1").val();
		if(pwd1 == pwd2 ){
			$("#pwd1").css("border-color", "green");
			$("#pwd1").css("background-color", "rgba(102,205,0,0.5)");
			$("#pwd2").css("border-color", "green");
			$("#pwd2").css("background-color", "rgba(102,205,0,0.5)");
			$("#error-pwd").html("<p style='color:green'> Mots de passe identiques  </p>");
		}
		else{
			$("#pwd1").css("border-color", "red");
			$("#pwd1").css("background-color", "rgba(205,38,38,0.5)");
			$("#pwd2").css("border-color", "red");
			$("#pwd2").css("background-color", "rgba(205,38,38,0.5)");
			$("#error-pwd").html("<p style='color:red'> Mots de passe non identiques </p>");
		}
	});
	</script>
</html>
