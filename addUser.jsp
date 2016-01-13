<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <title></title>
  </head>
  <body>
    <div class='col-md-3 col-md-offset-4'>
			<div class="login-panel panel panel-default">
				<div class="panel-heading">
					<h3 class="panel-title">Veuillez entrer vos Identifiants</h3>
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
						<input type='submit' value='Valider' class='btn btn-lg btn-success btn-block'>
						</fieldset>
					</form>
				</div>
			</div>
		</div>
  </body>
</html>
