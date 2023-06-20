<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!doctype html>
<html class="no-js" lang="zxx">
<head>
    <meta charset="utf-8">
    <meta http-equiv="x-ua-compatible" content="ie=edge">
    <title>Coron-cart</title>
    <meta name="description" content="">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- Favicon -->
</head>
<body>
<!-- Add your site or application content here -->

<!--pos page start-->
<div class="pos_page">
    <div class="container">
        <!--pos page inner-->
        <div class="pos_page_inner">
            <!--header area -->
            <!--header end -->
            <!--breadcrumbs area start-->
            <div class="breadcrumbs_area">
                <div class="row">
                    <div class="col-12">
                        <div class="breadcrumb_content">
                            <ul>
                                <li><a href="index.html">home</a></li>
                                <li><i class="fa fa-angle-right"></i></li>
                                <li>Shopping Cart</li>
                            </ul>

                        </div>
                    </div>
                </div>
            </div>
            <!--breadcrumbs area end-->



            <!--shopping cart area start -->
            <div class="shopping_cart_area">
                <form action="#">
                    <div class="row">
                        <div class="col-12">
                            <div class="table_desc">
                                <div class="cart_page table-responsive">
                                    <table>
                                        <thead>
                                        <tr>
                                            <th class="product_remove">Delete</th>
                                            <th class="product_thumb">Image</th>
                                            <th class="product_name">Product</th>
                                            <th class="product-price">Price</th>
                                            <th class="product_quantity">Quantity</th>
                                            <th class="product_total">Total</th>
                                        </tr>
                                        </thead>
                                        <tbody>

                                        <c:forEach items="${orderDTO.getOrderItemDTOs()}" var="odDTO">
                                            <tr>
                                                <td class="product_remove"><a href="#"><i class="fa fa-trash-o"></i></a></td>
                                                <td class="product_thumb"><a href="#"><img src="assets\img\cart\cart17.jpg" alt=""></a></td>
                                                <td class="product_name"><a href="#">${odDTO.getProduct().getName()}</a></td>
                                                <td class="product-price">${odDTO.getProduct().getPrice()}</td>
                                                <td class="product_quantity"><input onchange="handleQuantityChange(${odDTO.getProduct().getId()},${odDTO.getQuantiy()}, this)" min="0" max="100" value="${odDTO.getQuantiy()}" type="number"></td>
                                                <td class="product_total">${odDTO.getProduct().getPrice() * odDTO.getQuantiy()}</td>
                                            </tr>
                                        </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                                <div class="cart_submit">
                                    <button type="submit">update cart</button>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!--coupon code area start-->
                    <div class="coupon_area">
                        <div class="row">
                            <div class="col-lg-6 col-md-6">
                                <div class="coupon_code">
                                    <h3>Coupon</h3>
                                    <div class="coupon_inner">
                                        <p>Enter your coupon code if you have one.</p>
                                        <input placeholder="Coupon code" type="text">
                                        <button type="submit">Apply coupon</button>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-6 col-md-6">
                                <div class="coupon_code">
                                    <h3>Cart Totals</h3>
                                    <div class="coupon_inner">
                                        <div class="cart_subtotal">
                                            <p>Subtotal</p>
                                            <p class="cart_amount">£215.00</p>
                                        </div>
                                        <div class="cart_subtotal ">
                                            <p>Shipping</p>
                                            <p class="cart_amount"><span>Flat Rate:</span> £255.00</p>
                                        </div>
                                        <a href="#">Calculate shipping</a>

                                        <div class="cart_subtotal">
                                            <p>Total</p>
                                            <p class="cart_amount">£215.00</p>
                                        </div>
                                        <div class="checkout_btn">
                                            <a href="#">Proceed to Checkout</a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!--coupon code area end-->
                </form>
            </div>
            <!--shopping cart area end -->

        </div>
        <!--pos page inner end-->
    </div>
</div>
<!--pos page end-->

<!--footer area start-->
<jsp:include page="/WEB-INF/frontend/layout/footer_area.jsp" />
<!--footer area end-->






<!-- all js here -->
<jsp:include page="/WEB-INF/frontend/layout/js_footer.jsp" />

<script>
    function handleQuantityChange(idProduct,quantityOld, element){
        let value = element.value;
        let action  = "";
        if(quantityOld <  value){
            action = 'increase';
        }else{
            action = 'decrease';
        }
        console.log('/cart?action=' + action + '&id=' + idProduct);
        if(action!= ""){
            let url = '/cart?action=' + action + '&id=' + idProduct;
            window.location.assign(url);
        }
    }
</script>
</body>
</html>
