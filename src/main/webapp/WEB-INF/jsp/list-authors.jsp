<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Authors List</title>
    <link rel="stylesheet" href="/css/style.css">
</head>
<body>
    <div class="nav">
        <a href="/books">Books</a>
        <a href="/authors">Authors</a>
    </div>
    <div class="container">
        <h2>Authors List</h2>
        <a href="/authors/add" class="btn">Add Author</a>
        <table>
            <tr>
                <th>Name</th>
                <th>Nationality</th>
                <th>Action</th>
            </tr>
            <c:forEach var="author" items="${authors}">
                <tr>
                    <td>${author.name}</td>
                    <td>${author.nationality}</td>
                    <td><a href="/authors/edit/${author.id}">Edit</a></td>
                </tr>
            </c:forEach>
        </table>
    </div>
</body>
</html>
