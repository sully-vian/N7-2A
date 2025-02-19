<%@ page import="pack.Personne" %>
<%@ page import="pack.Adresse" %>
<%@ page import="java.util.List" %>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Lister</title>
</head>

<body>
    <% List<Personne> listePersonnes = (List<Personne>) request.getAttribute("listePersonnes"); %>
    <% if (listePersonnes == null) { %>
        <h1>L'annuaire est vide</h1>
    <% } else { %>
        <ul>
        <% for (Personne personne : listePersonnes) { %>
            <li><%= personne.getNom() %> <%= personne.getPrenom() %></li>
            <ul>
            <% for (Adresse adresse : personne.getAdresses()){ %>
                <li><%= adresse.getRue() %> <%= adresse.getVille() %></li>
            <% } %>
            </ul>
        <% } %>
        </ul>
    <% } %>
</body>

</html>