<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html" %>
<%@ taglib uri="/WEB-INF/struts-tiles.tld" prefix="tiles" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib tagdir="/WEB-INF/tags" prefix="im"%>
<%@ taglib uri="/WEB-INF/functions.tld" prefix="imf" %>

<!-- begin.jsp -->
<html:xhtml/>

<script src="http://code.jquery.com/jquery-latest.js"></script>

<div id="container">
	<div id="welcome-bochs" class="span-42">
		<div id="welcome-content">
			<div class="welcome-content-p">
              	<h2>Welcome to toxoMine</h2>
			  	<p><strong>toxoMine</strong> is an integrated web resource of data &amp; tools to <strong>browse</strong>, <strong>search</strong> and 
			  	<strong>download</strong> publicly available <i>T. gondii</i> experimental data and metadata. 
			  	Data integrated in <strong>toxoMine</strong> are uploaded from the <a href="http://www.toxocore.org/">toxoCore.org</a></strong> 
				database which holds the raw sequence-based data derived from a number of biological assays. It also extracts data
				from the <a href="http://www.toxoDB.org/">toxoDB.org</a></strong> database for genome annotation and other data sets.</p>
				<br />
				<p><strong>toxoMine</strong> release <strong>${WEB_PROPERTIES['project.releaseVersion']}</strong>
				uses genome annotations <strong>${WEB_PROPERTIES['genomeVersion.me49']}</strong> for ME49.</p>
				<br />
			</div>
			<div class="welcome-content-p">
				<h3><a href="/${WEB_PROPERTIES['webapp.path']}/projects.do">Browse all toxoCore data</a></h3>
			</div>
		</div>
	</div>

	<div style="clear:both;"></div>

	<div id="other-bochs">
		<div id="search-bochs" class="span-21">
			<img title="search" src="themes/purple/homepage/search-ico-right.png" class="title">
			<h3><a href="/${WEB_PROPERTIES['webapp.path']}/keywordSearchResults.do?searchBag=">Search</a></h3>
		    <div class="text">
		    	<span style="width:76px; float:left;">&nbsp;</span>
		        <p>Enter names, identifiers or keywords for genes, proteins, pathways, ontology terms, etc. (e.g.<strong>TGME49_215990</strong>, <strong>Kim Lab</strong>, <strong>ChIP-chip</strong>).
		        <form action="<c:url value="/keywordSearchResults.do" />" name="search" method="get">
		          <input id="dataSearch" class="input" type="text" name="searchTerm" value="e.g. TGME49_215990, Kim Lab, ChIP-chip" />
		          <input type="submit" value="Search" />
		        </form>		
		    </div>
		</div>
	
		<div id="genomic-bochs" class="span-21 last">
			<img title="lists" src="images/icons/genomic-search-64.png" class="title">
		  	<h3><a href="/${WEB_PROPERTIES['webapp.path']}/genomicRegionSearch.do">Genomic Region Search</a></h3>
		  	<div class="text">
		    	<span style="width:76px; float:left;"></span>
		    	<p>
		    		<a href="/${WEB_PROPERTIES['webapp.path']}/genomicRegionSearch.do"><img src="themes/modmine/genome_region.jpg" alt="Genome Region Search" style="float:right;padding-left:5px;margin-right:4px;"/></a>
		      		<strong>Explore</strong> a genomic region for features found by the <strong>toxoCore</strong> project.
		      		<a href="/${WEB_PROPERTIES['webapp.path']}/genomicRegionSearch.do">Genomic Region Search</a>
		    	</p>
		  	</div>
		</div>
	</div>

	<div style="clear:both;"></div>
</div>

<script type="text/javascript">
   // minimize big welcome box into an info message
   function toggleWelcome() {
     // minimizing?
     if ($("#welcome").is(':visible')) {
       // hide the big box
       $('#welcome').slideUp();
       // do we have words to say?
       var welcomeText = $("#welcome-content.current").text();
       if (welcomeText.length > 0) {
         $("#ctxHelpDiv.welcome").slideDown("slow", function() {
           // ...display a notification with an appropriate text
           if (welcomeText.length > 150) {
             // ... substr
             $("#ctxHelpTxt.welcome").html(welcomeText.substring(0, 150) + '&hellip;');
           } else {
             $("#ctxHelpTxt.welcome").html(welcomeText);
           }
           });
       }
     } else {
       $("#ctxHelpDiv.welcome").slideUp(function() {
         $("#welcome").slideDown("slow");
       });
     }
   }

   /* hide switcher of we are on first time here */
   if ($("#switcher-1").hasClass('current')) {
     $("#switcher").hide();
   }

   /* div switcher for welcome bochs using jQuery */
   function switchBochs(newDivId) {
     // no current
     javascript:jQuery(".switcher").each (function() { javascript:jQuery(this).removeClass('current'); });
     // apply current
     javascript:jQuery('#switcher-'+newDivId).addClass('current');
     // hide them all bochs
     javascript:jQuery(".bochs").each (function() { javascript:jQuery(this).hide(); });
     // then show our baby
     javascript:jQuery('#bochs-'+newDivId).fadeIn();

     // apply active class
     $("#welcome-content").each (function() { javascript:jQuery(this).removeClass('current'); });
     $('#bochs-'+newDivId+' > #welcome-content').addClass('current');

     // show/hide switcher?
     if ($("#switcher-1").hasClass('current')) {
       $("#switcher").hide();
     } else {
       $("#switcher").show();
     }
   }

   // placeholder value for search boxes
   var dataPlaceholder = 'e.g. zen, pha-4';
   var exptPlaceholder = 'e.g. ChIP-seq, CP190';
   var placeholderTextarea = '<c:out value="${WEB_PROPERTIES['textarea.identifiers']}" />';
   // class used when toggling placeholder
   var inputToggleClass = 'eg';

   /* pre-fill search input with a term */
   function preFillInput(term, input) {
     var e = $(input);
     e.val(term);
      if (e.hasClass(inputToggleClass)) e.toggleClass(inputToggleClass);
    e.focus();
   }

   // e.g. values only available when JavaScript is on
   jQuery('input#dataSearch').toggleClass(inputToggleClass);
   jQuery('input#exptSearch').toggleClass(inputToggleClass);
   jQuery('textarea#listInput').toggleClass(inputToggleClass);

   // register input elements with blur & focus
   $('input#dataSearch').blur(function() {
     if ($(this).val() == '') {
       $(this).toggleClass(inputToggleClass);
       $(this).val(dataPlaceholder);
     }
   });
   // register input elements with blur & focus
   jQuery('input#exptSearch').blur(function() {
     if ($(this).val() == '') {
       $(this).toggleClass(inputToggleClass);
       $(this).val(exptPlaceholder);
     }
   });
   jQuery('input#dataSearch').focus(function() {
     if ($(this).hasClass(inputToggleClass)) {
       $(this).toggleClass(inputToggleClass);
       $(this).val('');
     }
   });
   jQuery('input#exptSearch').focus(function() {
       if ($(this).hasClass(inputToggleClass)) {
         $(this).toggleClass(inputToggleClass);
         $(this).val('');
       }
     });
   jQuery('textarea#listInput').blur(function() {
       if (jQuery(this).val() == '') {
           jQuery(this).toggleClass(inputToggleClass);
           jQuery(this).val(placeholderTextarea);
       }
   });
   jQuery('textarea#listInput').focus(function() {
       if (jQuery(this).hasClass(inputToggleClass)) {
           jQuery(this).toggleClass(inputToggleClass);
           jQuery(this).val('');
       }
   });
</script>

<!-- /begin.jsp -->
