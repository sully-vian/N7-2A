<!DOCTYPE html>
<html>

<body>
    <form action="Serv" method="GET">
        nb1: <input type="text" name="nb1"> <br>
        nb2: <input type="text" name="nb2"> <br>
        <input type="submit" value="compute">
    </form>
    <% if (request.getAttribute("result") !=null) { %>
        <p>La somme de ${param.nb1} et ${param.nb2} est ${result}.</p>
    <% } %>
</body>

</html>