<%@ page import="java.sql.*" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="/src/config/connect.jsp" %>

<%! 
    String createUser(Connection conn) throws Exception {
        String result = "Erro ao criar";
        
        String sql = "CREATE TABLE IF NOT EXISTS book (" +
                     "ID INTEGER PRIMARY KEY, " +
                     "image VARCHAR(50) NOT NULL, " +
                     "name VARCHAR(50) NOT NULL, " +
                     "description VARCHAR(50) NOT NULL, " +
                     "content VARCHAR(250) NOT NULL, " +
                     "created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, " +
                     "updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP" +
                     ")";

        //sql = "INSERT INTO book (image, name, description, content) VALUES ('capa1.jpg', 'Dom Casmurro', 'Romance de Machado de Assis', 'Texto completo do livro...')";

        //sql  = "DROP TABLE book";
        
        try (Statement stmt = conn.createStatement()) {
            stmt.executeUpdate(sql);
            result = "Tabela criada com sucesso!";
        } catch(SQLException e) {
            throw new Exception("Erro ao criar tabela: " + e.getMessage());
        }
        return result;
    }
%>

<%
    try {
        String resultado = createUser(conn);
        out.println("<h1>" + resultado + "</h1>");
    } catch(Exception e) {
        out.println("<h1>Erro: " + e.getMessage() + "</h1>");
    }
%>

<html>
<body>
    <h1>Status da Criação da Tabela</h1>
    <%
        try {
            String resultado = createUser(conn);
            out.println("<p>" + resultado + "</p>");
        } catch(Exception e) {
            out.println("<p style='color: red;'>Erro: " + e.getMessage() + "</p>");
        }
    %>
</body>
</html>