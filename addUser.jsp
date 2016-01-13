<!DOCTYPE html>
<html>
	<head>
		<link rel="stylesheet" href="css/bootstrap.css">
		<meta charset="utf-8">
		<title >Home </title>
	</head>
    <body>
			<BR><BR><BR><BR><BR><BR><BR>
		<div class="container">
			<div class="row">
				<div class='col-md-4 col-md-offset-4'>
					<div class="login-panel panel panel-default">
						<div class="panel-heading">
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
									<input class="form-control" placeholder="Login" name="pseudo" autofocus="" type="text">
								</div>
								<div class="form-group">
									<input class="form-control" placeholder="Password" name="mdp" value="" type="password">
								</div>
                <div class="form-group">
									<input class="form-control" placeholder="Verif Password" name="mdp2" value="" type="password">
								</div>
								<input type='submit' value='Valider' class='btn btn-lg btn-success btn-block'>
								<a href="login.jsp" class="btn btn-danger btn-lg btn-block"> Annuler </a>
								</fieldset>
							</form>
						</div>
					</div>
				</div>
			</div>
		</div>
	</body>
</html>
