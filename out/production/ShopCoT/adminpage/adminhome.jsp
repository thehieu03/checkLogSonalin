<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Quản Lý YOUR BUDDY</title>
        <link rel="stylesheet" href="../css/home.css">
        <link rel="stylesheet" href="../adminpage/admincss/home.css">
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@100..900&family=Nunito:wght@200..1000&family=Roboto:wght@100;300;400;500;700;900&display=swap" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" integrity="sha512-9usAa10IRO0HhonpyAIVpjrylPvoDwiPUiKdWk5t3PyolY1cOd4DSE0Ga+ri4AuTroPR5aQvXU9xC6qOPnzFeg==" crossorigin="anonymous" referrerpolicy="no-referrer" />
        <style>
            body{
                font-family: 'Nunito';
            }
            .card-link {
                text-decoration: none; 
                color: inherit;     
                display: block;    
            }

            .card-link:hover {
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
            }

            .card-link .bi {
                color: var(--primary-color);
            }
            .card-body{
                color: var(--primary-color);
            }
        </style>
    </head>
    <body>
        <header style="margin: 0;">
            <div class="container">
                <div class="header-top">
                    <div class="logo">
                        <a href="${pageContext.request.contextPath}/adminpage/adminhome.jsp"><img src="../css/images/2.png" alt="Logo Website"></a>
                    </div>
                    <nav style="margin: 0;" class="top-nav right-nav">
                        <ul style="margin: 0">
                            <li><a href="${pageContext.request.contextPath}/LoadDataProduct">Sản Phẩm</a></li>
                            <li><a href="${pageContext.request.contextPath}/LoadDataUser">Người Dùng</a></li>
                            <li><a href="${pageContext.request.contextPath}/adminorders">Đơn Hàng</a></li>
                            <li><a href="${pageContext.request.contextPath}/signout">Đăng xuất</a></li>
                        </ul>
                    </nav>
                </div>
            </div>
        </header>

        <section style="height: 300px; margin: 30px auto;" id="services" class="py-5 bg-light">
            <div style="width: 100%; margin: 0 auto;" style="padding-top: 50px;" class="container">
                <div class="row g-10">
                    <div class="col-md-4">
                        <a href="${pageContext.request.contextPath}/LoadDataProduct" class="card-link">
                            <div class="card h-100">
                                <div class="card-body text-center">
                                    <i class="bi bi-box fs-1"></i> 
                                    <h3 class="card-title">QUẢN LÝ SẢN PHẨM</h3>
                                </div>
                            </div>
                        </a>
                    </div>
                    <div class="col-md-4">
                        <a href="${pageContext.request.contextPath}/LoadDataUser" class="card-link"> 
                            <div class="card h-100">
                                <div class="card-body text-center">
                                    <i class="bi bi-file-earmark-person-fill fs-1"></i> 
                                    <h3 class="card-title">QUẢN LÝ NGƯỜI DÙNG</h3>
                                </div>
                            </div>
                        </a>
                    </div>
                    <div class="col-md-4">
                        <a href="${pageContext.request.contextPath}/adminorders" class="card-link"> 
                            <div class="card h-100">
                                <div class="card-body text-center">
                                    <i class="bi bi-archive-fill fs-1"></i> 
                                    <h3 class="card-title">QUẢN LÝ ĐƠN HÀNG</h3>
                                </div>
                            </div>
                        </a>
                    </div>
                </div>
            </div>
        </section>
        <jsp:include page="../footer.jsp" />
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
