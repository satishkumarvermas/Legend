<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<%
    out.println("<html><body bgcolor=\"pink\">");
    String name = request.getParameter("name");
    String addr = request.getParameter("addr");
    String phno = request.getParameter("phno");
    String id = request.getParameter("id");
    String pwd = request.getParameter("pwd");
    int no = Integer.parseInt(phno);
    
    Connection con = null;
    Statement stmt = null;
    ResultSet rs = null;
    try {
        Driver d = new oracle.jdbc.driver.OracleDriver(); 
        DriverManager.registerDriver(d);
        con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:orcl", "scott", "tiger");
        stmt = con.createStatement();
        String sqlstmt = "SELECT id FROM login";
        rs = stmt.executeQuery(sqlstmt);
        int flag = 0;
        while (rs.next()) {
            if (id.equals(rs.getString(1))) {
                flag = 1;
                break;
            }
        }
        if (flag == 1) {
            out.println("SORRY, LOGIN ID ALREADY EXISTS. PLEASE TRY AGAIN WITH A NEW ID.<br><br>");
            out.println("<a href=\"/tr1/reg.html\">Press REGISTER to RETRY</a>");
        } else {
            Statement stmt1 = con.createStatement(); 
            stmt1.executeUpdate("INSERT INTO login VALUES('" + name + "','" + addr + "'," + no + ",'" + id + "','" + pwd + "')");
            out.println("YOUR DETAILS HAVE BEEN ENTERED.<br><br>");
            out.println("<a href=\"/tr1/login.html\">Press LOGIN to login</a>");
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
