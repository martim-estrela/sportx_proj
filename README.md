# 🏪 SportX – Projeto Universitário
**Tecnologia:** Java (MVC com JSP + Servlets + DAO + MySQL)

---

## ✅ 1. Base de Dados
- [x] Implementar base de dados

---

## ✅ 2. Model – Classes de Domínio
### Classes criadas:
- [x] `User.java`
- [x] `Product.java`
- [x] `ProductCategoryChild.java`
- [x] `ProductCategoryParent.java`
- [x] `ProductItem.java`
- [x] `OrderStatus.java`
- [x] `Order.java`
- [x] `PaymentInfo.java`
- [x] `PaymentType.java`
- [x] `Promotion.java`
- [x] `ShippingMethod.java`
- [x] `Variation.java`
- [x] `VariationOption.java`
- [x] `Ticket.java`

### Métodos essenciais:
- [x] Getters e Setters
- [x] Construtores
- [x] (Alguns) Métodos auxiliares

---

## 🔧 3. DAO – Acesso a Dados
### DAOs criados:
- [x] `DBConnection`
- [x] `UserDAO.java`
- [x] `TicketDAO.java`
- [x] `StockManagementDAO.java`
- [ ] `ProductDAO.java`
- [ ] `PaymentDAO.java`
- [ ] `OrderDAO.java`

### Métodos implementados (parcialmente):
- [x] `inserir(...)`
- [x] `atualizar(...)`
- [x] `eliminar(...)`
- [x] `buscarPorId(...)`
- [x] `listarTodos(...)`

---

## 🚦 4. Controller – Servlets
### Servlets criados:
- [x] `UserServlet.java`
- [x] `ProductServlet.java`
- [x] `SignUpServlet.java`
- [x] `LoginServlet.java`
- [x] `StockManagementServlet.java`
- [x] `TicketServlet.java`
- [x] `AddressServlet.java`
- [ ] `PaymentServlet.java`
- [ ] `OrderServlet.java`

### Ações implementadas:
- [x] `listar`
- [x] `criar` / `inserir`
- [x] `editar` / `atualizar`
- [x] `eliminar`
- [x] `request.setAttribute(...)` + `RequestDispatcher` para envio de dados à View

---

## 💻 5. View – JSP
### Páginas JSP criadas:
- [x] `Loginpage.jsp`
- [x] `AdminPage_StockManagement.jsp`
- [x] `AdminPage_UserManagement.jsp`
- [x] `Chat_Page.jsp`
- [x] `CheckoutPage.jsp`
- [x] `ContactUs.jsp`
- [x] `FAQ.jsp`
- [x] `index.jsp`
- [x] `Orderhistory.jsp`
- [x] `ProductPage.jsp`
- [x] `ProfilePage.jsp`
- [x] `SearchBrowse.jsp`
- [x] `ShoppingCart_Page.jsp`
- [x] `Sign_up_Page.jsp`


- [] Integrar JSP com servlets usando JSTL/EL:
  - [ ] Admin_StockManagement.jsp
    - [ ] Listar Produtos
    - [ ] Filtrar Produtos
    - [ ] Gerar pdf com relatório de stock
    - [ ] Desenvolver funcionaliadade para adição de produtos
  - [ ] Admin_UserManagement.jsp
    - [ ] Listar Users
    - [ ] Filtar Users
    - [ ] Gerar pdf com relatorio de users
    - [ ] Desenvolver funcionaliadade para adição de users
      ```jsp
      <c:forEach var="produto" items="${listaProdutos}">
          <tr>
              <td>${produto.nome}</td>
              <td>${produto.preco}</td>
          </tr>
      </c:forEach>



Colocar encriptação nas palavras pass