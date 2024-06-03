<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<%
    out.println("<html><body bgcolor=\"pink\">");
    String id = request.getParameter("id");
    String pwd = request.getParameter("pwd");
    Connection con = null;
    Statement stmt = null;
    try {
        Driver d = new oracle.jdbc.driver.OracleDriver();
        DriverManager.registerDriver(d);
        con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:orcl", "scott", "tiger");
        stmt = con.createStatement();
        String sqlstmt = "SELECT id, password FROM login WHERE id='" + id + "' AND password='" + pwd + "'";
        ResultSet rs = stmt.executeQuery(sqlstmt);
        int flag = 0;
        while (rs.next()) {
            flag = 1;
        }
        if (flag == 0) {
            out.println("SORRY, INVALID ID. PLEASE TRY AGAIN.<br><br>");
            out.println("<a href=\"/tr1/login.html\">Press LOGIN to RETRY</a>");
        } else {
            out.println("VALID LOGIN ID<br><br>");
            out.println("<h3><ul>");
            out.println("<li><a href=\"profile.html\"><font color=\"black\">USER PROFILE</font></a></li><br><br>");
            out.println("<li><a href=\"catalog.html\"><font color=\"black\">BOOKS CATALOG</font></a></li><br><br>");
            out.println("<li><a href=\"order.html\"><font color=\"black\">ORDER CONFIRMATION</font></a></li><br><br>");
            out.println("</ul>");
        }
        rs.close();
    } catch (Exception e) {
        out.println("An error occurred: " + e.getMessage());
    } finally {
        try {
            if (stmt != null) stmt.close();
            if (con != null) con.close();
        } catch (SQLException e) {
            out.println("An error occurred while closing resources: " + e.getMessage());
        }
    }
    out.println("</body></html>");
%>
