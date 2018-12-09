
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
 * Servlet implementation class create_student
 */
@WebServlet("/create_student")
public class create_student extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		try {
			int num_accounts = 0;
			// Accessing the session information
			HttpSession session = request.getSession();
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection con = DriverManager.getConnection(
					"jdbc:mysql://mydbinstance.chkafory7bnl.us-east-1.rds.amazonaws.com", "capstone", "123456?!");
			Statement stmt = con.createStatement();

			// returning if any field is empty
			if (request.getParameter("ID").toString() == "" || request.getParameter("first_name").toString() == ""
					|| request.getParameter("last_name") == "" || request.getParameter("age") == ""
					|| request.getParameter("password") == "") {
				session.setAttribute("message", "All entries must be full!");
				response.sendRedirect("sign_up_page.jsp");
			}

			// Calculate the number of people with same account number, we stick to one per
			// person of course
			String sql = "SELECT COUNT(*) FROM dbDevil.students WHERE id=" + request.getParameter("ID").toString();
			ResultSet rs = stmt.executeQuery(sql);
			while (rs.next()) {
				num_accounts = rs.getInt("COUNT(*)");
			}

			
			if (num_accounts == 1) {
				session.setAttribute("message", "The ID number is already used!");
				response.sendRedirect("sign_up_page.jsp");
			}

			// Create account in databa with the given information
			// int answer = stmt.executeUpdate(sql);
			// System.out.println(answer);

			sql = "INSERT INTO dbDevil.students (`id`, `first_name`,`last_name`,`age`, `level`, `password`) VALUES "
					+ "(" + "\'" + request.getParameter("ID").toString() + "\'" + "," + "\'"
					+ request.getParameter("first_name").toString() + "\'" + "," + "\'"
					+ request.getParameter("last_name").toString() + "\'" + "," + "\'"
					+ request.getParameter("age").toString() + "\'" + "," + "\'" + '1' + "\'" + "," + "\'"
					+ request.getParameter("password").toString() + "\'" + ")";

			int answer = stmt.executeUpdate(sql);
			if (answer == 1) {
				session.setAttribute("message", "Student was successfully added to the database");
				response.sendRedirect("sign_up_page.jsp");
			} else {
				session.setAttribute("message", "Student couldn't be added to the database");
				response.sendRedirect("sign_up_page.jsp");
			}
		} catch (Exception e) {
			System.out.print(e);
		}
	}

}
