
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
 * Servlet implementation class checkSolution
 */
@WebServlet("/checkSolution")
public class checkSolution extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		HttpSession session = request.getSession(false);
		// Variable to store submitted answer
		String answer = request.getParameter("answer");
		
		// Variable to store solution
		String solution = session.getAttribute("solution").toString();
		// variable to store problem order
		int[] problemOrder = (int[]) session.getAttribute("problemOrder");
		// Variable to store current problem location in array probelmOrder
		int probNum = Integer.valueOf(session.getAttribute("probNum").toString());

		// If answer and solution are equal then add one to numCorrect; which is the
		// number of correct responses.
		if (answer.equals(solution)) {
			session.setAttribute("numCorrect", (int) session.getAttribute("numCorrect") + 1);
		}
		//System.out.println(session.getAttribute("numCorrect").toString() + "/" + probNum);
		if (probNum < problemOrder.length) {
			// Since locate_problem requires a string we convert problemOrder to a string
			String prob = Integer.toString(problemOrder[probNum]);
			// Locate new problem
			String problem = locate_problem((String) prob, session.getAttribute("chapter").toString(),
					session.getAttribute("difficulty").toString());
			session.setAttribute("problem", problem);

			// Locate solution with same function just by adding "_solution" we an access
			// the solution in the database
			String diff_sol = session.getAttribute("difficulty").toString() + "_solution";
			solution = locate_problem((String) prob, session.getAttribute("chapter").toString(), diff_sol);
			session.setAttribute("solution", solution);

			// get new index of next problem to be solved next
			probNum = Integer.valueOf(session.getAttribute("probNum").toString()) + 1;
			session.setAttribute("probNum", probNum);

			response.sendRedirect("lessonDisplay.jsp");
		} else {
			response.sendRedirect("gradeDisplay.jsp");
		}
	}

	// Locates specific problem from database when the lesson and problem number is
	// known
	public String locate_problem(String probNum, String chapter, String difficulty) {
		String problem = "";
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection con = DriverManager.getConnection(
					"jdbc:mysql://mydbinstance.chkafory7bnl.us-east-1.rds.amazonaws.com", "capstone", "123456?!");
			Statement stmt = con.createStatement();

			// Calculate the number of problems available in specific lesson
			String sql = "SELECT " + difficulty + " FROM dbDevil" + "." + chapter + " WHERE number=" + probNum;
			ResultSet rs = stmt.executeQuery(sql);
			while (rs.next()) {
				problem = rs.getString(difficulty);
			}
		} catch (Exception e) {
			System.out.println(e);
		}

		return problem;
	}

}
