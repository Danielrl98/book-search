<%
    String url = "jdbc:sqlite:C:/Users/daniel.resende_judit/Downloads/apache-tomcat-9.0.112-windows-x64/apache-tomcat-9.0.112/webapps/examples/banco3.db";
    Connection conn = null;
    Statement stmt = null;
    Class.forName("org.sqlite.JDBC");
    conn = DriverManager.getConnection(url);
    stmt = conn.createStatement();

    Connection connCreate = DriverManager.getConnection(url);
    Statement stmtCreate = conn.createStatement();
%>