package pack;

import java.io.IOException;
import java.io.PrintWriter;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/Calc")
public class Serv extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String s1 = request.getParameter("nb1");
        int nb1 = Integer.parseInt(s1);
        String s2 = request.getParameter("nb2");
        int nb2 = Integer.parseInt(s2);
        int res = nb1 + nb2;
        PrintWriter out = response.getWriter();
        String stringRes = String.format("La somme de %d et %d est %d", nb1, nb2, res);
        out.println(stringRes);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }
}