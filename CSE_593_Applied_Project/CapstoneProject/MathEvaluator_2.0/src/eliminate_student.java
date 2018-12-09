

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class eliminate_student
 */
@WebServlet(description = "This servlet's function is to eliminate students from database", urlPatterns = { "/eliminate_student" })
public class eliminate_student extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
  
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			HttpSession session = request.getSession();
			//Connection to the USA database
			//Connection con = DriverManager.getConnection("jdbc:mysql://mydb.chkafory7bnl.us-east-1.rds.amazonaws.com","capstone","123456?!");
			Connection con = DriverManager.getConnection("jdbc:mysql://mydbinstance.chkafory7bnl.us-east-1.rds.amazonaws.com","capstone","123456?!");
			Statement stmt = con.createStatement();
			if(request.getParameter("ID")==null) {
				session.setAttribute("message", "You must input an ID!");
			}
			String sql = "DELETE from dbDevil.students WHERE `id`=" + "\'"+request.getParameter("ID").toString() + "\'";
					
			int answer = stmt.executeUpdate(sql);
			if (answer == 1) {
				session.setAttribute("message", "You successfully eliminated the student!");
			}else {
				session.setAttribute("message", "Student with that ID wasn't found!");
			}
			
			response.sendRedirect("eliminate_student.jsp");

		} catch (Exception e) {
			System.out.print(e);
		}

	}

}
