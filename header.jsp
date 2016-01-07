<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="css/style.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.5.0/css/font-awesome.min.css">
<script src="js/bootstrap.js"></script>
<div id="main-wrapper">
  <nav class="navbar navbar-inverse">
    <div class="container-fluid">
      <div class="navbar-header">
         <a class="navbar-brand" href="#"><%= session.getAttribute("pseudo")%></a>
       </div>
     <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-9">
      <ul class="nav navbar-nav" style="float : right">
        <li class="active"> <a href="#"><i class="fa fa-user"></i></a></li>
        <li class="active"> <a href="#"><i class="fa fa-envelope"></i></a></li>
        <li class="active"> <a href="#"><i class="fa fa-bell"></i></a></li>
        <li class="active"> <a href="servlet/Deconnect"><i class="fa-power-off"></i></a></li>
      </ul>
      </div>
    </div>
  </nav>
