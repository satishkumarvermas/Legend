<%@page import="java.sql.*"%>
<%@page import="java.io.*"%>
<%
    out.println("<html><body bgcolor=\"pink\">");
    String id = request.getParameter("id");
    String pwd = request.getParameter("pwd");
    String title = request.getParameter("title");
    String count1 = request.getParameter("no");
    String date = request.getParameter("date");
    String cno = request.getParameter("cno");
    int count = Integer.parseInt(count1);
    
    Connection con = null;
    Statement stmt = null;
    ResultSet rs = null;
    ResultSet rs1 = null;
    try {
        Driver d = new oracle.jdbc.driver.OracleDriver();
        DriverManager.registerDriver(d);
        con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:orcl", "scott", "tiger");
        stmt = con.createStatement();
        
        String sqlstmt = "SELECT id, password FROM login";
        rs = stmt.executeQuery(sqlstmt);
        int flag = 0, amount, x;
        
        while (rs.next()) {
            if (id.equals(rs.getString(1)) && pwd.equals(rs.getString(2))) {
                flag = 1;
                break;
            }
        }
        
        if (flag == 0) {
            out.println("SORRY INVALID ID. PLEASE TRY AGAIN.<br><br>");
            out.println("<a href=\"/tr1/order.html\">Press HERE to RETRY</a>");
        } else {
            Statement stmt2 = con.createStatement();
            String s = "SELECT cost FROM book WHERE title='" + title + "'";
            rs1 = stmt2.executeQuery(s);
            int flag1 = 0;
            
            while (rs1.next()) {
                flag1 = 1;
                x = Integer.parseInt(rs1.getString(1));
                amount = count * x;
                out.println("AMOUNT: " + amount + "<br><br><br><br>");
                Statement stmt1 = con.createStatement();
                stmt1.executeUpdate("INSERT INTO details VALUES('" + id + "','" + title + "'," + amount + ",'" + date + "','" + cno + "')");
                out.println("YOUR ORDER HAS BEEN PLACED<br>");
            }
            
            if (flag1 == 0) {
                out.println("SORRY INVALID BOOK. PLEASE TRY AGAIN.<br><br>");
                out.println("<a href=\"/tr1/order.html\">Press HERE to RETRY</a>");
            }
        }
    } catch (Exception e) {
        out.println("An error occurred: " + e.getMessage());
    } finally {
        try {
            if (rs != null) rs.close();
            if (rs1 != null) rs1.close();
            if (stmt != null) stmt.close();
            if (con != null) con.close();
        } catch (SQLException e) {
            out.println("An error occurred while closing resources: " + e.getMessage());
        }
    }
    out.println("</body></html>");
%>
