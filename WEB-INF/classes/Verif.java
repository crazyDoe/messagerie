// Servlet Test.java  de test de la configuration
import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.WebServlet;
import java.sql.*;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import outils.*;


@WebServlet("/servlet/Verif")
public class Verif extends HttpServlet
{
  public void service( HttpServletRequest req, HttpServletResponse res )
       throws ServletException, IOException
  {
     PrintWriter out = res.getWriter();
    Connection con = null;
    HttpSession session = req.getSession();
    try {
      Class.forName("org.postgresql.Driver");
      con = BDDTools.getConnect();
      Statement stmt = con.createStatement();
      String nomSaisi = req.getParameter("login");
      String mdpSaisi = req.getParameter("mdp");
      String requete = "SELECT * FROM personne WHERE pseudo='"+nomSaisi+"' AND mdp = '"+mdpSaisi +"';";
      ResultSet rs = stmt.executeQuery(requete);
      if(rs.next())
      {
        session.setAttribute("pseudo",nomSaisi);
        res.sendRedirect("../upload.jsp");
      }
      else
      {
        session.setAttribute("erreur","Mauvais Identifiants");
        res.sendRedirect("../index.jsp");

      }

    } catch (Exception e) {
      out.println(e);
      e.printStackTrace();
    }
    finally{
      try {
        con.close();
      } catch (Exception e) {
        // TODO Auto-generated catch block
        e.printStackTrace();
      }
    }
  }
}
