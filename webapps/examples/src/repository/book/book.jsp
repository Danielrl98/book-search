<%! 
    ResultSet readBook(Connection conn, Statement stmt, String url) throws Exception {
        String query = "SELECT * FROM book";
        return stmt.executeQuery(query); 
    }
%>

<%! 
    String createUser(
        Connection conn, Statement stmt, String image, 
        String name, String description, String content
    ) throws Exception {

        String result = "";

       try {
            if (conn != null && !conn.isClosed()) {
                // Use PreparedStatement para evitar SQL injection
                String sql = "INSERT INTO book (image, name, description, content) VALUES (?, ?, ?, ?)";
                try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
                    pstmt.setString(1, image);
                    pstmt.setString(2, name);
                    pstmt.setString(3, description);
                    pstmt.setString(4, content);
                    
                    int rowsAffected = pstmt.executeUpdate();
                    
                    if (rowsAffected > 0) {
                        result = "Livro inserido com sucesso!";
                    } else {
                        result = "Nenhum livro foi inserido.";
                    }
                }
            } else {
                result = "Conexão com o banco não está disponível.";
            }
        } catch (SQLException e) {
            result = "Erro ao inserir livro: " + e.getMessage();
        } finally {
            if (stmt != null) stmt.close();
            if (conn != null) conn.close();
        }
        return result;
    }
%>

<%! 
    String test(Connection conn, Statement stmt, String image, 
        String name, String description, String content) {
        return "teste";
    }

%>

<%
    ResultSet read = readBook(conn, stmt, url);
%>

