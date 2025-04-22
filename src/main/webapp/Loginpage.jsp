<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>SPORTX</title>
    <link href="https://fonts.googleapis.com/css2?family=Nunito+Sans:wght@400;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles_Loginpage.css">
</head>

<body>
<header>
    <section class="headerSportx">
        <h1>SPORTX</h1>
    </section>
</header>

<main>
    <section class="login-container">
        <h1>Login</h1>
        <p>Please login using account details below.</p>

        <!-- Exibir mensagem de erro se login falhar -->
        <c:if test="${param.error == 'true'}">
            <div style="color: #218A38; font-weight: bold;">Invalid email or password. Please try again.</div>
        </c:if>

        <form action="${pageContext.request.contextPath}/LoginServlet" method="POST">
            <label >Email Address</label>
            <input type="email" name="email" required />

            <label>Password</label>
            <input type="password" name="password" required />

            <button type="submit">Sign In</button>
        </form>
        <p>Don't have an account? <a href="${pageContext.request.contextPath}/Sign_up_Page.jsp">Create Account</a></p>
    </section>
</main>
</body>

</html>
