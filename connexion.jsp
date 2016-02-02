<%@ page import="javax.naming.*, javax.sql.*, java.sql.*" %>

<% 
          Context initCtx = new InitialContext();
          Context envCtx = (Context) initCtx.lookup("java:comp/env");
          DataSource ds = (DataSource) envCtx.lookup("da2i");
          Connection con = ds.getConnection();
          Statement st=con.createStatement();
          ResultSet rs=null;
          rs=st.executeQuery("select * from personne");
          con.close();
%>