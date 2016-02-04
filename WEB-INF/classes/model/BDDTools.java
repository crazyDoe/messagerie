package model;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Scanner;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.sql.DataSource;

public class BDDTools {
	private Connection con = null;
	private PreparedStatement ps;
	private Scanner sc;

	public BDDTools(HttpServletRequest req, HttpServletResponse res){
	/*	Properties p = new Properties();

		try {
			p.load(new FileInputStream("Properties"));
		} catch (IOException e1) {
			e1.printStackTrace();
		} */

		try {
			Context initCtx = new InitialContext();
			Context envCtx = (Context) initCtx.lookup("java:comp/env");
			DataSource ds = (DataSource) envCtx.lookup("pool");
			con = ds.getConnection();
		}
		catch (SQLException | NamingException e ) {
			e.printStackTrace();
		}
	}

	public String getColumnFieldAt(String table, int pos) throws SQLException{
		String request = "select * from " + table;

		ps = con.prepareStatement(request);
		ResultSet rs = ps.executeQuery();
		ResultSetMetaData rsmd = rs.getMetaData();

		return rsmd.getColumnName(pos);
	}

	public int getNbLines(String table) throws SQLException{
		String request = "select count(*) from " + table;

		ps = con.prepareStatement(request);
		ResultSet rs = ps.executeQuery();

		rs.next();
		return rs.getInt(1);
	}

	public int getNbLines(HttpServletRequest req, String table, List<String> where) throws SQLException, IOException{
		String request = "select count(*) from " + table + " where ";

		Iterator<String> it = where.iterator();
		while(it.hasNext())
			request += it.next() + "=" + it.next() + " and ";
		request = request.substring(0, request.length()-5);

		ps = con.prepareStatement(request);
		ResultSet rs = ps.executeQuery();

		rs.next();
		return rs.getInt(1);
	}

	public int getNbCol(String table) throws SQLException{
		String request = "select * from " + table;

		ps = con.prepareStatement(request);
		ResultSet rs = ps.executeQuery();
		ResultSetMetaData rsmd = rs.getMetaData();

		return rsmd.getColumnCount();
	}

	public ArrayList<ArrayList<String>> getRequest(String request) throws SQLException{
		ArrayList<ArrayList<String>> liste = new ArrayList<ArrayList<String>>();

		ps = con.prepareStatement(request);
		ResultSet rs = ps.executeQuery();
		ResultSetMetaData rsmd = rs.getMetaData();

		int lines = getNbLines(rsmd.getTableName(1));
		int columns = rsmd.getColumnCount();

		for(int i = 0; i <= lines; i++){
			liste.add(new ArrayList<String>());

			for(int j = 0; j < columns; j++){
				if(i == 0)
					liste.get(i).add(rsmd.getColumnName(j+1));
				else
					liste.get(i).add(rs.getString(j+1));
			}
			rs.next();
		}
		return liste;
	}

	public void close(){
		try {
			con.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	public void doRequest(String request) throws SQLException{
		ps = con.prepareStatement(request);
		ps.executeUpdate();
	}

	public String getDescription(String table) throws SQLException{
		String request = "select * from " + table;

		ps = con.prepareStatement(request);
		ResultSet rs = ps.executeQuery();
		ResultSetMetaData rsmd = rs.getMetaData();

		String tmp = "Nombre de colonnes : " + rsmd.getColumnCount() + "\n";

		for(int i = 1; i < rsmd.getColumnCount()+1; i++)
			tmp += rsmd.getColumnName(i) + "\t" + rsmd.getColumnTypeName(i) + "\n";
		return tmp;
	}

	public Connection getConnect(){
		return con;
	}

	public void insertInteract(String table) throws SQLException{
		sc = new Scanner(System.in);

		int nombre = getNbCol(table);
		List<String> liste = new ArrayList<String>();

		for(int i = 1; i < nombre +1 ; i++){
			System.out.print("Valeur " + i + " : ");
			liste.add(sc.next());
		}

		String request = "insert into " + table + " values(";

		for(int i = 0; i < nombre; i++)
			request += "?,";

		request = request.substring(0, request.length()-1) + ")";
		ps = con.prepareStatement(request);

		for(int i = 0; i < nombre; i++){
			if(liste.get(i).charAt(0) == '\'')
				ps.setString(i+1, liste.get(i));
			else
				ps.setInt(i+1, Integer.parseInt(liste.get(i)));
		}

		ps.executeUpdate();
	}

	public String getType(String table, int pos) throws SQLException{
		String request = "select * from " + table;

		ps = con.prepareStatement(request);
		ResultSet rs = ps.executeQuery();
		ResultSetMetaData rsmd = rs.getMetaData();

		return rsmd.getColumnTypeName(pos);
	}

	public String toString(){
		return con.toString();
	}
}
