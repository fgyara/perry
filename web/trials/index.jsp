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

      <div>  
        <jsp:include page="/WEB-INF/jspf/furniture/title-bar.jsp" />

        <jsp:include page="/WEB-INF/jspf/furniture/jumbotron.jsp" />

        <div class="container">
            <div class="row">

                <%--<jsp:include page="/WEB-INF/jspf/furniture/left-nav.jsp" />--%>

                <button id="foo">Yo3</button>

            </div> <!-- /row -->

            <hr>

            <jsp:include page="/WEB-INF/jspf/furniture/footer.jsp" />
        </div> <!-- /container -->
      </div>
  </body>
</html>
