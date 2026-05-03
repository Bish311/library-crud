<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Error</title>
    <link rel="stylesheet" href="/css/style.css">
</head>
<body>
    <div class="nav">
        <a href="/books">Books</a>
        <a href="/authors">Authors</a>
    </div>
    <div class="container">
        <div class="error-banner">
            <h2>Error occurred</h2>
            <p>${errorMessage}</p>
        </div>
        <a href="/" class="btn">Go Back</a>
    </div>
</body>
</html>
