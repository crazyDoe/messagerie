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
    <ul> <%
		for(String s : contacts){
			if (new File(request.getServletContext().getRealPath("/") + "img/" + s + "Avatar.png").exists())
				out.println("<li class='maListe'><a href='chat.jsp?group_name=" + s +"'><span class='contact'>"+s +"&nbsp <img class='petitAvatar' src='img/" + s + "Avatar.png'></span><br /></li></a>&nbsp");
			else
				out.println("<li class ='maListe'><a href='chat.jsp?group_name=" + s +"'><span class='contact'>"+s +"&nbsp <img class='petitAvatar' src='img/defaultAvatar.png'></span><br /></li></a>&nbsp");
		}
       %> </ul> 
          <% }
	     %>
  </h4>
</div>