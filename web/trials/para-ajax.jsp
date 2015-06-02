<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 
<c:set var="context" scope="request" value="${pageContext.request.getContextPath()}" />

<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">
    <link rel="icon" href="../../favicon.ico">

    <title>Register</title>

    <jsp:include page="/WEB-INF/jspf/furniture/bootstrap-include.jsp" />
  </head>

  <body>

    <jsp:include page="/WEB-INF/jspf/furniture/title-bar.jsp" />

    <jsp:include page="/WEB-INF/jspf/furniture/jumbotron.jsp" />

    <div class="container">
        <div class="row">

            <%--<jsp:include page="/WEB-INF/jspf/furniture/left-nav.jsp" />--%>

            <div class="col-md-9">
                <h2>Go on ....</h2>
                <p>Pick something from the menu on the left!</p>
            </div>    
            
            <div class="well col-md-9" data-perry-template="template.jsp" data-perry-data="1.json">
                Some day, someone will populate me!
            </div>
            
            <div class="well col-md-9" data-perry-template="template.jsp" data-perry-data="1.json">
                Some day, someone will populate me!
            </div>

            <div class="well col-md-9" data-perry-template="template.jsp" data-perry-data="1.json">
                Some day, someone will populate me!
            </div>
            
            <div class="well col-md-9" data-perry-template="template.jsp" data-perry-data="1.json">
                Some day, someone will populate me!
            </div>
            <div class="well col-md-9" data-perry-template="template.jsp" data-perry-data="1.json">
                Some day, someone will populate me!
            </div>
            <div class="well col-md-9" data-perry-template="template.jsp" data-perry-data="1.json">
                Some day, someone will populate me!
            </div>
            <div class="well col-md-9" data-perry-template="template.jsp" data-perry-data="1.json">
                Some day, someone will populate me!
            </div>
            <div class="well col-md-9" data-perry-template="template.jsp" data-perry-data="1.json">
                Some day, someone will populate me!
            </div>
            <div class="well col-md-9" data-perry-template="template.jsp" data-perry-data="1.json">
                Some day, someone will populate me!
            </div>
            <div class="well col-md-9" data-perry-template="template.jsp" data-perry-data="1.json">
                Some day, someone will populate me!
            </div>
            <div class="well col-md-9" data-perry-template="template.jsp" data-perry-data="1.json">
                Some day, someone will populate me!
            </div>
            <div class="well col-md-9" data-perry-template="template.jsp" data-perry-data="1.json">
                Some day, someone will populate me!
            </div>
            
            
            
        </div> <!-- /row -->

        <hr>

        <jsp:include page="/WEB-INF/jspf/furniture/footer.jsp" />
    </div> <!-- /container -->
    
    
    <script>
//        jQuery.extend({
//            getValues: function(url) {
//                var result = null;
//                $.ajax({
//                        url: url,
//                        type: 'get',
//                        async: false,
//                        cache: false,
//                        success: function(data) {
//                            result = data;
//                        }
//                    }
//                );
//               return result;
//            }
//        });



    var renderFn = function(data) {
        console.log("render done: " + data);
    };
    
    var renderFn2 = function(divid, data) {
        console.log("render done: " + data);
        divid.replaceWith(data);
    };

    function renderAjax( url, divid) {
        
        var boundFn = renderFn2.bind(this, divid);
        
        $.ajax({
                url: url,
                type: 'get',
                async: true,
                cache: false,
                headers: { 'Connection': 'Keep-Alive' }
            }).done( boundFn);
    }    

    // loop through divs that are ajax and ensure that they are dynamically loaded
    $(document).ready(function(){
        $('div[data-perry-template]').each( function(index) {

            // get the template
            var templateUrl = $(this).attr("data-perry-template");
            console.log("template: " + templateUrl);
//            var templateSrc = $.getValues(templateUrl);
//            $(this).replaceWith(templateSrc);
            
            renderAjax( templateUrl, $(this));
        });

    });
    </script>
  </body>
</html>
