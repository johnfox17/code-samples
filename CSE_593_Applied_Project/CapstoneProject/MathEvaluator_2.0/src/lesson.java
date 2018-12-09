
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.Iterator;
import java.util.LinkedHashSet;
import java.util.concurrent.ThreadLocalRandom;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class lesson
 */
@WebServlet(description = "The lesson is selected depending on the level of the student and presented for him to solve.", urlPatterns = {
		"/lesson" })
public class lesson extends HttpServlet {
	private static final long serialVersionUID = 1L;
	//int k;
	int[] problemNumArray;

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		try {
			problemNumArray=problem_order();
			// Accessing the session information
			HttpSession session = request.getSession();
			String chapter = session.getAttribute("chapter").toString();// Specific chapter to be tested on
			String difficulty = session.getAttribute("difficulty").toString();// Specific difficulty of chapter to be
																				// tested on

			// Locating problem to display
			String problem = locate_problem(Integer.toString(problemNumArray[0]), chapter, difficulty);
			// Locate solution with same function just by adding "_solution" we an access
			// the solution in the database
			String diff_sol = difficulty + "_solution";
			// session.setAttribute("old_solution",session.getAttribute("solution").toString());
			String solution = locate_problem(Integer.toString(problemNumArray[0]), chapter, diff_sol);

			session.setAttribute("problemOrder", problemNumArray);
			session.setAttribute("problem", problem);
			session.setAttribute("solution", solution);
			session.setAttribute("message", "Click to submit your answer.");
			session.setAttribute("probNum", 1);
			session.setAttribute("numCorrect", 0);
			

//			if (!found) {
//				System.out.println("Lesson was not found");
//			}

			response.sendRedirect("lessonDisplay.jsp");
		} catch (Exception e) {
			System.out.println(e);
		}
	}

	// This function returns a problem in form of a String. It randomly calculates
	// the order of problems to be displayed
	// via a linkedhashset of integers. After that it locates a specific problem by
	// knowing the lesson and the problem number
	// in an AWS database
	// *****************************************
	// public LinkedHashSet<Integer> problem_order() {
	public int[] problem_order() {
		int num_problems = 0;

		LinkedHashSet<Integer> prob_order = new LinkedHashSet<Integer>();
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection con = DriverManager.getConnection(
					"jdbc:mysql://mydbinstance.chkafory7bnl.us-east-1.rds.amazonaws.com", "capstone", "123456?!");
			Statement stmt = con.createStatement();

			// Calculate the number of problems available in specific lesson
			String sql = "SELECT COUNT(*) FROM dbDevil.integers";
			ResultSet rs = stmt.executeQuery(sql);
			while (rs.next()) {
				num_problems = rs.getInt("COUNT(*)");
			}

			// Create random order linkedhashset
			while (prob_order.size() < num_problems) {
				int randomNum = ThreadLocalRandom.current().nextInt(1, num_problems + 1);
				prob_order.add(randomNum - 1);
			}
		} catch (Exception e) {
			System.out.println(e);
		}
		return (create_array(prob_order));

	}

	// ***// This function will help us create a problem order array
	// ***//

	public int[] create_array(LinkedHashSet<Integer> problemOrder) {
		try {
			//System.out.println("PRINTING PROBLEM ORDER" + problemOrder);
			// Iterator to facilitate transfer to array
			Iterator<Integer> itr = problemOrder.iterator();
			// Array of problem set
			int[] problemNumArray = new int[problemOrder.size()];
			// Counter for transfer of data into array
			int i = 0;
			// Placing problem set into array
			while (itr.hasNext()) {
				problemNumArray[i] = itr.next();
				i++;
			}
			return problemNumArray;
		} catch (Exception e) {
			System.out.println(e);
		}
		return problemNumArray;
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
