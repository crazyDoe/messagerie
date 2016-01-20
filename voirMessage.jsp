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
    <%
    BDDTools tools = new BDDTools(request,response);
    Connection con = null;
    ResultSet rs;
    con = tools.getConnect();
    %>
    <%! String test = "Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt. Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem. Ut enim ad minima veniam, quis nostrum exercitationem ullam corporis suscipit laboriosam, nisi ut aliquid ex ea commodi consequatur? "; %>
    <%@ include file="header.jsp"%>
    <div class="row" id="menu1">
      <div class="col-md-10">
        <div class="messages col-md-9">
          <%
            PreparedStatement stmt = con.prepareStatement("SELECT * FROM message WHERE gno IN (SELECT id_groupe FROM contient WHERE pseudo= ?) GROUP BY gno ORDER BY date DESC");

            stmt.setString(1,(String)request.getSession().getAttribute("pseudo"));
            rs = stmt.executeQuery();
              while(rs.next()){ %>
              <a href=chat.jsp?group_name=<%=rs.getString("pno")%> />
                <div class="row mess">
                  <img class=avatar-message src=img/<%= rs.getString("pno") %>Avatar.png alt=Avatar Utilisateur>
                    <h4 class="pseudo-message"> <%= rs.getString("pno") %> : </h4>
                    <p class="text-message"><%= rs.getString("message") %><p>
                </div>
              </a>
          <%  } %>
        </div>
      </div>
      <%@ include file="listeContacts.jsp" %>

    </div>
  </body>
  <%@ include file="footer.html"%>
</html>
