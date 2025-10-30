-- Gear máy tính (cateID = 1)
INSERT INTO Product (productName, price, description, cateID, itemID, imageURL, discount, stock)
VALUES
(N'Bàn phím cơ AKKO 3068B', 1450000, N'Bàn phím cơ không dây 68 phím, switch Gateron, kết nối Bluetooth/USB Type-C.', 1, 4, 'https://cdn2.cellphones.com.vn/x/media/catalog/product/b/a/ban-phim-co-akko-3068b-black-gold-3.png', 10, 120),

(N'Chuột Logitech G304 Wireless', 890000, N'Chuột gaming không dây, cảm biến HERO 12K DPI, pin kéo dài đến 250 giờ.', 1,4, 'https://nvs.tn-cdn.net/2020/03/Chu%E1%BB%99t-Logitech-G304-Wireless-%E2%80%93-%C4%90en-2.jpg', 5, 200),

(N'Tai nghe HyperX Cloud II', 1850000, N'Tai nghe chụp tai gaming, âm thanh 7.1 Surround, mic tháo rời.', 1,4, 'https://next-media.elkjop.com/image/dv_web_D1800010021820505/763435/hyperx-cloud-ii-core-gamingheadset-sort.jpg?w=1200&q=75', 0, 75),

(N'Màn hình LG Ultragear 24GN600', 3900000, N'Màn hình 24 inch Full HD 144Hz, tấm nền IPS, hỗ trợ FreeSync/G-Sync.', 1,4, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR39vDHNGJ7cnG9kN3Ynia4F7CLNMUoj3nK_g&s', 0, 35),

(N'Bàn di chuột Razer Goliathus', 290000, N'Bề mặt vải mềm, kích thước Medium, phù hợp cho game thủ.', 1,4, 'https://hanoicomputercdn.com/media/product/77327_ban_di_chuot_razer_goliathus_xanh_den_25cm_x_30cm_day_4mm.jpg', 0, 150);

-- Quần áo thời trang người dùng (cateID = 5)
INSERT INTO Product (productName, price, description, cateID,ItemID, imageURL, discount, stock)
VALUES
(N'Áo sơ mi trắng nam tay dài', 320000, N'Chất liệu cotton mềm mịn, kiểu dáng lịch sự, phù hợp công sở hoặc dạo phố.', 5,5, 'https://dongphucbaoan.vn/wp-content/uploads/2021/07/ao-so-mi-nam-cong-so-tay-dai-mau-02.jpg', 15, 90),

(N'Váy hoa dáng dài nữ vintage', 450000, N'Váy hoa nhí phong cách Hàn Quốc, dáng suông, tay lỡ, phù hợp đi chơi, cafe.', 5,5, 'https://dongphuchaianh.vn/wp-content/uploads/2022/09/vay-hoa-nhi-dang-dai-mix-giay-bup-be.jpg', 5, 120),

(N'Quần jean nam rách gối', 370000, N'Quần jean co giãn nhẹ, rách thời trang, form slim-fit.', 5,5, 'https://st.app1h.com/uploads/images/company72/images/cach-chon-quan-jean-nam-rach-goi.jpg', 0, 80),

(N'Áo thun nữ form rộng in chữ', 210000, N'Áo thun chất cotton 100%, form oversize, in hình năng động.', 5,5, 'https://cocolu.vn/wp-content/uploads/2024/01/ao-thun-nu-form-rong-in-chu-than-ao-1.jpg', 10, 150),

(N'Áo khoác bomber unisex', 580000, N'Áo khoác bomber vải dù, phong cách streetwear, cả nam lẫn nữ đều mặc được.', 5,5, 'https://down-vn.img.susercontent.com/file/vn-11134207-7qukw-lh4knyjm8ldec4', 0, 65);

Delete from Product

SELECT * FROM Product WHERE productID = 2
