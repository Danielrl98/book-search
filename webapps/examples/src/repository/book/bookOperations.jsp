<%@ page import="java.sql.*" %>

<%!
    /**
     * Busca todos os livros do banco de dados
     * @param conn Conexão com o banco
     * @param stmt Statement da conexão
     * @return ResultSet com os livros
     */
    ResultSet readBook(Connection conn, Statement stmt, String url) throws Exception {
        String query = "SELECT * FROM book";
        return stmt.executeQuery(query);
    }

    /**
     * Cria um novo livro no banco de dados
     * @param conn Conexão com o banco
     * @param image URL da imagem
     * @param name Nome do livro
     * @param description Descrição do livro
     * @param content Conteúdo do livro
     * @return Mensagem de sucesso ou erro
     */
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
                }
            } else {
                result = "Conexão com o banco não está disponível.";
            }
        } catch (SQLException e) {
            result = "Erro ao inserir livro: " + e.getMessage();
        }
        return result;
    }

    /**
     * Atualiza um livro no banco de dados
     * @param conn Conexão com o banco
     * @param id ID do livro
     * @param image URL da imagem
     * @param name Nome do livro
     * @param description Descrição do livro
     * @param content Conteúdo do livro
     * @return Mensagem de sucesso ou erro
     */
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

    /**
     * Deleta um livro do banco de dados
     * @param conn Conexão com o banco
     * @param id ID do livro
     * @return Mensagem de sucesso ou erro
     */
    String deleteBook(Connection conn, int id) throws Exception {
        String result = "";

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
                }
            } else {
                result = "Conexão com o banco não está disponível.";
            }
        } catch (SQLException e) {
            result = "Erro ao deletar livro: " + e.getMessage();
        }
        return result;
    }

    /**
     * Busca um livro específico por ID
     * @param conn Conexão com o banco
     * @param id ID do livro
     * @return ResultSet com os dados do livro
     */
    ResultSet getBookById(Connection conn, int id) throws Exception {
        String query = "SELECT * FROM book WHERE id = ?";
        PreparedStatement pstmt = conn.prepareStatement(query);
        pstmt.setInt(1, id);
        return pstmt.executeQuery();
    }
%>
