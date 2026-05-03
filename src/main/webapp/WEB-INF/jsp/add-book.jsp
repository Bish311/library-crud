<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Add Book</title>
    <link rel="stylesheet" href="/css/style.css">
</head>
<body>
    <div class="nav">
        <a href="/books">Books</a>
        <a href="/authors">Authors</a>
    </div>
    <div class="container">
        <h2>Add Book</h2>
        <form action="/books/add" method="POST">
            <label>Title:</label>
            <input type="text" name="title" required>
            
            <label>Genre:</label>
            <input type="text" name="genre" required>
            
            <label>Price:</label>
            <input type="number" step="0.01" name="price" required>
            
            <label>Author:</label>
            <select name="author.id" required>
                <c:forEach var="author" items="${authors}">
                    <option value="${author.id}">${author.name}</option>
                </c:forEach>
            </select>
            
            <button type="submit">Save</button>
        </form>
    </div>
</body>
</html>
