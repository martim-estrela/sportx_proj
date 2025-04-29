package org.sportx.sportx.servlet;

import com.itextpdf.text.*;
import com.itextpdf.text.pdf.*;
import javax.servlet.*;
import javax.servlet.http.*;
import org.sportx.sportx.model.User;
import org.sportx.sportx.util.DBConnection;
import org.sportx.sportx.util.UserDAO;

import java.io.IOException;
import java.sql.Connection;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.List;


public class UserPdfGeneratorServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Configurar resposta para PDF
        response.setContentType("application/pdf");
        response.setHeader("Content-Disposition", "attachment; filename=users_report.pdf");

        try (Connection conn = DBConnection.getConnection()) {
            UserDAO userDAO = new UserDAO(conn);

            // Obter os mesmos filtros que estão a ser usados na página
            String role = request.getParameter("role");
            String name = request.getParameter("name");

            // Buscar todos os utilizadores com os filtros aplicados (sem paginação)
            List<User> users = userDAO.getAllUsersForReport(role, name);

            // Criar o documento PDF
            Document document = new Document(PageSize.A4);
            PdfWriter.getInstance(document, response.getOutputStream());

            document.open();

            // Adicionar título
            Font titleFont = FontFactory.getFont(FontFactory.HELVETICA_BOLD, 16, BaseColor.BLACK);
            Paragraph title = new Paragraph("Users Report", titleFont);
            title.setAlignment(Element.ALIGN_CENTER);
            document.add(title);

            // Adicionar data de geração
            Font normalFont = FontFactory.getFont(FontFactory.HELVETICA, 12, BaseColor.BLACK);
            Paragraph date = new Paragraph("Creation Date: " +
                    LocalDate.now().format(DateTimeFormatter.ofPattern("dd/MM/yyyy")), normalFont);
            date.setAlignment(Element.ALIGN_RIGHT);
            document.add(date);

            // Adicionar informações dos filtros
            Paragraph filters = new Paragraph("Filters Applied:", normalFont);
            document.add(filters);

            String roleText = (role != null && !role.isEmpty()) ? role : "all";
            String nameText = (name != null && !name.isEmpty()) ? name : "all";

            document.add(new Paragraph("User Type: " + roleText, normalFont));
            document.add(new Paragraph("Name: " + nameText, normalFont));

            document.add(Chunk.NEWLINE);

            // Criar tabela para os usuários
            PdfPTable table = new PdfPTable(6); // 6 colunas
            table.setWidthPercentage(100);

            // Definir larguras das colunas
            float[] columnWidths = {0.5f, 2f, 1f, 2.5f, 1f, 1.5f};
            table.setWidths(columnWidths);

            // Adicionar cabeçalhos da tabela
            Font headerFont = FontFactory.getFont(FontFactory.HELVETICA_BOLD, 12, BaseColor.WHITE);
            BaseColor headerColor = new BaseColor(44, 62, 80); // Azul escuro

            addTableHeader(table, "ID", headerFont, headerColor);
            addTableHeader(table, "Name", headerFont, headerColor);
            addTableHeader(table, "Type", headerFont, headerColor);
            addTableHeader(table, "Email", headerFont, headerColor);
            addTableHeader(table, "Status", headerFont, headerColor);
            addTableHeader(table, "Register Date", headerFont, headerColor);

            // Adicionar dados dos utilizadores
            Font cellFont = FontFactory.getFont(FontFactory.HELVETICA, 10, BaseColor.BLACK);
            BaseColor evenRowColor = new BaseColor(240, 240, 240); // Cinza claro

            boolean alternate = false;
            for (User user : users) {
                BaseColor rowColor = alternate ? evenRowColor : BaseColor.WHITE;

                addTableCell(table, String.valueOf(user.getUserId()), cellFont, rowColor);
                addTableCell(table, user.getName(), cellFont, rowColor);
                addTableCell(table, user.getUserType(), cellFont, rowColor);
                addTableCell(table, user.getEmail(), cellFont, rowColor);
                addTableCell(table, user.getStatus(), cellFont, rowColor);
                addTableCell(table, user.getRegisterDate().format(DateTimeFormatter.ofPattern("dd/MM/yyyy")), cellFont, rowColor);

                alternate = !alternate;
            }

            document.add(table);

            // Adicionar rodapé com total de registros
            document.add(Chunk.NEWLINE);
            Paragraph total = new Paragraph("Total Records: " + users.size(), normalFont);
            total.setAlignment(Element.ALIGN_RIGHT);
            document.add(total);

            document.close();

        } catch (Exception e) {
            e.printStackTrace();
            response.setContentType("text/html");
            response.getWriter().println("Error generating PDF: " + e.getMessage());
        }
    }

    private void addTableHeader(PdfPTable table, String text, Font font, BaseColor backgroundColor) {
        PdfPCell cell = new PdfPCell(new Phrase(text, font));
        cell.setBackgroundColor(backgroundColor);
        cell.setHorizontalAlignment(Element.ALIGN_CENTER);
        cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
        cell.setPadding(5);
        table.addCell(cell);
    }

    private void addTableCell(PdfPTable table, String text, Font font, BaseColor backgroundColor) {
        PdfPCell cell = new PdfPCell(new Phrase(text, font));
        cell.setBackgroundColor(backgroundColor);
        cell.setHorizontalAlignment(Element.ALIGN_CENTER);
        cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
        cell.setPadding(4);
        table.addCell(cell);
    }
}