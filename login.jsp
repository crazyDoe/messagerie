<!DOCTYPE html>
<html>
	<head>
		<link rel="stylesheet" href="../css/bootstrap.css">
		<script src="//code.jquery.com/jquery-1.12.0.min.js"></script>
		<script src="//code.jquery.com/jquery-migrate-1.2.1.min.js"></script>
		<script src="../js/bootstrap.js"></script>

		<meta charset="utf-8">
		<title >Home </title>
	</head>
    <body>
			<BR><BR><BR><BR><BR><BR><BR>
		<div>
			<div class="container">
				<div class="row">
					<div class='col-md-4 col-md-offset-4'>
						<div class="login-panel panel panel-default">
							<div class="panel-heading">
								<img src="../img/pinT.png" alt="logo-lapin">
								<br />
								<% if (session.getAttribute("erreur")!=null) { %>
	                  				<h4 style="color:red"> Erreur : ${sessionScope.erreur}</h4>
	                			<%  session.setAttribute("erreur",null);
	               				}%>
							</div>
							<div class="panel-body">
								<form action ='j_security_check' method='POST'>
									<fieldset>
									<div class="form-group">
										<input class="form-control" placeholder="Login" name="j_username" autofocus="" type="text">
									</div>
									<div class="form-group">
										<input class="form-control" placeholder="Password" name="j_password" value="" type="password">
									</div>
									<input type='submit' value='Valider' class='btn btn-lg btn-success btn-block'>
									<a href="addUser.jsp" class="btn btn-outline btn-primary btn-lg btn-block"> S'inscrire </a>
									</fieldset>
								</form>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</body>
	<script>
		
	</script>
</html>
