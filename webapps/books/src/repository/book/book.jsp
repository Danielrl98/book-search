<%! 
    ResultSet readBook(Connection conn, Statement stmt, String url) throws Exception {
        String query = "SELECT * FROM book";
        return stmt.executeQuery(query); 
    }
%>

<%! 
    String createBook(
        Connection conn, 
        String image, 
        String name, 
        String description, 
        String content
    ) throws Exception {
        String result = "";
      
        try {
            if (conn != null && !conn.isClosed()) {
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
                    pstmt.close();
                }
            } else {
                result = "Conexão com o banco não está disponível.";
            }
        } catch (SQLException e) {
            result = "Erro ao inserir livro: " + e.getMessage();
        }
        return result;
    }
%>
<%! 

String deleteBook(Connection conn, int id) throws Exception {
        String result = "Error";

        try {
            if (conn != null && !conn.isClosed()) {
                String sql = "DELETE FROM book WHERE id = ?";
                try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
                    pstmt.setInt(1, id);

                    int rowsAffected = pstmt.executeUpdate();

                    if (rowsAffected > 0) {
                        result = "Livro deletado com sucesso!";
                    } else {
                        result = "Nenhum livro foi deletado.";
                    }
                    pstmt.close();
                }
            } else {
                result = "Conexão com o banco não está disponível.";
            }
        } catch (SQLException e) {
            result = "Erro ao deletar livro: " + e.getMessage();
        }
        return result;
    }

%>

<%! 
    String updateBook(
        Connection conn,
        int id,
        String image,
        String name,
        String description,
        String content
    ) throws Exception {
        String result = "";

        try {
            if (conn != null && !conn.isClosed()) {
                String sql = "UPDATE book SET image = ?, name = ?, description = ?, content = ? WHERE id = ?";
                try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
                    pstmt.setString(1, image);
                    pstmt.setString(2, name);
                    pstmt.setString(3, description);
                    pstmt.setString(4, content);
                    pstmt.setInt(5, id);

                    int rowsAffected = pstmt.executeUpdate();

                    if (rowsAffected > 0) {
                        result = "Livro atualizado com sucesso!";
                    } else {
                        result = "Nenhum livro foi atualizado.";
                    }
                }
            } else {
                result = "Conexão com o banco não está disponível.";
            }
        } catch (SQLException e) {
            result = "Erro ao atualizar livro: " + e.getMessage();
        }
        return result;
    }


%>

<%
    ResultSet read = readBook(conn, stmt, url);
%>

