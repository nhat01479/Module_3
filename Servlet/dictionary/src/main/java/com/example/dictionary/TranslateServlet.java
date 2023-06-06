package com.example.dictionary;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Map;

@WebServlet(name = "TranslateServlet", value = "/translate")
public class TranslateServlet extends HttpServlet {
    private Map<String, String> dictionary;

    public TranslateServlet() {
        dictionary = new HashMap<>();
        dictionary.put("hello", "Xin chào");
        dictionary.put("how", "Thế nào");
        dictionary.put("book", "Quyển vở");
        dictionary.put("computer", "Máy tính");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        /** Cách 1:
         response.setContentType("text/html");

         PrintWriter out = response.getWriter();
         out.println("<!DOCTYPE html>\n" +
         "<html lang=\"en\">\n" +
         "<head>\n" +
         "    <meta charset=\"UTF-8\">\n" +
         "    <meta http-equiv=\"X-UA-Compatible\" content=\"IE=edge\">\n" +
         "    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">\n" +
         "    <title>Document</title>\n" +
         "</head>\n" +
         "<body>\n" +
         "    <form action=\"/translate\" method=\"post\">\n" +
         "        <input type=\"text\" name=\"txtSearch\" >\n" +
         "        <input type=\"submit\" value=\"Translate\" />\n" +
         "    </form>\n" +
         "</body>\n" +
         "</html>");
         **/
        /* Cách 2: */

        RequestDispatcher requestDispatcher = request.getRequestDispatcher("/translate.jsp");
        requestDispatcher.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        /**
         String search = request.getParameter("txtSearch");
         String value = dictionary.get(search.toLowerCase());;
         if (value == null) {
         value = "Khong tim thay";
         }

         String valueHtml = String.format("<!DOCTYPE html>\n" +
         "<html lang=\"en\">\n" +
         "<head>\n" +
         "    <meta charset=\"UTF-8\">\n" +
         "    <meta http-equiv=\"X-UA-Compatible\" content=\"IE=edge\">\n" +
         "    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">\n" +
         "    <title>Document</title>\n" +
         "</head>\n" +
         "<body>\n" +
         "    <form action=\"/translate\" method=\"post\">\n" +
         "        <input type=\"text\" name=\"txtSearch\" >\n" +
         "        <input type=\"submit\" value=\"Translate\" />\n" +
         "    </form>\n" +
         "    <h6>Meaning: %s</h6>\n" +
         "</body>\n" +
         "</html>", value);

         PrintWriter out = response.getWriter();
         out.println(valueHtml);
         **/

        String search = request.getParameter("txtSearch");
        String value = dictionary.get(search.toLowerCase());
        if (value == null) {
            value = "Không tìm thấy";
        }

        request.setAttribute("value", value);


        RequestDispatcher requestDispatcher = request.getRequestDispatcher("/translate.jsp");
        requestDispatcher.forward(request, response);

    }
}
