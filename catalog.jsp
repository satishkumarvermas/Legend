<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<%
    // Print HTML start tag
    out.println("<html><body bgcolor=\"pink\">");
    // Get the title parameter from the request
    String title = request.getParameter("title");
    // Declare variables for database connection and statement
    Connection con = null;
    Statement stmt = null;
    try {
        // Load the Oracle JDBC driver
        Class.forName("oracle.jdbc.driver.OracleDriver");
        // Create a connection to the database
        con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:orcl", "scott", "tiger");
        // Create a statement
        stmt = con.createStatement();
        // Construct SQL statement to select book by title
        String sqlstmt = "SELECT * FROM book WHERE title='" + title + "'";
        // Execute the query
        ResultSet rs = stmt.executeQuery(sqlstmt);
        // Initialize flag to check if book found
        int flag = 0;
        // Iterate through the result set
        while (rs.next()) {
            // Print book details
            out.println("<div align=\"center\">");
            out.println("TITLE: " + rs.getString(1) + "<br>");
            out.println("AUTHOR: " + rs.getString(2) + "<br>");
            out.println("VERSION: " + rs.getString(3) + "<br>");
            out.println("PUBLISHER: " + rs.getString(4) + "<br>");
            out.println("COST: " + rs.getString(5) + "<br>");
            out.println("</div>");
            // Set flag to indicate book found
            flag = 1;
        }
        // If book not found, print error message
        if (flag == 0) {
            out.println("SORRY, INVALID TITLE. PLEASE TRY AGAIN.<br><br>");
            out.println("<a href=\"/tr1/catalog.html\">Press HERE to RETRY</a>");
        }
        // Close result set
        rs.close();
    } catch (Exception e) {
        // Print any exceptions that occur
        out.println("An error occurred: " + e.getMessage());
    } finally {
        // Close statement and connection
        try {
            if (stmt != null) stmt.close();
            if (con != null) con.close();
        } catch (SQLException e) {
            out.println("An error occurred while closing resources: " + e.getMessage());
        }
    }
    // Print HTML end tag
    out.println("</body></html>");
%>

