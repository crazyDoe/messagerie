<script>
  $.ajax({
    type: "GET",
    url: "servlet/SelectContact",
  });
</script>


<div class="col-md-2 listeContacts">
	<% List<String> contacts = (List<String>)session.getAttribute("contacts"); %>

  <h3> <center> Mes contacts (<%= contacts.size()%>)</center> </h3> <br />
  <h4>
	<% if(contacts != null){ %>
    <table> <%
		for(String s : contacts){
      %> <tr>	<%
            if (new File(request.getServletContext().getRealPath("/") + "img/" + s + "Avatar.png").exists()){
      				out.println("<td><a href='chat.jsp?group_name=" + s +"'>" + s + "</a></td>");
              out.println("<td><img class='petitAvatar' src='img/" + s + "Avatar.png'></td>");
            }
      			else{
      				out.println("<td><a href='chat.jsp?group_name=" + s +"'>" + s + "</a></td>");
              out.println("<td><img class='petitAvatar' src='img/defaultAvatar.png'></td>");
            }
       %> </td>

           <td> <%
              out.println("<a href='servlet/GetCurrentGroup?next_function=delete_group&group_name=" + s + "' class='fa fa-times-circle' style='color: red'> </a>");
        %> </td>

          &nbsp; &nbsp; 

        </tr> <%
		}
 %> </table> 
<% } %>
  </h4>
</div>