<!DOCTYPE html>
<html>
	<head>
		<link rel="stylesheet" href="css/bootstrap.css">
		<meta charset="utf-8">
		<title >Home </title>
	</head>
    <body>
		<%
		if(session.getAttribute("pseudo")!= null){
			out.println("Bienvenue "+session.getAttribute("pseudo"));
			out.println("<a href='servlet/Deconnect'> Deconnection </a>");
		}
		else { %>
		<div class='col-md-3 col-md-offset-4'>
			<div class="login-panel panel panel-default">
				<div class="panel-heading">
					<h3 class="panel-title">Veuillez entrer vos Identifiants</h3>
				</div>
				<div class="panel-body">
					<form action ='servlet/LoginTreatment' method='POST'>
						<fieldset>
						<div class="form-group">
							<input class="form-control" placeholder="Login" name="login" autofocus="" type="text">
						</div>
						<div class="form-group">
							<input class="form-control" placeholder="Password" name="mdp" value="" type="password">
						</div>
						<input type='submit' value='Valider' class='btn btn-lg btn-success btn-block'>
						<a href="addUser.jsp" style="text-align:center"> S'inscrire </a>
						</fieldset>
					</form>
				</div>
			</div>
		</div>
		<% } %>
	</body>
</html>
