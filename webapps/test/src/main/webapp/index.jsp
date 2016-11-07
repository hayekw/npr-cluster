<%@ page import="java.sql.*,java.net.*"%>
<html>
<head>
    <title>JDBC Connection example</title>
</head>

<body>
<h1>JDBC Connection example</h1>

<%
    Connection con = null;
    try {
        Class.forName("com.mysql.jdbc.Driver");
        con = DriverManager.getConnection("jdbc:mysql://mariadb/mysql", "root", "test");
        out.println ("database successfully opened.");
        out.println("hostname: " + InetAddress.getLocalHost().getHostAddress());
    }
    catch(SQLException e) {
        out.println("SQLException caught: " +e.getMessage());
    }
    finally {
        if(con != null) {
            try {
                con.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
%>

</body>
</html>

