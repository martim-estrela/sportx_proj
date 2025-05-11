package org.sportx.sportx.servlet;

import org.sportx.sportx.dao.ShippingMethodDAO;
import org.sportx.sportx.model.ShippingMethod;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;

public class UpdateShippingMethodServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();

        try {
            // Obter o ID do método de envio selecionado
            int shippingMethodId = Integer.parseInt(request.getParameter("shippingMethodId"));

            // Buscar o método de envio do banco de dados
            ShippingMethodDAO shippingMethodDAO = new ShippingMethodDAO();
            ShippingMethod selectedMethod = shippingMethodDAO.getShippingMethodById(shippingMethodId);

            if (selectedMethod != null) {
                // Armazenar na sessão
                HttpSession session = request.getSession();
                session.setAttribute("selectedShippingMethod", selectedMethod);

                // Retornar sucesso
                out.println("{\"success\": true}");
            } else {
                out.println("{\"success\": false, \"error\": \"Shipping method not found\"}");
            }

        } catch (Exception e) {
            out.println("{\"success\": false, \"error\": \"" + e.getMessage() + "\"}");
        }
    }
}