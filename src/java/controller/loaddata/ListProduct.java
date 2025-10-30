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
import java.util.Comparator;
import java.util.stream.Collectors;
import model.Product;

public class ListProduct extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        ProductDAO productDAO = new ProductDAO();
        List<Product> productList = productDAO.getAllProducts();
        List<Product> filteredProducts = new ArrayList<>(productList);

        HttpSession session = request.getSession();
        String sortBy = request.getParameter("sortBy");
        String[] categoryParams = request.getParameterValues("category");
        String[] itemParams = request.getParameterValues("item");
        String[] priceParams = request.getParameterValues("price");
        String searchName = request.getParameter("searchName");

        System.out.println("--- Bắt đầu xử lý request ---");
        System.out.println("Trang yêu cầu: " + request.getParameter("page"));
        System.out.println("searchName: " + searchName);
        System.out.println("sortBy: " + sortBy);
        System.out.println("categoryParams: " + Arrays.toString(categoryParams));
        System.out.println("itemParams: " + Arrays.toString(itemParams));
        System.out.println("priceParams: " + Arrays.toString(priceParams));

        if (sortBy != null) {
            switch (sortBy) {
                case "priceAsc":
                    filteredProducts.sort(Comparator.comparingDouble(Product::getFinalPrice));
                    break;
                case "priceDesc":
                    filteredProducts.sort(Comparator.comparingDouble(Product::getFinalPrice).reversed());
                    break;
                case "stockAsc":
                    filteredProducts.sort(Comparator.comparingInt(Product::getStock));
                    break;
                case "ratingDesc":
                    filteredProducts.sort(Comparator.comparingDouble(Product::getRating).reversed());
                    break;
            }
        }

        if (categoryParams != null) {
            List<Product> tempProducts = new ArrayList<>(filteredProducts);
            filteredProducts.clear();
            for (Product p : tempProducts) {
                for (String catId : categoryParams) {
                    if (String.valueOf(p.getCateID()).equals(catId.trim())) {
                        filteredProducts.add(p);
                        break;
                    }
                }
            }
        }

        if (itemParams != null) {
            List<Product> tempProducts = new ArrayList<>(filteredProducts);
            filteredProducts.clear();
            for (Product p : tempProducts) {
                for (String itemID : itemParams) {
                    if (String.valueOf(p.getItemID()).equals(itemID.trim())) {
                        filteredProducts.add(p);
                        break;
                    }
                }
            }
        }

        if (priceParams != null) {
            List<Product> tempProducts = new ArrayList<>(filteredProducts);
            filteredProducts.clear();
            for (Product p : tempProducts) {
                double finalPrice = p.getFinalPrice();
                for (String priceRange : priceParams) {
                    String trimmedPriceRange = priceRange.trim();

                    if (trimmedPriceRange.equals("0-100000") && finalPrice >= 0 && finalPrice <= 100000) {
                        filteredProducts.add(p);
                        break;
                    } else if (trimmedPriceRange.equals("100000-200000") && finalPrice > 100000 && finalPrice <= 200000) {
                        filteredProducts.add(p);
                        break;
                    } else if (trimmedPriceRange.equals("200000-500000") && finalPrice > 200000 && finalPrice <= 500000) {
                        filteredProducts.add(p);
                        break;
                    } else if (trimmedPriceRange.equals("500000+") && finalPrice > 500000) {
                        filteredProducts.add(p);
                        break;
                    }
                }
            }
        }

        if (searchName != null && !searchName.trim().isEmpty()) {
            List<Product> tempProducts = new ArrayList<>(filteredProducts);
            filteredProducts.clear();
            String lowerSearchName = searchName.trim().toLowerCase();
            for (Product p : tempProducts) {
                if (p.getProductName().toLowerCase().contains(lowerSearchName)) {
                    filteredProducts.add(p);
                }
            }
        }

        List<Product> outOfStockProducts = filteredProducts.stream()
                .filter(p -> p.getStock() == 0)
                .collect(Collectors.toList());

        List<Product> inStockProducts = filteredProducts.stream()
                .filter(p -> p.getStock() > 0)
                .collect(Collectors.toList());

        int page, numperpage = 16;
        int size = inStockProducts.size();

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

        List<Product> list = productDAO.getListByPage(inStockProducts, start, end);

        session.setAttribute("page", page);
        session.setAttribute("numpage", numpage);
        session.setAttribute("products", list);
        session.setAttribute("outstockproducts", outOfStockProducts);

        session.setAttribute("searchName", searchName);
        session.setAttribute("sortBy", sortBy);
        session.setAttribute("categoryParams", categoryParams);
        session.setAttribute("itemParams", itemParams);
        session.setAttribute("priceParams", priceParams);

        request.setAttribute("products", list);
        request.getRequestDispatcher("shopproduct.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }
}
