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
            
            <div id="1" class="well col-md-9" data-perry-template="template.jsp" data-perry-data="1.json">
                Some day, someone will populate me!
            </div>
            
            <div id="2"  class="well col-md-9" data-perry-template="template.jsp" data-perry-data="1.json">
                Some day, someone will populate me!
            </div>

            <div id="3"  class="well col-md-9" data-perry-template="template.jsp" data-perry-data="1.json">
                Some day, someone will populate me!
            </div>
            
            <div id="4"  class="well col-md-9" data-perry-template="template.jsp" data-perry-data="1.json">
                Some day, someone will populate me!
            </div>
            <div id="5"  class="well col-md-9" data-perry-template="template.jsp" data-perry-data="1.json">
                Some day, someone will populate me!
            </div>
            <div id="6"  class="well col-md-9" data-perry-template="template.jsp" data-perry-data="1.json">
                Some day, someone will populate me!
            </div>
            <div id="7"  class="well col-md-9" data-perry-template="template.jsp" data-perry-data="1.json">
                Some day, someone will populate me!
            </div>
            <div id="8"  class="well col-md-9" data-perry-template="template.jsp" data-perry-data="1.json">
                Some day, someone will populate me!
            </div>
            <div id="9"  class="well col-md-9" data-perry-template="template.jsp" data-perry-data="1.json">
                Some day, someone will populate me!
            </div>
            <div id="10"  class="well col-md-9" data-perry-template="template.jsp" data-perry-data="1.json">
                Some day, someone will populate me!
            </div>
            <div id="11"  class="well col-md-9" data-perry-template="template.jsp" data-perry-data="1.json">
                Some day, someone will populate me!
            </div>
            <div id="12"  class="well col-md-9" data-perry-template="template.jsp" data-perry-data="1.json">
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


    var renderFn3 = function(holder, populate, data) {
        if (populate === "template") {
            holder.templateValue = data;
        }
        
        if (populate === "data") {
            holder.dataValue = data;
        }
        
        console.log( "Done " + holder.div.attr("id") + " - " + populate );
        console.log( "\t" + holder.templateValue);
        console.log( "\t" + holder.dataValue);
        
        if ((holder.templateValue !== undefined) & (holder.dataValue !== undefined)) {
            holder.div.append(holder.templateValue);
            holder.div.append(holder.dataValue);
        }
    };

    function renderAjax( holder) {
        
        var boundTemplateFn = renderFn3.bind(this, holder, "template");
        $.ajax({
                url: holder.templateUrl,
                type: 'get',
                async: true,
                cache: false
            }).done( boundTemplateFn);
            
        var boundDataFn = renderFn3.bind(this, holder, "data");
        $.ajax({
                url: holder.dataUrl,
                type: 'get',
                async: true,
                cache: false
            }).done( boundDataFn);
            
    }    


    

    // loop through divs that are ajax and ensure that they are dynamically loaded
    $(document).ready(function(){
        $('div[data-perry-template]').each( function(index) {

            var holder = { templateUrl: "", dataUrl: "", div: $(this), templateValue: "", dataValue: "" };
            
            // get the template
            holder.templateUrl = $(this).attr("data-perry-template");
            holder.dataUrl = $(this).attr("data-perry-data");
            console.log( "Template: " + holder.templateUrl + " data:" + holder.dataUrl);
        
            renderAjax( holder);
        });

    });
    </script>
  </body>
</html>
