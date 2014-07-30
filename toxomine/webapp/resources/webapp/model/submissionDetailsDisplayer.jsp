<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://jakarta.apache.org/taglibs/string-1.1" prefix="str" %>

<!-- submissionDetailsDisplayer.jsp -->

<html:xhtml />

<c:choose>
	<c:when test="${not empty technique}">
		<h2 style="font-weight: normal;">Technique: <strong>${technique}</strong></h2>
	</c:when>
	<c:otherwise>
    	<h2 style="font-weight: normal;">Technique: <i>not available</i></h2>
  	</c:otherwise>
</c:choose>

<table id="submissionDetails">
<tr>
	<td valign="top">
	    <table id="left-table" style="margin-right: 25%;">
	        <tr>
	            <td>TCid:</td>
	            <td><strong>${TCid}<strong></td>
	        </tr>
	    	<tr>
	    		<td style="padding-right: 130px;">Design:</td>
	            <td><strong>${design}<strong></td>
	        </tr>
	        <c:if test="${not empty qualityControl}">
		        <tr>
		        	<td>Quality Control:</td>
		            <td><strong>${qualityControl}<strong></td>
		        </tr>
	        </c:if>
	        <c:if test="${not empty replicate}">
		        <tr>
		        	<td>Replicate:</td>
		            <td><strong>${replicate}<strong></td>
		        </tr>
	        </c:if>
	        <c:if test="${not empty publicReleaseDate}">
		        <tr>
		            <td>Public Release Date:</td>
		            <td><strong>${publicReleaseDate}<strong></td>
		        </tr>
	        </c:if>
	        <c:if test="${not empty embargoDate}">
	       		<tr>
	            	<td>Embargo Date:</td>
	                <td><span style="border: 2px solid red; white-space: nowrap;"><strong>${embargoDate}<strong></span></td>
	            </tr>
	        </c:if>
	        <c:if test="${empty embargoDate}">
	        <tr>
	            <td>Embargo Date:</td>
	            <td><span style="border: 2px solid green; white-space: nowrap;">This dataset is no longer embargoed</span></td>
	        </tr>
	        </c:if>
	    </table>
    </td>
    <td valign="top">
    	<table id="right-table">
    		<tr>
    			<td style="padding-right: 130px;">Labs:</td>
    			<td>
    			<c:choose>
    				<c:when test="${not empty labs}">
    					<c:forEach var="lab" items="${labs}" varStatus="lab_status">
    						<a href="/${WEB_PROPERTIES['webapp.path']}/report.do?id=${lab.id}" style="text-decoration: none;"><strong>${lab.name}</strong></a></br>
    					</c:forEach>
    				</c:when>
    				<c:otherwise>
    					<i>not available</i>
    				</c:otherwise>
    			</c:choose>
    			</td>
            </tr>
    		<tr>
    			<td style="padding-right: 130px;">Projects:</td>
    			<td>
    			<c:choose>
    				<c:when test="${not empty projects}">
    					<c:forEach var="project" items="${projects}" varStatus="project_status">
    						<a href="/${WEB_PROPERTIES['webapp.path']}/report.do?id=${project.id}" style="text-decoration: none;"><strong>${project.name}</strong></a></br>
    					</c:forEach>
    				</c:when>
    				<c:otherwise>
    					<i>not available</i>
    				</c:otherwise>
    			</c:choose>
    			</td>
            </tr>
    		<tr>
    			<td style="padding-right: 130px;">Experiments:</td>
    			<td>
    			<c:choose>
    				<c:when test="${not empty experiments}">
    					<c:forEach var="experiment" items="${experiments}" varStatus="experiment_status">
    						<a href="/${WEB_PROPERTIES['webapp.path']}/report.do?id=${experiment.id}" style="text-decoration: none;"><strong>${experiment.name}</strong></a></br>
    					</c:forEach>
    				</c:when>
    				<c:otherwise>
    					<i>not available</i>
    				</c:otherwise>
    			</c:choose>
    			</td>
            </tr>
            <tr>
                <td valign="top">Description:</td>
                <td id="submissionDescriptionContent" align="justify"><strong>${description}<strong></td>
            </tr>
		</table>
	</td>
</tr>
</table>

<script type="text/javascript" src="model/jquery_expander/jquery.expander.js"></script>
<script type="text/javascript">
    jQuery('#submissionDescriptionContent').expander({
        slicePoint: 300
      });
</script>

<!-- /submissionDetailsDisplayer.jsp -->
