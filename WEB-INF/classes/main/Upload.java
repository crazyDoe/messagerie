package main;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

@WebServlet("/servlet/Upload")
@MultipartConfig
public class Upload extends HttpServlet{
	private static final long serialVersionUID = 1L;

	public void service( HttpServletRequest req, HttpServletResponse res ) throws ServletException, IOException{
		HttpSession session = req.getSession();
		
		final String path = req.getServletContext().getRealPath("/") + "/users/" + session.getAttribute("login");
		final Part filePart = req.getPart("file");
	    final String fileName = getFileName(filePart);

	    OutputStream out = null;
	    InputStream filecontent = null;
	    
	    File f = new File(path + File.separator + fileName);
	    out = new FileOutputStream(f);
	    filecontent = filePart.getInputStream();
	    
	    int read = 0;
	    final byte[] bytes = new byte[1024];

	    while ((read = filecontent.read(bytes)) != -1)
	    	out.write(bytes, 0, read);
	    
	    res.sendRedirect("../profil.jsp");
	}

	private String getFileName(final Part part) {
	    for (String content : part.getHeader("content-disposition").split(";")) {
	        if (content.trim().startsWith("filename")) {
	            return content.substring(content.indexOf('=') + 1).trim().replace("\"", "");
	        }
	    }
	    return null;
	}
}