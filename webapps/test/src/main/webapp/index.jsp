<%@ page import="java.sql.*"%>
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
    }
    catch(SQLException e) {
        out.println("SQLException caught: " +e.getMessage());
    }
%>

</body>
</html>
