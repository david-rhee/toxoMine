<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html" %>

<!-- toxoMineGBrowseDisplayer.jsp -->
<!-- modified from original - David Rhee -->

<!-- Check if object is a chromosome or other sequence feature type -->
<c:choose>
	<c:when test="${classUnqualifiedName == 'Chromosome'}">
		<c:set var="chromosomePrimaryIdentifier" value="${object.primaryIdentifier}"/>

		<!-- Grab location and set offsets -->
		<c:set var="chromosomeStart" value="${object.chromosomeLocation.start}"/>
		<c:set var="chromosomeEnd" value="${object.chromosomeLocation.end}"/>
		<c:set var="chromosomeOffset" value="${(chromosomeEnd-chromosomeStart)/10}"/>
		<c:set var="chromosomeIstart" value="${chromosomeStart-chromosomeOffset}"/>
		<c:set var="chromosomeIend" value="${chromosomeEnd+chromosomeOffset}"/>

		<!-- Create link with given locations -->
		<c:set var="linkPrecursor" value="${chromosomePrimaryIdentifier}:${chromosomeIstart}-${chromosomeIend}"></c:set>
		<c:set var="label" value=""/>
		<c:set var="link" value="${linkPrecursor};${label}"></c:set>

		<div id="gBrowse">
  			<h3>ToxoDB GBrowse</h3>
			<html:link href="http://www.toxodb.org/cgi-bin/gbrowse/toxodb/?name=${link}" target="_blank">
      		<div>
        		<html:img style="border: 1px solid black" src="http://www.toxodb.org/cgi-bin/gbrowse_img/toxodb/?name=${link}" title="GBrowse"/>
      		</div>
			</html:link>
		</div>
	</c:when>

	<c:when test="${classUnqualifiedName == 'Gene'}">
		<c:if test="${(!empty object.chromosomeLocation && !empty object.chromosome)}">
			<c:set var="chromosomePrimaryIdentifier" value="${object.chromosome.primaryIdentifier}"/>

			<!-- Grab location and set offsets -->
			<c:set var="chromosomeStart" value="${object.chromosomeLocation.start}"/>
			<c:set var="chromosomeEnd" value="${object.chromosomeLocation.end}"/>
			<c:set var="chromosomeOffset" value="${(chromosomeEnd-chromosomeStart)/10}"/>
			<c:set var="chromosomeIstart" value="${chromosomeStart-chromosomeOffset}"/>
			<c:set var="chromosomeIend" value="${chromosomeEnd+chromosomeOffset}"/>

			<!-- Create link with given locations -->
			<c:set var="linkPrecursor" value="${chromosomePrimaryIdentifier}:${chromosomeIstart}-${chromosomeIend}"></c:set>
			<!-- If object is gene or has link to gene, create h_feat -->
			<c:set var="label" value="h_feat=${object.primaryIdentifier}@yellow"/>
			<c:set var="link" value="${linkPrecursor};${label}"></c:set>

			<div id="gBrowse">
  				<h3>ToxoDB GBrowse</h3>
				<html:link href="http://www.toxodb.org/cgi-bin/gbrowse/toxodb/?name=${link}" target="_blank">
      			<div>
        			<html:img style="border: 1px solid black" src="http://www.toxodb.org/cgi-bin/gbrowse_img/toxodb/?name=${link}" title="GBrowse"/>
      			</div>
				</html:link>
			</div>
		</c:if>
	</c:when>

	<c:when test="${classUnqualifiedName == 'Transcript'}">
		<c:if test="${(!empty object.chromosomeLocation && !empty object.chromosome)}">
			<c:set var="chromosomePrimaryIdentifier" value="${object.chromosome.primaryIdentifier}"/>

			<!-- Grab location and set offsets -->
			<c:set var="chromosomeStart" value="${object.chromosomeLocation.start}"/>
			<c:set var="chromosomeEnd" value="${object.chromosomeLocation.end}"/>
			<c:set var="chromosomeOffset" value="${(chromosomeEnd-chromosomeStart)/10}"/>
			<c:set var="chromosomeIstart" value="${chromosomeStart-chromosomeOffset}"/>
			<c:set var="chromosomeIend" value="${chromosomeEnd+chromosomeOffset}"/>

			<!-- Create link with given locations -->
			<c:set var="linkPrecursor" value="${chromosomePrimaryIdentifier}:${chromosomeIstart}-${chromosomeIend}"></c:set>
			<!-- If object is gene or has link to gene, create h_feat -->
			<c:set var="label" value="h_feat=${object.primaryIdentifier}@yellow"/>
			<c:set var="link" value="${linkPrecursor};${label}"></c:set>

			<div id="gBrowse">
  				<h3>ToxoDB GBrowse</h3>
				<html:link href="http://www.toxodb.org/cgi-bin/gbrowse/toxodb/?name=${link}" target="_blank">
      			<div>
        			<html:img style="border: 1px solid black" src="http://www.toxodb.org/cgi-bin/gbrowse_img/toxodb/?name=${link}" title="GBrowse"/>
      			</div>
				</html:link>
			</div>
		</c:if>
	</c:when>

	<c:when test="${classUnqualifiedName == 'MRNA'}">
		<c:if test="${(!empty object.chromosomeLocation && !empty object.chromosome)}">
			<c:set var="chromosomePrimaryIdentifier" value="${object.chromosome.primaryIdentifier}"/>

			<!-- Grab location and set offsets -->
			<c:set var="chromosomeStart" value="${object.chromosomeLocation.start}"/>
			<c:set var="chromosomeEnd" value="${object.chromosomeLocation.end}"/>
			<c:set var="chromosomeOffset" value="${(chromosomeEnd-chromosomeStart)/10}"/>
			<c:set var="chromosomeIstart" value="${chromosomeStart-chromosomeOffset}"/>
			<c:set var="chromosomeIend" value="${chromosomeEnd+chromosomeOffset}"/>

			<!-- Create link with given locations -->
			<c:set var="linkPrecursor" value="${chromosomePrimaryIdentifier}:${chromosomeIstart}-${chromosomeIend}"></c:set>
			<!-- If object is gene or has link to gene, create h_feat -->
			<c:set var="label" value="h_feat=${object.primaryIdentifier}@yellow"/>
			<c:set var="link" value="${linkPrecursor};${label}"></c:set>

			<div id="gBrowse">
  				<h3>ToxoDB GBrowse</h3>
				<html:link href="http://www.toxodb.org/cgi-bin/gbrowse/toxodb/?name=${link}" target="_blank">
      			<div>
        			<html:img style="border: 1px solid black" src="http://www.toxodb.org/cgi-bin/gbrowse_img/toxodb/?name=${link}" title="GBrowse"/>
      			</div>
				</html:link>
			</div>
		</c:if>
	</c:when>

	<c:when test="${classUnqualifiedName == 'TRNA'}">
		<c:if test="${(!empty object.chromosomeLocation && !empty object.chromosome)}">
			<c:set var="chromosomePrimaryIdentifier" value="${object.chromosome.primaryIdentifier}"/>

			<!-- Grab location and set offsets -->
			<c:set var="chromosomeStart" value="${object.chromosomeLocation.start}"/>
			<c:set var="chromosomeEnd" value="${object.chromosomeLocation.end}"/>
			<c:set var="chromosomeOffset" value="${(chromosomeEnd-chromosomeStart)/10}"/>
			<c:set var="chromosomeIstart" value="${chromosomeStart-chromosomeOffset}"/>
			<c:set var="chromosomeIend" value="${chromosomeEnd+chromosomeOffset}"/>

			<!-- Create link with given locations -->
			<c:set var="linkPrecursor" value="${chromosomePrimaryIdentifier}:${chromosomeIstart}-${chromosomeIend}"></c:set>
			<!-- If object is gene or has link to gene, create h_feat -->
			<c:set var="label" value="h_feat=${object.primaryIdentifier}@yellow"/>
			<c:set var="link" value="${linkPrecursor};${label}"></c:set>

			<div id="gBrowse">
  				<h3>ToxoDB GBrowse</h3>
				<html:link href="http://www.toxodb.org/cgi-bin/gbrowse/toxodb/?name=${link}" target="_blank">
      			<div>
        			<html:img style="border: 1px solid black" src="http://www.toxodb.org/cgi-bin/gbrowse_img/toxodb/?name=${link}" title="GBrowse"/>
      			</div>
				</html:link>
			</div>
		</c:if>
	</c:when>

	<c:when test="${classUnqualifiedName == 'RRNA'}">
		<c:if test="${(!empty object.chromosomeLocation && !empty object.chromosome)}">
			<c:set var="chromosomePrimaryIdentifier" value="${object.chromosome.primaryIdentifier}"/>

			<!-- Grab location and set offsets -->
			<c:set var="chromosomeStart" value="${object.chromosomeLocation.start}"/>
			<c:set var="chromosomeEnd" value="${object.chromosomeLocation.end}"/>
			<c:set var="chromosomeOffset" value="${(chromosomeEnd-chromosomeStart)/10}"/>
			<c:set var="chromosomeIstart" value="${chromosomeStart-chromosomeOffset}"/>
			<c:set var="chromosomeIend" value="${chromosomeEnd+chromosomeOffset}"/>

			<!-- Create link with given locations -->
			<c:set var="linkPrecursor" value="${chromosomePrimaryIdentifier}:${chromosomeIstart}-${chromosomeIend}"></c:set>
			<!-- If object is gene or has link to gene, create h_feat -->
			<c:set var="label" value="h_feat=${object.primaryIdentifier}@yellow"/>
			<c:set var="link" value="${linkPrecursor};${label}"></c:set>

			<div id="gBrowse">
  				<h3>ToxoDB GBrowse</h3>
				<html:link href="http://www.toxodb.org/cgi-bin/gbrowse/toxodb/?name=${link}" target="_blank">
      			<div>
        			<html:img style="border: 1px solid black" src="http://www.toxodb.org/cgi-bin/gbrowse_img/toxodb/?name=${link}" title="GBrowse"/>
      			</div>
				</html:link>
			</div>
		</c:if>
	</c:when>

	<c:when test="${classUnqualifiedName == 'CDS'}">
		<c:if test="${(!empty object.chromosomeLocation && !empty object.chromosome)}">
			<c:set var="chromosomePrimaryIdentifier" value="${object.chromosome.primaryIdentifier}"/>

			<!-- Grab location and set offsets -->
			<c:set var="chromosomeStart" value="${object.chromosomeLocation.start}"/>
			<c:set var="chromosomeEnd" value="${object.chromosomeLocation.end}"/>
			<c:set var="chromosomeOffset" value="${(chromosomeEnd-chromosomeStart)/10}"/>
			<c:set var="chromosomeIstart" value="${chromosomeStart-chromosomeOffset}"/>
			<c:set var="chromosomeIend" value="${chromosomeEnd+chromosomeOffset}"/>

			<!-- Create link with given locations -->
			<c:set var="linkPrecursor" value="${chromosomePrimaryIdentifier}:${chromosomeIstart}-${chromosomeIend}"></c:set>
			<!-- If object is gene or has link to gene, create h_feat -->
			<c:set var="label" value="h_feat=${object.primaryIdentifier}@yellow"/>
			<c:set var="link" value="${linkPrecursor};${label}"></c:set>

			<div id="gBrowse">
  				<h3>ToxoDB GBrowse</h3>
				<html:link href="http://www.toxodb.org/cgi-bin/gbrowse/toxodb/?name=${link}" target="_blank">
      			<div>
        			<html:img style="border: 1px solid black" src="http://www.toxodb.org/cgi-bin/gbrowse_img/toxodb/?name=${link}" title="GBrowse"/>
      			</div>
				</html:link>
			</div>
		</c:if>
	</c:when>

	<c:when test="${classUnqualifiedName == 'Contig'}">
		<c:set var="chromosomePrimaryIdentifier" value="${object.primaryIdentifier}"/>

		<!-- Grab location and set offsets -->
		<c:set var="chromosomeStart" value="${object.chromosomeLocation.start}"/>
		<c:set var="chromosomeEnd" value="${object.chromosomeLocation.end}"/>
		<c:set var="chromosomeOffset" value="${(chromosomeEnd-chromosomeStart)/10}"/>
		<c:set var="chromosomeIstart" value="${chromosomeStart-chromosomeOffset}"/>
		<c:set var="chromosomeIend" value="${chromosomeEnd+chromosomeOffset}"/>

		<!-- Create link with given locations -->
		<c:set var="linkPrecursor" value="${chromosomePrimaryIdentifier}:${chromosomeIstart}-${chromosomeIend}"></c:set>
		<c:set var="label" value=""/>
		<c:set var="link" value="${linkPrecursor};${label}"></c:set>

		<div id="gBrowse">
  			<h3>ToxoDB GBrowse</h3>
			<html:link href="http://www.toxodb.org/cgi-bin/gbrowse/toxodb/?name=${link}" target="_blank">
      		<div>
        		<html:img style="border: 1px solid black" src="http://www.toxodb.org/cgi-bin/gbrowse_img/toxodb/?name=${link}" title="GBrowse"/>
      		</div>
			</html:link>
		</div>
	</c:when>

	<c:when test="${classUnqualifiedName == 'Supercontig'}">
		<c:set var="chromosomePrimaryIdentifier" value="${object.primaryIdentifier}"/>

		<!-- Grab location and set offsets -->
		<c:set var="chromosomeStart" value="${object.chromosomeLocation.start}"/>
		<c:set var="chromosomeEnd" value="${object.chromosomeLocation.end}"/>
		<c:set var="chromosomeOffset" value="${(chromosomeEnd-chromosomeStart)/10}"/>
		<c:set var="chromosomeIstart" value="${chromosomeStart-chromosomeOffset}"/>
		<c:set var="chromosomeIend" value="${chromosomeEnd+chromosomeOffset}"/>

		<!-- Create link with given locations -->
		<c:set var="linkPrecursor" value="${chromosomePrimaryIdentifier}:${chromosomeIstart}-${chromosomeIend}"></c:set>
		<c:set var="label" value=""/>
		<c:set var="link" value="${linkPrecursor};${label}"></c:set>

		<div id="gBrowse">
  			<h3>ToxoDB GBrowse</h3>
			<html:link href="http://www.toxodb.org/cgi-bin/gbrowse/toxodb/?name=${link}" target="_blank">
      		<div>
        		<html:img style="border: 1px solid black" src="http://www.toxodb.org/cgi-bin/gbrowse_img/toxodb/?name=${link}" title="GBrowse"/>
      		</div>
			</html:link>
		</div>
	</c:when>

</c:choose>
<!-- /toxoMineGBrowseDisplayer.jsp -->
