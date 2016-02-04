<div class="container" id="main-wrapper">
  <div class="row">
    <nav class="navbar navbar-inverse" role="navigation">
      <div class="container-fluid">
        <div class="navbar-header">
           <a class="navbar-brand" href="profil.jsp">${sessionScope.pseudo}</a>
           <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-9" aria-expanded="false"><i class="fa fa-bars"></i></button>

         </div>
       <div class=" navbar-collapse collapse" id="bs-example-navbar-collapse-9" aria-expanded="false">
        <ul class="nav navbar-nav" style="float : right">
          <li class="dropdown">
            <a class="dropdown-toggle" href="#" data-toggle="dropdown" aria-expanded="true"><i class="fa fa-user">+</i>
          </a>
            <ul class="dropdown-menu dropdown-user">
              <li> <a href="addContact.jsp"> <i class="fa fa-pencil"></i> Ajouter Ami </a></li>
              <li class="divider"></li>
              <li <a href="">
                <a href="addGroup.jsp"> <i class="fa fa-pencil"></i> Creer Groupe </i> </a>
              </li>
            </ul>
          </li>
          <li class="dropdown"> <a href="voirMessage.jsp"><i class="fa fa-envelope"></i> <span id="notifM" ></span></a></li>
          <li class="dropdown"> <a href="#"><i class="fa fa-bell"></i></a></li>
          <li class="dropdown"> <a href="../servlet/Deconnect"><i class="fa fa-power-off"></i></a></li>
        </ul>
        </div>
      </div>
    </nav>
  </div>
  <script>
  var req = new XMLHttpRequest();
  function affiche() {
      $.ajax({
           type: "GET",
           url: "servlet/NotifMessage",
           success: function(details){
          $('#notifM').html(details);
          //setTimeout(($('#notifM').html("h")),5000);
       }
        });
  }
      setInterval(affiche,500);
  </script>
