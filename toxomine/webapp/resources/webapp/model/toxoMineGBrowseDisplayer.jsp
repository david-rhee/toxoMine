<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html" %>

<!-- toxoMineGBrowseDisplayer.jsp -->
<!-- modified from original - David Rhee -->

<c:if test="${(!empty object.chromosomeLocation && !empty object.chromosome) || className.unqualifiedName == 'Chromosome'}">

	<c:set var="chromosomeStart" value="${object.chromosomeLocation.start}"/>
	<c:set var="chromosomeEnd" value="${object.chromosomeLocation.end}"/>
	<c:set var="chromosomePrimaryIdentifier" value="${object.chromosome.primaryIdentifier}"/>
	<c:set var="chromosomeOffset" value="${(chromosomeEnd-chromosomeStart)/10}"/>
	<c:set var="chromosomeIstart" value="${chromosomeStart-chromosomeOffset}"/>
	<c:set var="chromosomeIend" value="${chromosomeEnd+chromosomeOffset}"/>

	<c:set var="linkPrecursor" value="${chromosomePrimaryIdentifier}:${chromosomeIstart}-${chromosomeIend}"></c:set>

	<c:set var="sequenceFeatureType" value="${className.unqualifiedName}"/>
	<c:choose>
		<c:when test="${sequenceFeatureType == 'Gene'}">
			<c:set var="label" value="h_feat=${object.primaryIdentifier}@yellow"/>
		</c:when>
		<c:when test="${sequenceFeatureType == 'Transcript'}">
			<c:set var="label" value="h_feat=${object.gene.primaryIdentifier}@yellow"/>
		</c:when>
		<c:otherwise>
			<c:set var="label" value=""/>
      	</c:otherwise>
	</c:choose>
	
	<c:set var="link" value="${linkPrecursor};${label}"></c:set>

	<div id="gBrowse">
  		<h3>toxoMine GBrowser via toxoDB.org</h3>
		<html:link href="http://www.toxodb.org/cgi-bin/gbrowse/toxodb/?name=${link}" target="_blank">
      		<div>
        		<html:img style="border: 1px solid black" src="http://www.toxodb.org/cgi-bin/gbrowse_img/toxodb/?name=${link}" title="GBrowse"/>
      		</div>
		</html:link>
	</div>

</c:if>
<!-- /toxoMineGBrowseDisplayer.jsp -->
