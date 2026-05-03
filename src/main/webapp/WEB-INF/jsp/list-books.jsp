<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Books List</title>
    <link rel="stylesheet" href="/css/style.css">
</head>
<body>
    <div class="nav">
        <a href="/books">Books</a>
        <a href="/authors">Authors</a>
    </div>
    <div class="container">
        <h2>Books List</h2>
        <a href="/books/add" class="btn">Add Book</a>
        <table>
            <tr>
                <th>Title</th>
                <th>Genre</th>
                <th>Price</th>
                <th>Author</th>
                <th>Action</th>
            </tr>
            <c:forEach var="book" items="${books}">
                <tr>
                    <td>${book.title}</td>
                    <td>${book.genre}</td>
                    <td>${book.price}</td>
                    <td>${book.author.name}</td>
                    <td><a href="/books/edit/${book.id}">Edit</a></td>
                </tr>
            </c:forEach>
        </table>
    </div>
</body>
</html>
