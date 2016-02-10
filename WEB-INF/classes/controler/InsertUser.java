package controler;
import java.io.IOException;
import java.io.PrintWriter;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
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


@WebServlet("/servlet/InsertUser")
public class InsertUser extends HttpServlet{
	private static final long serialVersionUID = 1L;
	private MessageDigest digester;
	
	public String crypt(String str) throws NoSuchAlgorithmException {
		digester = MessageDigest.getInstance("SHA-256");

		digester.update(str.getBytes());
        byte[] hash = digester.digest();
        StringBuffer hexString = new StringBuffer();
        for (int i = 0; i < hash.length; i++) {
            if ((0xff & hash[i]) < 0x10)
                hexString.append("0" + Integer.toHexString((0xFF & hash[i])));
            else
                hexString.append(Integer.toHexString(0xFF & hash[i]));
        }
        return hexString.toString();
    }
	
	public void service( HttpServletRequest req, HttpServletResponse res ) throws ServletException, IOException {
		BDDTools tools = new BDDTools(req,res);
		Connection con = null;
		PrintWriter out = res.getWriter();
		HttpSession session = req.getSession();
		ResultSet rs;

		try {
			con = tools.getConnect();
			String nomSaisi = req.getParameter("pseudo");
			String mdp = req.getParameter("mdp");
			String mdp2 = req.getParameter("mdp2");

			PreparedStatement stmt = con.prepareStatement("SELECT pseudo FROM personne WHERE pseudo = ?");
			stmt.setString(1,nomSaisi);
			rs = stmt.executeQuery();
			if(mdp.equals(mdp2) && !rs.next())
			{
				session.setAttribute("pseudo", nomSaisi);
				stmt = con.prepareStatement("INSERT INTO personne(pseudo, mdp) VALUES (?,?)");
				stmt.setString(1, nomSaisi);
				stmt.setString(2, crypt("123"));
				stmt.executeUpdate();
				session.setAttribute("erreur",null);
				res.sendRedirect(req.getContextPath() + "/jsp/profil.jsp");
			}
			else if(!mdp.equals(mdp2))
			{
				session.setAttribute("erreur","Mots de passe non identiques");
				res.sendRedirect(req.getContextPath() + "/addUser.jsp");
			}

			else {
				session.setAttribute("erreur","Le pseudo existe deja");
				res.sendRedirect(req.getContextPath() + "/addUser.jsp");
			}

		} catch (Exception e) {
			out.println(e);
		}
		finally{
			tools.close();
		}
	}
	
	public static void main(String[] args) throws NoSuchAlgorithmException {
		System.out.println(new InsertUser().crypt("123"));
	}
}
