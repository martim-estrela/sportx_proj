package org.sportx.sportx.servlet;

import com.itextpdf.text.*;
import com.itextpdf.text.pdf.*;
import javax.servlet.*;
import javax.servlet.http.*;
import org.sportx.sportx.DTO.ProductDTO;
import org.sportx.sportx.util.DBConnection;
import org.sportx.sportx.util.StockManagementDAO;

import java.io.IOException;
import java.sql.Connection;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.Set;

public class ProductPdfGeneratorServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Configure response for PDF
        response.setContentType("application/pdf");
        response.setHeader("Content-Disposition", "attachment; filename=products_report.pdf");

        try (Connection conn = DBConnection.getConnection()) {
            StockManagementDAO stockDAO = new StockManagementDAO(conn);

            // Get the same filters being used on the page
            String category = request.getParameter("category");
            String subcategory = request.getParameter("sub-category");
            String brand = request.getParameter("brand");
            String color = request.getParameter("color");
            String size = request.getParameter("size");
            String name = request.getParameter("name");

            // Fetch all products with applied filters (without pagination)
            // By setting page=1 and a very large number for productsPerPage, we get all products
            List<ProductDTO> products = stockDAO.getFilteredProducts(category, subcategory, brand, color, size, name, 1, Integer.MAX_VALUE);

            // Create the PDF document
            Document document = new Document(PageSize.A4);
            PdfWriter.getInstance(document, response.getOutputStream());

            document.open();

            // Add title
            Font titleFont = FontFactory.getFont(FontFactory.HELVETICA_BOLD, 16, BaseColor.BLACK);
            Paragraph title = new Paragraph("Products Report", titleFont);
            title.setAlignment(Element.ALIGN_CENTER);
            document.add(title);

            // Add generation date
            Font normalFont = FontFactory.getFont(FontFactory.HELVETICA, 12, BaseColor.BLACK);
            Paragraph date = new Paragraph("Creation Date: " +
                    LocalDate.now().format(DateTimeFormatter.ofPattern("dd/MM/yyyy")), normalFont);
            date.setAlignment(Element.ALIGN_RIGHT);
            document.add(date);

            // Add filter information
            Paragraph filters = new Paragraph("Filters Applied:", normalFont);
            document.add(filters);

            String categoryText = (category != null && !category.isEmpty()) ? category : "all";
            String subcategoryText = (subcategory != null && !subcategory.isEmpty()) ? subcategory : "all";
            String brandText = (brand != null && !brand.isEmpty()) ? brand : "all";
            String colorText = (color != null && !color.isEmpty()) ? color : "all";
            String sizeText = (size != null && !size.isEmpty()) ? size : "all";
            String nameText = (name != null && !name.isEmpty()) ? name : "all";

            document.add(new Paragraph("Category: " + categoryText, normalFont));
            document.add(new Paragraph("Sub-Category: " + subcategoryText, normalFont));
            document.add(new Paragraph("Brand: " + brandText, normalFont));
            document.add(new Paragraph("Color: " + colorText, normalFont));
            document.add(new Paragraph("Size: " + sizeText, normalFont));
            document.add(new Paragraph("Name: " + nameText, normalFont));

            document.add(Chunk.NEWLINE);

            // Create table for products
            PdfPTable table = new PdfPTable(7); // 7 columns
            table.setWidthPercentage(100);

            // Set column widths
            float[] columnWidths = {0.5f, 2f, 1.5f, 1f, 1f, 0.8f, 1f};
            table.setWidths(columnWidths);

            // Add table headers
            Font headerFont = FontFactory.getFont(FontFactory.HELVETICA_BOLD, 12, BaseColor.WHITE);
            BaseColor headerColor = new BaseColor(44, 62, 80); // Dark blue

            addTableHeader(table, "ID", headerFont, headerColor);
            addTableHeader(table, "Name", headerFont, headerColor);
            addTableHeader(table, "Brand", headerFont, headerColor);
            addTableHeader(table, "Colors", headerFont, headerColor);
            addTableHeader(table, "Sizes", headerFont, headerColor);
            addTableHeader(table, "Stock", headerFont, headerColor);
            addTableHeader(table, "Price (€)", headerFont, headerColor);

            // Add product data
            Font cellFont = FontFactory.getFont(FontFactory.HELVETICA, 10, BaseColor.BLACK);
            BaseColor evenRowColor = new BaseColor(240, 240, 240); // Light gray

            boolean alternate = false;
            for (ProductDTO product : products) {
                BaseColor rowColor = alternate ? evenRowColor : BaseColor.WHITE;

                addTableCell(table, String.valueOf(product.getProductId()), cellFont, rowColor);
                addTableCell(table, product.getName(), cellFont, rowColor);
                addTableCell(table, product.getBrand(), cellFont, rowColor);
                addTableCell(table, formatSet(product.getColors()), cellFont, rowColor);
                addTableCell(table, formatSet(product.getSizes()), cellFont, rowColor);
                addTableCell(table, String.valueOf(product.getStock()), cellFont, rowColor);
                addTableCell(table, String.format("%.2f", product.getPrice()), cellFont, rowColor);

                alternate = !alternate;
            }

            document.add(table);

            // Add footer with total records
            document.add(Chunk.NEWLINE);
            Paragraph total = new Paragraph("Total Records: " + products.size(), normalFont);
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

    // Helper method to format Set<String> as comma-separated String
    private String formatSet(Set<String> set) {
        if (set == null || set.isEmpty()) {
            return "-";
        }

        StringBuilder sb = new StringBuilder();
        boolean first = true;

        for (String item : set) {
            if (!first) {
                sb.append(", ");
            }
            sb.append(item);
            first = false;
        }

        return sb.toString();
    }
}