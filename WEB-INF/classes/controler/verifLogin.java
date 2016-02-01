package controler;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.BDDTools;


@WebServlet("/servlet/verifLogin")
public class verifLogin extends HttpServlet{
	private static final long serialVersionUID = 1L;

	public void service( HttpServletRequest req, HttpServletResponse res ) throws ServletException, IOException {
		BDDTools tools = new BDDTools(req,res);
		Connection con = null;
		ResultSet rs;
		PrintWriter out = res.getWriter();
		try {
			con = tools.getConnect();
			PreparedStatement stmt = con.prepareStatement("SELECT pseudo FROM personne WHERE pseudo = ? ");
      stmt.setString(1, req.getParameter("pseudo"));
      rs=stmt.executeQuery();
      if(rs.next())
        out.println('1');
      else
        out.println('0');

		} catch (Exception e) {
				e.printStackTrace();
			}
		finally{
			tools.close();
		}
	}
}
