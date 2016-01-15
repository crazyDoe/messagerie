<%@ page import="java.util.List, java.io.File" %>
<!DOCTYPE html>
<html>
  <head>
    <%@ include file="head.html"%>
    <meta charset="utf-8">
    <title>Messages</title>
  </head>
  <body>
    <%! String test = "Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt. Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem. Ut enim ad minima veniam, quis nostrum exercitationem ullam corporis suscipit laboriosam, nisi ut aliquid ex ea commodi consequatur? "; %>
    <%@ include file="header.jsp"%>
    <div class="row" id="menu1">
      <div class="col-md-10">
        <div class="messages col-md-9">
          <a href="">
            <div class="row mess">
              <img class="avatar-message" src="img/defaultAvatar.png" alt="Avatar Utilisateur">
                <h4 class="pseudo-message"> Test : </h4>
                <p class="text-message"><% out.println(test.substring(0,80)+" ...");%><p>
            </div>
          </a>
          <a href="">
            <div class="row mess">
              <img class="avatar-message" src="img/bobAvatar.png" alt="Avatar Utilisateur">
                <h4 class="pseudo-message"> Bob : </h4>
                <p class="text-message"><% out.println(test.substring(0,80)+" ...");%><p>
            </div>
          </a>
          <a href="">
            <div class="row mess">
              <img class="avatar-message" src="img/bicheAvatar.png" alt="Avatar Utilisateur">
                <h4 class="pseudo-message"> Biche :</h4>
                <p class="text-message"><% out.println(test.substring(0,80)+" ...");%><p>
            </div>
          </a>
          <a href="">
            <div class="row mess">
              <img class="avatar-message" src="img/zighmaAvatar.png" alt="Avatar Utilisateur">
                <h4 class="pseudo-message"> Zighma :</h4>
                <p class="text-message"><% out.println(test.substring(0,80)+" ...");%><p>
            </div>
          </a>
          <a href="">
            <div class="row mess">
              <img class="avatar-message" src="img/maximeAvatar.png" alt="Avatar Utilisateur">
                <h4 class="pseudo-message"> Maxime :  </h4>
                <p class="text-message"><% out.println(test.substring(0,80)+" ...");%><p>
            </div>
          </a>
          <a href="">
            <div class="row mess">
              <img class="avatar-message" src="img/pommeAvatar.png" alt="Avatar Utilisateur">
                <h4 class="pseudo-message"> Pomme :  </h4>
                <p class="text-message"><% out.println(test.substring(0,80)+" ...");%><p>
            </div>
          </a>
          <a href="">
            <div class="row mess">
              <img class="avatar-message" src="img/poireAvatar.png" alt="Avatar Utilisateur">
                <h4 class="pseudo-message"> Poire : </h4>
                <p class="text-message"><% out.println(test.substring(0,80)+" ...");%><p>
            </div>
          </a>
            <a href="">
            <div class="row mess">
              <img class="avatar-message" src="img/bryanAvatar.png" alt="Avatar Utilisateur">
                <h4 class="pseudo-message"> Bryan : </h4>
                <p class="text-message"><% out.println(test.substring(0,80)+" ...");%><p>
            </div>
          </a>
        </div>
      </div>
      <%@ include file="listeContacts.jsp" %>

    </div>
  </body>
  <%@ include file="footer.html"%>
</html>
