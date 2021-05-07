$(document).ready(function() {

    $( "a" ).click(function( event ) {
        event.preventDefault();
    });

    var numOfOrders = 0;
    $(".num").text(numOfOrders);

    // hide dialogs on start
    $("#thanksMessage, #checkOrder, #finishOrderDialog").hide();

    // open dialog on click
    $("#addToCart").on("click", function () {
        $("#checkOrder").dialog({
            hide: "blind",
            show : "blind",
            width: "400px",
            closeText: "X"});
    })

    // increase/decrease the price of order if size is added/removed
    function checkboxChange(x) {
        var priceDialog = 0;
        $("#size"+x).children("li").children("input").each(function () {
            if($(this).is(":checked")){
                priceDialog+=200;
            }
            $("#totalDialog"+x+">span").text(priceDialog);
            $(this).change(function () {
                if ($(this).is(":checked")) {
                    priceDialog += 200;
                    console.log(priceDialog);
                    $("#totalDialog"+x+">span").text(priceDialog);
                }else{
                    priceDialog -= 200;
                    $("#totalDialog"+x+">span").text(priceDialog);
                }
            })
        });
    }

    $('#size1').children('li').click(checkboxChange(1));


    $(".listOver").on("click", function () {
        var orderName = '<h3 class="orderName"><span>' + $(this).parent().siblings(".ui-dialog-titlebar").children("span").text() + '</span><a class="delBtn"><i class="fas fa-backspace"></i></a>' +'</h3>';
        var orderSizes = '<ul class="orderIngredients"></ul>';
        var orderPrice = '<h3 class="orderPrice"><span>' + $(this).parent().children(".totalDialog").children("span").text() + '</span>/=<h3>'
        var horizontalLine = '<hr>';
        $(".cart").children("#listOfOrders").append("<li>" + orderName + orderSizes + orderPrice + horizontalLine + "</li>");

        $(this).parent().children("ul").children().children("input:checked").each(function () {
            var selectedIngredient = $(this).parent().text();
            $(".orderIngredients").last().append("<li>" + selectedIngredient + "</li>");
        })

        // opens the cart side menu
        if ($('#cartToggle').prop('checked')) {
            $("#cartToggle").prop("checked", true);
        }else{
            $("#cartToggle").prop("checked", true);
        }

        $(this).parent(".ui-dialog-content").dialog("close");

        numOfOrders = $("#listOfOrders").children().length;
        $(".num").text(numOfOrders);

        // display total price in cart
        var totalOrderPrice = 0;
        $("#listOfOrders").children("li").children(".orderPrice").children("span").each(function () {
            var price = parseFloat($(this).text());
            totalOrderPrice += price;
            $(".cart > h3 > span").text(totalOrderPrice);
        });

        // remove order from cart
        $(".delBtn").on("click", function () {
            var removePrice = $(this).parent().parent().children(".orderPrice").children("span").text();
            totalOrderPrice -= removePrice;
            $(".cart > h3 > span").text(totalOrderPrice);

            $(this).parents("li").remove();
            numOfOrders = $("#listOfOrders").children().length;
            $(".num").text(numOfOrders);
        })
    });

    $(".checkout").on("click", function () {
        $("#finalOrderList > ol").children().remove();
        $(".orderName").children("span").each(function(){
            var finalOrder = '<li>' + $(this).text() + '</li>';
            $("#finalOrderList > ol").append(finalOrder);
        })

        $("#finishOrderDialog").dialog({
            hide: "blind",
            show : "blind",
            width: "500px",
            closeText: "X"
        });
    })

    $(".order").on("click", function () {
        var name = $("#buyerName").val();
        var email = $("#buyerEmail").val();
        var number = $("#buyerNumber").val();
        var address = $("#buyerAddress").val();
        var city = $("#city").val();

        if (name != "" && email != "" && number != null && address != "" && city != "") {
            $("#finishOrderDialog").dialog("close");
            $("#buyerInfo").children("p").remove();
            $("#thanksMessage").dialog({
                hide: "blind",
                show : "blind",
                width: "400px"
            });
            setTimeout(function(){
                $("#thanksMessage").dialog("close");
            }, 3000);
        }else{
            $("#buyerInfo").append('<h6>Fill in all the details</h6>');
        }
    })

})
