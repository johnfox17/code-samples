
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class login
 */
@WebServlet("/login")
public class login extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Create a function that will allow to check if login information is
		// correct or not
		try {
			//Connection to mySQL database
			Class.forName("com.mysql.cj.jdbc.Driver");
			boolean found = false;
			HttpSession session = request.getSession();
			Connection con = DriverManager.getConnection(
					"jdbc:mysql://mydbinstance.chkafory7bnl.us-east-1.rds.amazonaws.com", "capstone", "123456?!");
			Statement stmt = con.createStatement();
			// Save parameters
			
			
			String id = request.getParameter("ID");
			String password = request.getParameter("password");
			
			if(id=="" || password=="" ||request.getParameter("category")==null) {
				session.setAttribute("message", "Missing ID, password or category!");
				response.sendRedirect("login.jsp");	
			}
			
			String category = request.getParameter("category").toString();
			
			//The query begins
			String sql = "SELECT * FROM dbDevil." + category + " WHERE id=" + request.getParameter("ID").toString();
			
			ResultSet rs = stmt.executeQuery(sql);
			while (rs.next()) {				
				if (Integer.toString(rs.getInt("id")).equals(id)
						&& rs.getString("password").equals(password)) {
					session.setAttribute("first_name", rs.getString("first_name"));
					session.setAttribute("last_name", rs.getString("last_name"));
					if(category.equals("students")) {
						session.setAttribute("level", rs.getString("level"));
					}
					session.setAttribute("id", rs.getString("id"));
					found = true;
				}
			}
			
			//Redirect to the admin page
			if(found==true && category.equals("admin")) { session.setAttribute("message", ""); response.sendRedirect("admin.jsp");}
			
			//create sql query string to look for additional information for students
			sql = "select * from dbDevil.levels where level=" + session.getAttribute("level").toString();
			rs = stmt.executeQuery(sql);
			
			found = false;
			// iterating to find lesson name with lesson id
			while (rs.next()) {
				if (Integer.toString(rs.getInt("level")).equals(session.getAttribute("level").toString())) {
					session.setAttribute("chapter", rs.getString("chapter"));
					session.setAttribute("difficulty", rs.getString("difficulty"));
					session.setAttribute("problem", "");
					found = true;
				}
			}
			
			
			//System.out.println(session.getAttribute("difficulty"));
			//Redirect to student page
			if(found==true && category.equals("students")) {session.setAttribute("message", ""); response.sendRedirect("student.jsp");}
			
			//Redirect to login if not found
			if(!found) {
				session.setAttribute("message", "User or password incorrect!");
				response.sendRedirect("login.jsp");
			}
			

		} catch (Exception e) {
			//response.getWriter().append("Exception: " + e).append(request.getContextPath());
		}

	}


}
