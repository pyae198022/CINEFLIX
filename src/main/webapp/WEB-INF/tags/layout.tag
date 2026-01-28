<%@ tag language="java" pageEncoding="UTF-8"%>
<%-- Add this line below to define the 'title' attribute --%>
<%@ attribute name="title" required="false" rtexprvalue="true" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>${not empty title ? title : 'Default Title'}</title>
</head>
<body>
    <jsp:doBody />
</body>
</html>