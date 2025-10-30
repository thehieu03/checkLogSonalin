package controller.loaddata;

import dal.ProductDAO;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.Arrays;
import model.Product;

public class LoadDataProduct extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        ProductDAO productDAO = new ProductDAO();
        List<Product> productList = productDAO.getAllProducts();
        List<Product> filteredProducts = new ArrayList<>();

        String searchName = request.getParameter("searchName");
        String category = request.getParameter("category");
        String item = request.getParameter("item");
        String stockRange = request.getParameter("stock");

        System.out.println("--- Bắt đầu xử lý request ---");
        System.out.println("Trang yêu cầu: " + request.getParameter("page"));
        System.out.println("searchName: " + searchName);
        System.out.println("categoryParams: " + category);
        System.out.println("itemParams: " + item);
        System.out.println("st: " + stockRange);

        for (Product product : productList) {
            boolean matchesSearchName = true;
            if (searchName != null && !searchName.isEmpty()) {
                if (!product.getProductName().toLowerCase().contains(searchName.toLowerCase())) {
                    matchesSearchName = false;
                }
            }

            boolean matchesCategory = true;
            if (category != null && !category.isEmpty()) {
                if (product.getCateID() != Integer.parseInt(category.trim())) {
                    matchesCategory = false;
                }
            }

            boolean matchesItem = true;
            if (item != null && !item.isEmpty()) {
                if (product.getItemID() != Integer.parseInt(item.trim())) {
                    matchesItem = false;
                }
            }

            boolean matchesStock = true;
            if (stockRange != null && !stockRange.isEmpty()) {
                int stock = product.getStock();
                switch (stockRange) {
                    case "0-10":
                        if (!(stock >= 0 && stock <= 10)) {
                            matchesStock = false;
                        }
                        break;
                    case "10-50":
                        if (!(stock > 10 && stock <= 50)) {
                            matchesStock = false;
                        }
                        break;
                    case "50-100":
                        if (!(stock > 50 && stock <= 100)) {
                            matchesStock = false;
                        }
                        break;
                    case "100+":
                        if (!(stock >= 100)) {
                            matchesStock = false;
                        }
                        break;
                }
            }

            if (matchesSearchName && matchesCategory && matchesItem && matchesStock) {
                filteredProducts.add(product);
            }
        }

        int page, numperpage = 10;
        int size = filteredProducts.size();
        int numpage = (size % numperpage == 0 ? (size / numperpage) : ((size / numperpage)) + 1);
        String xpage = request.getParameter("page");
        if (xpage == null) {
            page = 1;
        } else {
            page = Integer.parseInt(xpage.trim());
        }

        int start, end;
        start = (page - 1) * numperpage;
        end = Math.min(page * numperpage, size);

        List<Product> listByPage = new ArrayList<>();
        if (start < size) {
            listByPage = filteredProducts.subList(start, end);
        }

        session.setAttribute("page", page);
        session.setAttribute("numpage", numpage);
        session.setAttribute("products", listByPage);

        session.setAttribute("searchName", searchName);
        session.setAttribute("category", category);
        session.setAttribute("item", item);
        session.setAttribute("stock", stockRange);
        response.sendRedirect("adminpage/listproduct.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Load Product Data Servlet";
    }
}
