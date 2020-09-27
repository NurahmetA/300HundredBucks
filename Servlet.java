import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.lang.reflect.Array;

@WebServlet(name = "servlets.Servlet")
public class Servlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String itemName = request.getParameter("item");
        String price = request.getParameter("item_price");
        String comments = request.getParameter("comments");
        request.setAttribute("item",itemName);
        request.getRequestDispatcher("confirmation.jsp").forward(request,response);
    }
    private Products addProduct(HttpServletResponse response, HttpServletRequest request) {
        Products product = new Products();

    }
    //Send us to Form page
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String itemArray[] = {"chess", "chair", "mouse"};
        request.setAttribute("itemArray", itemArray);
        request.getRequestDispatcher("form.jsp").forward(request,response);
    }
}
