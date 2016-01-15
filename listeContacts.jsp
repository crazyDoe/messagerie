<div class="col-md-2 listeContacts">
  <h2> Contacts </h2>
  <h4>
	<%
	List<String> contacts = (List<String>)session.getAttribute("contacts");
	if(contacts != null){ %>
    <ul> <%
		  for(String s : contacts){
        if (new File(request.getServletContext().getRealPath("/") + "img/" + s + "Avatar.png").exists())
          out.println("<li class='maListe'><a href='chat.jsp?friend=" + s +"'><span class='contact'>"+s +"&nbsp <img class='petitAvatar' src='img/" + s + "Avatar.png'></span><br /></li></a>&nbsp");
        else
          out.println("<li class ='maListe'><a href='chat.jsp?friend=" + s +"'><span class='contact'>"+s +"&nbsp <img class='petitAvatar' src='img/defaultAvatar.png'></span><br /></li></a>&nbsp");
      }
       %> </ul> 
          <% }
	     %>
  </h4>
</div>