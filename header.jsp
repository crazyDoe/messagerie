<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="css/style.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.5.0/css/font-awesome.min.css">  <
<script src="//code.jquery.com/jquery-1.12.0.min.js"></script>
<script src="//code.jquery.com/jquery-migrate-1.2.1.min.js"></script>
<script src="js/bootstrap.js"></script>
<div id="main-wrapper">
  <nav class="navbar navbar-inverse">
    <div class="container-fluid">
      <div class="navbar-header">
         <a class="navbar-brand" href="profil.jsp">${sessionScope.pseudo}</a>
       </div>
     <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-9">
      <ul class="nav navbar-nav" style="float : right">
        <li class="dropdown"> <a href="addContact.jsp"><i class="fa fa-user"></i>+</a></li>
        <li class="dropdown">
          <a class="dropdown-toggle" href="#" data-toggle="dropdown" aria-expanded="true"><i class="fa fa-envelope"></i></a>
          <ul class="dropdown-menu dropdown-user">
            <li> <a href=""> <i class="fa fa-pencil"></i> Nouveau Message </a></li>
            <li class="divider"></li>
            <li> <a href=""> <i class="fa fa-comments"></i> Voir Messages  </a> </li>
          </ul>
        </li>
        <li class="dropdown"> <a href="#"><i class="fa fa-bell"></i></a></li>
        <li class="dropdown"> <a href="servlet/Deconnect"><i class="fa fa-power-off"></i></a></li>
      </ul>
      </div>
    </div>
  </nav>
