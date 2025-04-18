<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>SPORTX - Sign Up</title>
    <link href="https://fonts.googleapis.com/css2?family=Nunito+Sans:wght@400;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles_SignupPage.css">
</head>

<body>
<header>
    <section class="headerSportx">
        <h1>SPORTX</h1>
    </section>
</header>

<main>
    <section class="SignUp-container">
        <h1>Sign Up</h1>
        <p>Please complete all required fields to create your account.</p>

        <!-- Exibir mensagem de erro caso o parâmetro error=true esteja presente -->
        <c:if test="${param.error == 'true'}">
            <div style="color: #218A38; font-weight: bold;">There was an error during sign-up. Please try again.</div>
            <div style="color: #218A38; font-weight: bold;">Password must be at least 8 characters long.</div>
        </c:if>

        <form action="${pageContext.request.contextPath}/SignUpServlet" method="POST">
            <label for="username">Username:</label>
            <input type="text" name="username" id="username" placeholder="Enter your username" required />

            <label for="email">Email Address:</label>
            <input type="email" name="email" id="email" placeholder="Enter your email" required />

            <label for="phonenumber">Phone Number:</label>
            <input type="tel" name="phonenumber" id="phonenumber" placeholder="Enter your phone number" required />

            <label for="password">Password:</label>
            <input type="password" name="password" id="password" placeholder="Enter your password" required />

            <button type="submit">Sign Up</button>
        </form>

        <p>Already have an account? <a href="${pageContext.request.contextPath}/Loginpage.jsp">Login</a></p>
    </section>

    <section class="support">
        <h2>Support</h2>
        <ul>
            <li><a href="ContactUs.jsp">Contact us</a></li>
            <li><a href="FAQ.jsp">FAQ</a></li>
        </ul>
    </section>

    <section class="subscribe">
        <h2>Subscribe for Latest Updates</h2>
        <form action="/subscribe">
            <input type="email" name="email" placeholder="Enter your email" required />
            <button type="submit">Subscribe</button>
        </form>
    </section>
</main>
</body>

</html>
