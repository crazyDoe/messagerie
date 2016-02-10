<%@ page import="java.util.List, java.io.File" %>

<!DOCTYPE html>
<html>
  <head>
    <title> Home </title>
    <%@ include file="head.jsp"%>
    <%@ page pageEncoding="utf-8" %>
  </head>
  <body>
    <%
       Object group_name = request.getParameter("group_name");
       session.setAttribute("group_name", group_name);
    %>
    <%@ include file="header.jsp" %>
    <div class="row">
      <div class="col-md-8 chatBox">
        <div class="chat-panel panel panel-default">
          <div class="panel-heading">
            <i class="fa fa-comments fa-fw"></i> Discussion
          </div>
          <div class="panel-body" id="boiteDialogue">
            <ul class="chat">

            </ul>
          </div>
          <div class="panel-footer">
            <div class="input-group">
              <input id="newMessage" type="text" class="form-control input-sm" placeholder="Type your message here...">
              <span class="input-group-btn">
                  <button class="btn btn-success btn-sm" id="envoyer">
                                        Send
                  </button>
              </span>
            </div>
          </div>

        </div>
	  </div>
    <div class="col-md-2">
    </div>
    <%@ include file="listeContacts.jsp"%>
  </div>
          <%@ include file="../footer.html"%>
	</div>
  </body>

<script type="text/javascript">
    window.onload = function() {
 		getCurrentGroup();
		setInterval(function(){
			getMessages();
		}, 300);
    };
	$('#envoyer').click(function(){
		ajax();
	});
	$('#newMessage').keyup(function(e){
		if(e.keyCode == 13) // Touche entree
			ajax();
	});


  	function getCurrentGroup() {
        $.ajax({
           type: "GET",
           url: "../servlet/GetCurrentGroup",
        });
    }

	function escapeHtml(text) {
    	'use strict';

    	return text.replace(/[\"&<>]/g, function (a) {
        	return { '"': '&quot;', '&': '&amp;', '<': '&lt;', '>': '&gt;', }[a];
    	});
	}

  	function ajax() {
        $.ajax({
           type: "GET",
           url: "../servlet/AddMessage?message="+ escapeHtml($("#newMessage").val()),
           success: function(details){
				        document.getElementById("newMessage").value='';
		   }
        });
    }

	function getMessages() {
	    $.ajax({
           type: "GET",
           url: "../servlet/GetMessages",
           success: function(details){
	       $('.chat').html(details);
				}
        });
              document.getElementById('boiteDialogue').scrollTop = document.getElementById('boiteDialogue').scrollHeight;
	}
  </script>
</html>
