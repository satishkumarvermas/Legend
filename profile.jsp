<%@page import="java.sql.*"%>
<%@page import="java.io.*"%>
<%
    out.println("<html><body bgcolor=\"pink\">");
    String id = request.getParameter("id");
    Connection con = null;
    Statement stmt = null;
    ResultSet rs = null;
    try {
        Driver d = new oracle.jdbc.driver.OracleDriver(); 
        DriverManager.registerDriver(d);
        con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:orcl", "scott", "tiger");
        stmt = con.createStatement();
        String sqlstmt = "SELECT * FROM login WHERE id='" + id + "'";
        rs = stmt.executeQuery(sqlstmt);
        int flag = 0;
        while (rs.next()) {
            out.println("<div align=\"center\">");
            out.println("NAME: " + rs.getString(1) + "<br>");
            out.println("ADDRESS: " + rs.getString(2) + "<br>");
            out.println("PHONE NO: " + rs.getString(3) + "<br>");
            out.println("</div>");
            flag = 1;
        }
        if (flag == 0) {
            out.println("SORRY, INVALID ID. PLEASE TRY AGAIN.<br><br>");
            out.println("<a href=\"/tr1/profile.html\">Press HERE to RETRY</a>");
        }
    } catch (Exception e) {
        out.println("An error occurred: " + e.getMessage());
    } finally {
        try {
            if (rs != null) rs.close();
            if (stmt != null) stmt.close();
            if (con != null) con.close();
        } catch (SQLException e) {
            out.println("An error occurred while closing resources: " + e.getMessage());
        }
    }
    out.println("</body></html>");
%>
