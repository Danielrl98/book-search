<%
    String path = application.getRealPath("/");
    String clean = path.replace("\\", "/");
    String url = "jdbc:sqlite:" + clean + "banco.db";
    Connection conn = null;
    Statement stmt = null;
    Class.forName("org.sqlite.JDBC");
    conn = DriverManager.getConnection(url);
    stmt = conn.createStatement();

    // Connection connCreate = DriverManager.getConnection(url);
    // Statement stmtCreate = conn.createStatement();
%>
