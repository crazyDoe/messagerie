<%@ page import="java.util.List, java.io.File, java.sql.*" %>
<%@ page import="outils.BDDTools" %>
<!DOCTYPE html>
<html>
  <head>
    <%@ include file="head.html"%>
    <meta charset="utf-8">
    <title>Messages</title>
  </head>
  <body>
    <% BDDTools tools = new BDDTools(request,response);
    Connection con = null;
    ResultSet rs,rsA,rsB,rsNbMess;
    con = tools.getConnect(); %>
    <%@ include file="header.jsp"%>
    <div class="row" id="menu1">
      <div class="col-md-10">
        <div class="messages col-md-9">
          <%
            PreparedStatement stmt = con.prepareStatement("SELECT * FROM message WHERE gno IN (SELECT id_groupe FROM contient WHERE pseudo= ?) GROUP BY gno ORDER BY date DESC");

            stmt.setString(1,(String)request.getSession().getAttribute("pseudo"));
            rs = stmt.executeQuery();
              while(rs.next()){
                // Si Groupe de 2
                stmt = con.prepareStatement("SELECT pseudo FROM contient WHERE id_groupe = ? AND pseudo <> ? ");
                stmt.setInt(1,rs.getInt("gno"));
                stmt.setString(2,(String)request.getSession().getAttribute("pseudo"));
                rsA = stmt.executeQuery();
                Integer compteur = 0;
                while (rsA.next()){compteur++;}
                rsA = stmt.executeQuery();
                if (rsA.next())
                {
                  if(compteur == 1)
                  {
                    %>
                  <a class="lienUser" href="" onclick="updateNotif();"/>
                    <div class="row mess">
                      <img class=avatar-message src=img/<%= rsA.getString("pseudo") %>Avatar.png alt=Avatar Utilisateur/>
                        <h4 class="pseudo-message"> <%= rsA.getString("pseudo") %> : </h4>
                        <p class="text-message"><%= rs.getString("message") %><p>
                    </div>
                  </a>
                  <% }
                  // Si Groupe de plus de 2 personnes
                  else{
                    stmt = con.prepareStatement("SELECT nom FROM groupe WHERE gno = ?");
                    stmt.setInt(1,rs.getInt("gno"));
                    rsB = stmt.executeQuery();
                    if(rsB.next())
                     {
                     %>
                       <a class="lienUser" href=chat.jsp?group_name=<%=rsB.getString("nom")%> />
                         <div class="row mess">
                           <img class=avatar-message src=img/defaultAvatar.png alt=Avatar Utilisateur>
                             <h4 class="pseudo-message"> <%= rsB.getString("nom") %> : </h4>
                             <p class="text-message"><%= rs.getString("message") %><p>
                         </div>
                       </a>
                    <% } %> <!-- Fermeture If rsB -->
                  <% } %><!-- Fermeture If else -->
                <% } %> <!-- Fermeture If rsA -->
              <% } %> <!-- Fermeture W -->
        </div>
      </div>
      <% tools.close();%>
      <%@ include file="listeContacts.jsp" %>

    </div>
  </body>
  <%@ include file="footer.html"%>
</html>
<script>
$(".lienUser").click(function(){ // quand l'utilisateur clique dans la case
  var data = $(this).children().children('h4').text();
  $.ajax({
       type: "GET",
       url: "servlet/UpdateNotif?pseudo="+data,
       success: function(details){
         console.log("ok");
   }
    });
})
</script>
