<div class="col-md-2 listeContacts">
  <h3> <center> Mes contacts </center> </h3> <br />
  <h4>
	<%
	List<String> contacts = (List<String>)session.getAttribute("contacts");
	if(contacts != null){ %>
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