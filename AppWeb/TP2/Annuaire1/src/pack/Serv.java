package pack;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Collection;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/Serv")
public class Serv extends HttpServlet {

    private Facade facade = new Facade();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        PrintWriter out = response.getWriter();
        String op = request.getParameter("op");
        // out.println("op = " + op);
        Collection<Personne> listePersonnes = this.facade.listePersonnes();
        Collection<Adresse> listeAdresses = this.facade.listeAdresses();

        switch (op) {
            case "associer": // Renvoyer vers la page d'association
                request.setAttribute("listePersonnes", listePersonnes);
                request.setAttribute("listeAdresses", listeAdresses);
                request.getRequestDispatcher("associer.jsp").forward(request, response);
                break;
            case "lister":
                request.setAttribute("listePersonnes", listePersonnes);
                request.getRequestDispatcher("lister.jsp").forward(request, response);
                break;
            default:
                out.println("Opération \"" + op + "\" non reconnue pour la méthode GET");
        }

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        PrintWriter out = response.getWriter();
        String op = request.getParameter("op");
        // out.println("op = " + op);

        switch (op) {
            case "ajoutpersonne":
                String nom = request.getParameter("nom");
                String prenom = request.getParameter("prenom");
                this.facade.ajoutPersonne(nom, prenom);
                request.getRequestDispatcher("index.html").forward(request, response);
                break;
            case "ajoutadresse":
                String rue = request.getParameter("rue");
                String ville = request.getParameter("ville");
                this.facade.ajoutAdresse(rue, ville);
                request.getRequestDispatcher("index.html").forward(request, response);
                break;
            case "associer": // Associer une adresse à une personne
                int personneId = Integer.parseInt(request.getParameter("personneId"));
                int adresseId = Integer.parseInt(request.getParameter("adresseId"));
                this.facade.associer(personneId, adresseId);
                request.getRequestDispatcher("index.html").forward(request, response);
                break;
            default:
                out.println("Opération \"" + op + "\" non reconnue pour la méthode POST");
        }
    }
}