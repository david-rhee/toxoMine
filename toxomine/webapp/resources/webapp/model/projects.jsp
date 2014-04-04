<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html"%>
<%@ taglib uri="/WEB-INF/struts-tiles.tld" prefix="tiles"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="im"%>
<%@ taglib uri="http://flymine.org/imutil" prefix="imutil"%>
<%@ taglib uri="http://jakarta.apache.org/taglibs/string-1.1" prefix="str"%>

<tiles:importAttribute />
<html:xhtml />

<script type="text/javascript" src="<html:rewrite page='/js/jquery.qtip-1.0.0-rc3.min.js'/>"></script>
<script type="text/javascript" src="model/jquery_contextMenu/jquery.contextMenu.js"></script>
<script type="text/javascript" src="js/tablesort.js"></script>
<link rel="stylesheet" type="text/css" href="css/sorting_experiments.css"/>
<link rel="stylesheet" type="text/css" href="model/css/experiment.css"/>
<link href="model/jquery_contextMenu/jquery.contextMenu.css" rel="stylesheet" type="text/css" />

<script type="text/javascript">

    jQuery(document).ready( function() {
        jQuery(".exportMenu").hide();
        //
        jQuery(".exportDiv").mouseover(function(e) {
          jQuery('.contextMenu').removeAttr('id');
          jQuery(e.target).parent().children(".contextMenu").attr('id', 'exportMenu');
          });

          jQuery(".exportDiv").contextMenu({ menu: 'exportMenu', leftButton: true },
            function(action, el, pos) { window.open(action, '_self');
             });
    });

</script>

<div class="body">

<div align="center">

<table cellpadding="0" cellspacing="0" border="0" class="sortable-onload-2 rowstyle-alt no-arrow submission_table">

  <tr>
    <th width="250" class="sortable">PROJECTS</th>
    <th width="150" class="sortable">LABS</th>
    <th width="600" class="sortable" >EXPERIMENTS</th>
    <th width="300" class="sortable" >FEATURES</th>
  </tr>

  <c:forEach items="${projectLabs}" var="proj" varStatus="proj_status">
    <c:set var="projectName" value="${proj.key}"/>
	<c:set var="labsName" value="${proj.value}"/>

  	<tr>
    	<td class="sorting">
      		<html:link href="/${WEB_PROPERTIES['webapp.path']}/portal.do?externalid=${projectName}&class=Project">${projectName}</html:link>
    	</td>
		<td class="sorting">
      		<c:forEach items="${labsName}" var="labName" varStatus="lab_status">
    			<html:link href="/${WEB_PROPERTIES['webapp.path']}/portal.do?externalid=${labName}&class=Lab">${labName}</html:link>
    			<br>
      		</c:forEach>     
		</td>
		<td class="sorting">
		<br>
		<c:forEach items="${projectExperiments}" var="exp" varStatus="exp_status">
    		<c:set var="projectExperimentName" value="${exp.key}"/>
			<c:set var="experimentsName" value="${exp.value}"/>
			<c:if test = "${projectExperimentName == projectName}">
      			<c:forEach items="${experimentsName}" var="experimentName" varStatus="experimentName_status">
    				<html:link href="/${WEB_PROPERTIES['webapp.path']}/portal.do?externalid=${experimentName}&class=Experiment">${experimentName}</html:link>
    				<br>
    				<br>
    				<c:forEach items="${experimentSubmissions}" var="subs" varStatus="subs_status">
    					<c:set var="experimentsExperimentName" value="${subs.key}"/>
						<c:set var="submissionsName" value="${subs.value}"/>
    					<c:if test = "${experimentName == experimentsExperimentName}">
    					
    						<c:set var="submissionsCount" value="${fn:length(submissionsName)} Data submissions."/>
    						<im:querylink text="${submissionsCount}" skipBuilder="true">
							<query name="" model="genomic" view="Submission.TCid Submission.name Submission.description" sortOrder="Submission.TCid asc">
   							<node path="Submission" type="Submission"></node>
  							<node path="Submission.experiments" type="Experiment"></node>
  							<node path="Submission.experiments.name" type="String"><constraint op="=" value="${experimentsExperimentName}" description="" identifier="" code="A"></constraint></node>
							</query>
							</im:querylink>
    						<br>
    						<br>
    						<c:if test = "${fn:length(submissionsName) gt 1}">
    							<hr>
    							<br>
    						</c:if>
    					</c:if>
    				</c:forEach>
   				</c:forEach>
    		</c:if>
    	</c:forEach>
    	</td>
		<td class="sorting">
      		<c:forEach items="${projectFeatures}" var="projectFeatures" varStatus="feature_status">
      			<c:set var="projectFeatureName" value="${projectFeatures.key}"/>
      			<c:set var="featuresCount" value="${projectFeatures.value}"/>
      			<c:if test = "${projectFeatureName == projectName}">
      				<c:set var="featuresCount" value="${featuresCount} Features."/>
      				<im:querylink text="${featuresCount}" skipBuilder="true">
      				<query name="" model="genomic" view="Project.submissions.features.primaryIdentifier Project.submissions.features.score" sortOrder="Project.submissions.features.primaryIdentifier asc">
   					<node path="Project" type="Project"></node>
  					<node path="Project.submissions" type="Submission"></node>
  					<node path="Project.submissions.features" type="SequenceFeature"></node>
  					<node path="Project.name" type="String"><constraint op="=" value="${projectName}" description="" identifier="" code="A"></constraint></node>
					</query>
					</im:querylink>
    			</c:if>
      		</c:forEach>     
		</td>
  </tr>

  </c:forEach>
  
</table>
</div>

<!-- <table cellpadding="0" cellspacing="0" border="0" class="sortable-onload-2 rowstyle-alt no-arrow submission_table"> -->

<!--   <tr> -->
<!--     <th width="200" class="sortable">PROJECTS</th> -->
<!--     <th width="200" class="sortable">LABS</th> -->
<!--     <th width="600" class="sortable" >EXPERIMENTS</th> -->
<!--   </tr> -->


<%--   <c:forEach items="${projectLabs}" var="exp" varStatus="exp_status"> --%>
<%--     <c:set var="projectLabsName" value="${exp.key}"/> --%>
<%--     <c:set var="labsName" value="${exp.value}"/> --%>
  
<!--   <tr> -->
<!--     <td class="sorting"> -->
<%--       <html:link href="/${WEB_PROPERTIES['webapp.path']}/portal.do?externalid=${projectName}&class=Project">${projectName}</html:link> --%>
<!--     </td> -->
<!--     <td class="sorting"> -->
<%--       <html:link href="/${WEB_PROPERTIES['webapp.path']}/portal.do?externalid=${labsName}&class=Project">${labsName}</html:link> --%>
<!--     </td> -->
<!--     <td> &nbsp; </td> -->
<!--     <td> &nbsp; </td> -->
<!--   </tr> -->
<%--   </c:forEach> --%>
  
<!-- </table> -->
<!-- </div> -->

