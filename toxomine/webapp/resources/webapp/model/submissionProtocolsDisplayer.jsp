<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html"%>
<%@ taglib uri="/WEB-INF/struts-tiles.tld" prefix="tiles"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="im"%>
<%@ taglib uri="http://flymine.org/imutil" prefix="imutil"%>
<%@ taglib uri="http://jakarta.apache.org/taglibs/string-1.1" prefix="str"%>

<!-- submissionProtocolsDisplayer.jsp -->

<tiles:importAttribute />

<html:xhtml />

<div class="body">

<%--========== --%>

<script type="text/javascript" charset="utf-8">
    jQuery(document).ready(function () {
        jQuery("#sis").click(function () {
           if(jQuery("#protocols").is(":hidden")) {
             jQuery("#co").attr("src", "images/disclosed.gif");
           } else {
             jQuery("#co").attr("src", "images/undisclosed.gif");
           }
           jQuery("#protocols").toggle("slow");
        });
    })
</script>

<html:link linkName="#" styleId="sis" style="cursor:pointer">
    <h3>
        Protocols used for this submission (click to toggle)
        <img src="images/undisclosed.gif" id="co">
    </h3>
</html:link>

<script type="text/javascript" charset="utf-8">

jQuery(document).ready(function () {
 jQuery(".tbox").children('doopen').show();
 jQuery(".tbox").children('doclose').hide();

  jQuery('.tbox').click(function () {
  var text = jQuery(this).children('doclose');

  if (text.is(':hidden')) {
       jQuery(this).children('doclose').show("slow");
     } else {
         jQuery(this).children('doopen').show("slow");
      }
   });

  jQuery("doopen").click(function(){
     jQuery(this).toggle("slow");
     return true;
    });

  jQuery("doclose").click(function(){
      jQuery(this).toggle("slow");
        return true;
    });


  });

</script>

<style type="text/css">
.odd-alt-p {
  background-color: #FBF5EF;
}
.even-alt-p {
  background-color: #F6E3CE;
}
.odd-alt-ap {
  background-color: #F2F2F2;
}
.even-alt-ap {
  background-color: #D8D8D8;
}
</style>

<div id="protocols" style="display: block">
    <table width="100%" cellpadding="0" cellspacing="0" border="0" class="results">
        <tr>
            <th>Protocol</th>
            <th>Type</th>
            <th width="50%" >Description</th>
        </tr>
        <c:forEach items="${protocols}" var="prot" varStatus="p_status">
            <c:set var="pRowClass">
                <c:choose>
                    <c:when test="${p_status.count % 2 == 1}">
                        odd-alt-p
                    </c:when>
                    <c:otherwise>
                        even-alt-p
                    </c:otherwise>
                </c:choose>
            </c:set>

          <tr class="<c:out value="${pRowClass}"/>">
              <td>
                <html:link href="/${WEB_PROPERTIES['webapp.path']}/report.do?id=${prot.id}">
                    ${prot.name}
                </html:link>
              </td>
              <td>${prot.type}</td>
              <td class="description">
                  <div class="tbox">
                      <doopen>
                          <img src="images/undisclosed.gif">
                          <i>${fn:substring(prot.description,0,80)}... </i>
                      </doopen>
                      <doclose>
                          <img src="images/disclosed.gif">
                          <i>${prot.description}</i>
                      </doclose>
                  </div>
              </td>
          </tr>
        </c:forEach>
    </table>
</div>

<%---========= --%>

<script type="text/javascript" charset="utf-8">
    jQuery(document).ready(function () {
        jQuery("#bro").click(function () {
           if(jQuery("#appliedProtocols").is(":hidden")) {
             jQuery("#oc").attr("src", "images/disclosed.gif");
           } else {
             jQuery("#oc").attr("src", "images/undisclosed.gif");
           }
           jQuery("#appliedProtocols").toggle("slow");
        });
    })
</script>

<html:link linkName="#" styleId="bro" style="cursor:pointer">
    <h3>
        Browse metadata for this submission (click to toggle)
        <img src="images/undisclosed.gif" id="co">
    </h3>
</html:link>

<div id="appliedProtocols" style="display: block">
    <table width="100%" cellpadding="0" cellspacing="0" border="0" class="results">
        <tr>
          <th>Step</th>
          <th>Inputs</th>
          <th>Applied Protocol</th>
          <th>Outputs</th>
        </tr>
        <tbody>
		<c:forEach items="${appliedProtocols}" var="appliedProtocol" varStatus="applied_protocol_status">
            <c:set var="pRowClassAP">
                <c:choose>
                    <c:when test="${applied_protocol_status.count % 2 == 1}">
                        odd-alt-ap
                    </c:when>
                    <c:otherwise>
                        even-alt-ap
                    </c:otherwise>
                </c:choose>
            </c:set>
			<tr class="<c:out value="${pRowClassAP}"/>">
			 	<td>${appliedProtocol.step}</td>
			 	<!--  Inputs  -->
			 	<td>
			 		<c:set var="inputExist" value="no"/>
			 		<c:forEach items="${inputSubmissionData}" var="inputSD" varStatus="input_submission_data_status">
			 			<c:if test="${appliedProtocol.id == inputSD.inputAppliedProtocol.id}">
			 				<c:set var="inputExist" value="yes"/>
			 				<c:choose>
			 					<c:when test="${inputSD.partOf eq 'dataAnalysis'}">
                    				Data Analysis :
			 						<html:link href="/${WEB_PROPERTIES['webapp.path']}/report.do?id=${inputSD.dataAnalysis.id}">
                    					${inputSD.dataAnalysis.name}
                					</html:link></br>
                				</c:when>
               					<c:when test="${inputSD.partOf eq 'experimentalFactor'}">
               						Experimental Factor :
		 							<html:link href="/${WEB_PROPERTIES['webapp.path']}/report.do?id=${inputSD.experimentalFactor.id}">
                   						${inputSD.experimentalFactor.value}
               						</html:link></br>
               					</c:when>
               					<c:when test="${inputSD.partOf eq 'microarray'}">
									MicroArray :
		 							<html:link href="/${WEB_PROPERTIES['webapp.path']}/report.do?id=${inputSD.microArray.id}">
                   						${inputSD.microArray.name}
               						</html:link></br>
               					</c:when>
               					<c:when test="${inputSD.partOf eq 'sequencing'}">
               						Sequencing :
		 							<html:link href="/${WEB_PROPERTIES['webapp.path']}/report.do?id=${inputSD.sequencing.id}">
                   						${inputSD.sequencing.name}
               						</html:link></br>
               					</c:when>
               					<c:when test="${inputSD.partOf eq 'antibody'}">
               						Antibody :
		 							<html:link href="/${WEB_PROPERTIES['webapp.path']}/report.do?id=${inputSD.antibody.id}">
                   						${inputSD.antibody.name}
               						</html:link></br>
               					</c:when>
               					<c:when test="${inputSD.partOf eq 'toxoplasmaMutant'}">
									Mutant :
		 							<html:link href="/${WEB_PROPERTIES['webapp.path']}/report.do?id=${inputSD.toxoplasmaMutant.id}">
                   						${inputSD.toxoplasmaMutant.name}
               						</html:link></br>
               					</c:when>
               					<c:when test="${inputSD.partOf eq 'persistentDataFile'}">
               						${inputSD.persistentDataFile.type} :
		 							<html:link href="/${WEB_PROPERTIES['webapp.path']}/report.do?id=${inputSD.persistentDataFile.id}">
                   						${inputSD.persistentDataFile.name}
               						</html:link></br>
               					</c:when>
               					<c:when test="${inputSD.partOf eq 'submissionDataFile'}">
               						${inputSD.submissionDataFile.type} :
		 							<html:link href="/${WEB_PROPERTIES['webapp.path']}/report.do?id=${inputSD.submissionDataFile.id}">
                   						${inputSD.submissionDataFile.name}
               						</html:link></br>
               					</c:when>
                			</c:choose>     				
			 			</c:if>
			 		</c:forEach>
			 		<c:if test="${inputExist eq 'no'}">
			 			<i><c:out value="--> previous Step"/></i>
			 		</c:if>
			 	</td>
			 	<!--  Protocol  -->
			 	<td>
 					<html:link href="/${WEB_PROPERTIES['webapp.path']}/report.do?id=${appliedProtocol.protocol.id}">
     					${appliedProtocol.protocol.name}
     				</html:link>
     			</td>
     			<!--  Outputs  -->
			 	<td>
			 		<c:set var="outputExist" value="no"/>
			 		<c:forEach items="${outputSubmissionData}" var="outputSD" varStatus="output_submission_data_status">
			 			<c:if test="${appliedProtocol.id == outputSD.outputAppliedProtocol.id}">
			 				<c:set var="outputExist" value="yes"/>
			 				<c:choose>
			 					<c:when test="${outputSD.partOf eq 'dataAnalysis'}">
                    				Data Analysis :
			 						<html:link href="/${WEB_PROPERTIES['webapp.path']}/report.do?id=${outputSD.dataAnalysis.id}">
                    					${outputSD.dataAnalysis.name}
                					</html:link></br>
                				</c:when>
               					<c:when test="${outputSD.partOf eq 'experimentalFactor'}">
               						ExperimentalFactor :
		 							<html:link href="/${WEB_PROPERTIES['webapp.path']}/report.do?id=${outputSD.experimentalFactor.id}">
                   						${outputSD.experimentalFactor.value}
               						</html:link></br>
               					</c:when>
               					<c:when test="${outputSD.partOf eq 'microarray'}">
									MicroArray :
		 							<html:link href="/${WEB_PROPERTIES['webapp.path']}/report.do?id=${outputSD.microArray.id}">
                   						${outputSD.microArray.name}
               						</html:link></br>
               					</c:when>
               					<c:when test="${outputSD.partOf eq 'sequencing'}">
               						Sequencing :
		 							<html:link href="/${WEB_PROPERTIES['webapp.path']}/report.do?id=${outputSD.sequencing.id}">
                   						${outputSD.sequencing.name}
               						</html:link></br>
               					</c:when>
               					<c:when test="${outputSD.partOf eq 'antibody'}">
               						Antibody :
		 							<html:link href="/${WEB_PROPERTIES['webapp.path']}/report.do?id=${outputSD.antibody.id}">
                   						${outputSD.antibody.name}
               						</html:link></br>
               					</c:when>
               					<c:when test="${outputSD.partOf eq 'toxoplasmaMutant'}">
									Mutant :
		 							<html:link href="/${WEB_PROPERTIES['webapp.path']}/report.do?id=${outputSD.toxoplasmaMutant.id}">
                   						${outputSD.toxoplasmaMutant.name}
               						</html:link></br>
               					</c:when>
               					<c:when test="${outputSD.partOf eq 'persistentDataFile'}">
               						${outputSD.persistentDataFile.type} :
		 							<html:link href="/${WEB_PROPERTIES['webapp.path']}/report.do?id=${outputSD.persistentDataFile.id}">
                   						${outputSD.persistentDataFile.name}
               						</html:link></br>
               					</c:when>
               					<c:when test="${outputSD.partOf eq 'submissionDataFile'}">
               						${outputSD.submissionDataFile.type} :
		 							<html:link href="/${WEB_PROPERTIES['webapp.path']}/report.do?id=${outputSD.submissionDataFile.id}">
                   						${outputSD.submissionDataFile.name}
               						</html:link></br>
               					</c:when>
               					<c:otherwise>
               						<i><c:out value="--> next Step"/></i>
               					</c:otherwise>	
                			</c:choose>   
			 			</c:if>
			 		</c:forEach>
			 		<c:if test="${outputExist eq 'no'}">
			 			<i><c:out value="--> next Step"/></i>
			 		</c:if>
			   	</td>
			</tr>
		</c:forEach>
        </tbody>
    </table>
</div>


<!-- /submissionProtocolsDisplayer.jsp -->
