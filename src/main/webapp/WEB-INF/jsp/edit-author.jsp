<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Edit Author</title>
    <link rel="stylesheet" href="/css/style.css">
</head>
<body>
    <div class="nav">
        <a href="/books">Books</a>
        <a href="/authors">Authors</a>
    </div>
    <div class="container">
        <h2>Edit Author</h2>
        <form action="/authors/edit/${author.id}" method="POST">
            <label>Name:</label>
            <input type="text" name="name" value="${author.name}" required>
            
            <label>Nationality:</label>
            <input type="text" name="nationality" value="${author.nationality}" required>
            
            <button type="submit">Update</button>
        </form>
    </div>
</body>
</html>
