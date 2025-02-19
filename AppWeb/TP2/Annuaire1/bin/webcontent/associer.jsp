<%@ page import="pack.Personne" %>
<%@ page import="pack.Adresse" %>
<%@ page import="java.util.List" %>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Associer</title>
</head>

<body>
    <% List<Personne> listePersonnes = (List<Personne>) request.getAttribute("listePersonnes"); %>
    <% List<Adresse> listeAdresses = (List<Adresse>) request.getAttribute("listeAdresses"); %>
    <% if ((listePersonnes == null) && (listeAdresses == null)) { %>
        <h1>L'annuaire est vide</h1>
    <% } else { %>
        <form action="Serv" method="post">
            <input type="hidden" name="op" value="associer">
            <p>Choisir la personne:</p>
            <% for (Personne personne : listePersonnes) { %>
                <label>
                    <input type="radio" name="personneId" value="<%= personne.getId() %>" required>
                    <%= personne.getNom() %> <%= personne.getPrenom() %>
                </label> <br>
            <% } %>
            <p>Choisir l'adresse:</p>
            <% for (Adresse adresse : listeAdresses) { %>
                <label>
                    <input type="radio" name="adresseId" value="<%= adresse.getId() %>" required>
                    <%= adresse.getRue() %> <%= adresse.getVille() %>
                </label> <br>
            <% } %>
            <input type="submit" value="OK">
        </form>
    <% } %>
</body>

</html>