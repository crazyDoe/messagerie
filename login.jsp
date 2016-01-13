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
							<h1> Quoi d'neuf ?</h1>
							<br />
							<h3 class="panel-title">Restez en contact avec vos amis partout dans le monde !!!!</h3>
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
								<a href="addUser.jsp" class="btn btn-outline btn-primary btn-lg btn-block"> S'inscrire </a>
								</fieldset>
							</form>
						</div>
					</div>
				</div>
			</div>
		</div>
	</body>
</html>
