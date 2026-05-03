<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Edit Book</title>
    <link rel="stylesheet" href="/css/style.css">
</head>
<body>
    <div class="nav">
        <a href="/books">Books</a>
        <a href="/authors">Authors</a>
    </div>
    <div class="container">
        <h2>Edit Book</h2>
        <form action="/books/edit/${book.id}" method="POST">
            <label>Title:</label>
            <input type="text" name="title" value="${book.title}" required>
            
            <label>Genre:</label>
            <input type="text" name="genre" value="${book.genre}" required>
            
            <label>Price:</label>
            <input type="number" step="0.01" name="price" value="${book.price}" required>
            
            <label>Author:</label>
            <select name="author.id" required>
                <c:forEach var="author" items="${authors}">
                    <option value="${author.id}" <c:if test="${author.id == book.author.id}">selected</c:if>>${author.name}</option>
                </c:forEach>
            </select>
            
            <button type="submit">Update</button>
        </form>
    </div>
</body>
</html>
