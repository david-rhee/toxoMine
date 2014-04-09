<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html" %>
<%@ taglib uri="/WEB-INF/struts-tiles.tld" prefix="tiles" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<!-- submissionPropertiesDisplayer.jsp -->

<style type="text/css">
.odd-alt-sp {
  background-color: #FBFBEF;
}
.even-alt-sp {
  background-color: #F5F6CE;
}
</style>

<script type="text/javascript" charset="utf-8">
    jQuery(document).ready(function () {
        jQuery("#pro").click(function () {
           if(jQuery("#submission-properties").is(":hidden")) {
             jQuery("#co").attr("src", "images/disclosed.gif");
           } else {
             jQuery("#co").attr("src", "images/undisclosed.gif");
           }
           jQuery("#submission-properties").toggle("slow");
        });
    })
</script>

<html:link linkName="#" styleId="pro" style="cursor:pointer">
    <h3>
        Submission Properties used for this submission (click to toggle)
        <img src="images/undisclosed.gif" id="co">
    </h3>
</html:link>

<div id="submission-properties" style="display: block">
	<table width="100%" cellpadding="0" cellspacing="0" border="0" class="results">
		<tr>
			<th>Name</th>
			<th>Value</th>
		</tr>
		<tbody>
			<tr class="odd-alt-sp">
				<td valign="top" style="width:30%;">Organism</td>
				<td>
					<a href="/${WEB_PROPERTIES['webapp.path']}/report.do?id=${organism.id}" style="text-decoration: none;"><strong>${organism.shortName}</strong></a></br>
				</td>
			</tr>
			<tr class="even-alt-sp">
				<td valign="top" style="width:30%;">Mutants</td>
				<td>
					<c:choose>
	       				<c:when test="${not empty toxoplasmaMutants}">
							<c:forEach var="toxoplasmaMutant" items="${toxoplasmaMutants}" varStatus="toxoplasma_mutant_status">
								<a href="/${WEB_PROPERTIES['webapp.path']}/report.do?id=${toxoplasmaMutant.id}" style="text-decoration: none;"><strong>${toxoplasmaMutant.mutantName}</strong></a></br>
							</c:forEach>
						</c:when>
						<c:otherwise>
							<i>not available</i>
						</c:otherwise>
					</c:choose>
				</td>
			</tr>
			<tr class="odd-alt-sp">
				<td valign="top" style="width:30%;">Antibodies</td>
				<td>
					<c:choose>
	       				<c:when test="${not empty antibodies}">
							<c:forEach var="antibody" items="${antibodies}" varStatus="antibody_status">
								<a href="/${WEB_PROPERTIES['webapp.path']}/report.do?id=${antibody.id}" style="text-decoration: none;"><strong>${antibody.name}</strong></a></br>
							</c:forEach>
						</c:when>
						<c:otherwise>
							<i>not available</i>
						</c:otherwise>
					</c:choose>
				</td>
			</tr>
			<tr class="even-alt-sp">
				<td valign="top" style="width:30%;">Sequencing</td>
				<td>
					<c:choose>
	       				<c:when test="${not empty sequencings}">
							<c:forEach var="sequencing" items="${sequencings}" varStatus="sequencing_status">
								<a href="/${WEB_PROPERTIES['webapp.path']}/report.do?id=${sequencing.id}" style="text-decoration: none;"><strong>${sequencing.name}</strong></a></br>
							</c:forEach>
						</c:when>
						<c:otherwise>
							<i>not available</i>
						</c:otherwise>
					</c:choose>
				</td>
			</tr>
			<tr class="odd-alt-sp">
				<td valign="top" style="width:30%;">MicroArrays</td>
				<td>
					<c:choose>
	       				<c:when test="${not empty microArrays}">
							<c:forEach var="microArray" items="${microArrays}" varStatus="microarray_status">
								<a href="/${WEB_PROPERTIES['webapp.path']}/report.do?id=${microArray.id}" style="text-decoration: none;"><strong>${microArray.name}</strong></a></br>
							</c:forEach>
						</c:when>
						<c:otherwise>
							<i>not available</i>
						</c:otherwise>
					</c:choose>
				</td>
			</tr>
		</tbody>
	</table>
</div>

<!-- /submissionPropertiesDisplayer.jsp -->
