<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html" %>
<%@ taglib uri="/WEB-INF/struts-tiles.tld" prefix="tiles" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<!-- submissionExternalLinksDisplayer.jsp -->

<style type="text/css">
.title-alt-el {
  background-color: #F7F8E0;
}
.odd-alt-el {
  background-color: #EFFBF2;
}
.even-alt-el {
  background-color: #CEF6D8;
}
</style>

<script type="text/javascript" charset="utf-8">
    jQuery(document).ready(function () {
        jQuery("#ext").click(function () {
           if(jQuery("#submission-external-links").is(":hidden")) {
             jQuery("#co").attr("src", "images/disclosed.gif");
           } else {
             jQuery("#co").attr("src", "images/undisclosed.gif");
           }
           jQuery("#submission-external-links").toggle("slow");
        });
    })
</script>

<html:link linkName="#" styleId="ext" style="cursor:pointer">
    <h3>
        Data Files for this submission (click to toggle)
        <img src="images/undisclosed.gif" id="co">
    </h3>
</html:link>

<div id="submission-external-links" style="display: block">
	<table width="100%" cellpadding="0" cellspacing="0" border="0" class="results">
		<tr>
        	<th>Name</th>
        	<th>Type</th>
        	<th>URL</th>
		</tr>
		<tbody>
			<c:if test="${not empty persistentDataFiles}">
				<tr class="title-alt-el">
					<td>
						Persistent Data Files
					</td>
					<td></td>
					<td></td>
				</tr>
				
				<c:forEach var="persistentDataFile" items="${persistentDataFiles}" varStatus="persistent_data_file_status">
					<c:set var="pRowClass">
	                	<c:choose>
	                    	<c:when test="${persistent_data_file_status.count % 2 == 1}">
	                        	odd-alt-el
	                    	</c:when>
	                    	<c:otherwise>
	                        	even-alt-el
	                    	</c:otherwise>
	                	</c:choose>
	            	</c:set>
	            	
					<tr class="<c:out value="${pRowClass}"/>">
						<td valign="top" style="width:30%;">
							${persistentDataFile.name}
						</td>
						<td valign="top" style="width:20%;">
							${persistentDataFile.type}
						</td>
						<td valign="top" style="width:50%;">
							<a href="${persistentDataFile.url}">${persistentDataFile.url}</a> 
						</td>
					</tr>
				</c:forEach>
			</c:if>
			
			<c:if test="${not empty submissionDataFiles}">
				<tr class="title-alt-el">
					<td>
						Submission Data Files
					</td>
					<td></td>
					<td></td>
				</tr>
				
				<c:forEach var="submissionDataFile" items="${submissionDataFiles}" varStatus="submission_data_file_status">
					<c:set var="pRowClass">
	                	<c:choose>
	                    	<c:when test="${submission_data_file_status.count % 2 == 1}">
	                        	odd-alt-el
	                    	</c:when>
	                    	<c:otherwise>
	                        	even-alt-el
	                    	</c:otherwise>
	                	</c:choose>
	            	</c:set>
	            	
					<tr class="<c:out value="${pRowClass}"/>">
						<td valign="top" style="width:30%;">
							${submissionDataFile.name}
						</td>
						<td valign="top" style="width:20%;">
							${submissionDataFile.type}
						</td>
						<td valign="top" style="width:50%;">
							<a href="${submissionDataFile.url}">${submissionDataFile.url}</a> 
						</td>
					</tr>
				</c:forEach>
			</c:if>

		</tbody>
	</table>
</div>

<!-- submissionExternalLinksDisplayer.jsp -->
