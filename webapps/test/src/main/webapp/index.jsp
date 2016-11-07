<%@ page import="java.sql.*,java.net.*"%>
<html>
<head>
    <title>JDBC Connection example</title>
</head>

<body>
<h1>JDBC Connection example</h1>

<%
    try {
        java.sql.Connection con;
        Class.forName("com.mysql.jdbc.Driver");
        con = DriverManager.getConnection("jdbc:mysql://mariadb/mysql", "root", "test");
        out.println ("database successfully opened.");
        out.println("hostname: " + InetAddress.getLocalHost().getHostName());
        out.println ("IP: " + InetAddress.getLocalHost().getAddress());
    }
    catch(SQLException e) {
        out.println("SQLException caught: " +e.getMessage());
    }
%>

</body>
</html>

