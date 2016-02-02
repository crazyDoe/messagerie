package controler;
import java.io.IOException;
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


@WebServlet("/servlet/AddContact")
public class AddContact extends HttpServlet{
	private static final long serialVersionUID = 1L;

	public void service( HttpServletRequest req, HttpServletResponse res ) throws ServletException, IOException {
		BDDTools tools = new BDDTools(req,res);
		Connection con = null;
		HttpSession session = req.getSession();

		try {
			con = tools.getConnect();

			String nomCourant = ""+session.getAttribute("pseudo");
			String nomGroupe = req.getParameter("nomGroupe");
			ResultSet rs;

			if(nomGroupe == null) { // On cree un groupe de deux personnes
				String nomSaisi = req.getParameter("nomSaisi");

				PreparedStatement stmt = con.prepareStatement("INSERT INTO contact VALUES(?,?)");
				stmt.setString(1, nomCourant);
				stmt.setString(2, nomSaisi);
				stmt.executeUpdate();

				stmt = con.prepareStatement("INSERT INTO groupe (nom) VALUES(?)");
				stmt.setString(1, nomCourant+""+nomSaisi);
				stmt.executeUpdate();

				stmt = con.prepareStatement("SELECT gno FROM groupe WHERE nom = ?");
				stmt.setString(1, nomCourant+""+nomSaisi);
				rs = stmt.executeQuery();
				rs.next();

				int nbGroup = rs.getInt("gno");

				stmt = con.prepareStatement("INSERT INTO contient VALUES(?,?)");
				stmt.setInt(1, nbGroup);
				stmt.setString(2, nomCourant);
				stmt.executeUpdate();

				stmt = con.prepareStatement("INSERT INTO contient VALUES(?,?)");
				stmt.setInt(1, nbGroup);
				stmt.setString(2, nomSaisi);
				stmt.executeUpdate();
			}
			else{ // On cree un groupe de plusieurs personnes
				String[] results = req.getParameterValues("checkboxes");

				PreparedStatement stmt;

				stmt = con.prepareStatement("INSERT INTO groupe (nom) VALUES(?)");
				stmt.setString(1, nomGroupe);
				stmt.executeUpdate();

				stmt = con.prepareStatement("SELECT gno from groupe where nom = ?"); // On recupere le groupe courant
				stmt.setString(1, nomGroupe);
				rs = stmt.executeQuery();

				int nbGroup = -1;
				if(rs.next())
					nbGroup = rs.getInt("gno");


				stmt = con.prepareStatement("INSERT INTO contact VALUES(?, ?)");
				stmt.setString(1, nomCourant);
				stmt.setString(2, nomGroupe);
				stmt.executeUpdate();

				stmt = con.prepareStatement("INSERT INTO CONTIENT VALUES(?, ?)");
				stmt.setInt(1, nbGroup);
				stmt.setString(2, nomCourant);
				stmt.executeUpdate();

				for(String s : results){
					stmt = con.prepareStatement("INSERT INTO contact VALUES(?, ?)");
					stmt.setString(1, s.trim());
					stmt.setString(2, nomGroupe);
					stmt.executeUpdate();
				}

				for(String s : results){
					stmt = con.prepareStatement("INSERT INTO CONTIENT VALUES(?, ?)");
					stmt.setInt(1, nbGroup);
					stmt.setString(2, s.trim());
					stmt.executeUpdate();
				}
			}
			res.sendRedirect("SelectContact");
		} catch (Exception e) {
			res.getWriter().println(e);
		}
		finally{
			tools.close();
		}
	}
}
