<!-- GO.jsp -->
<%@ taglib tagdir="/WEB-INF/tags" prefix="im" %>

<table width="100%">
  <tr>
    <td valign="top">
      <div class="heading2">
        Current data
      </div>
      <div class="body">

 	  <h4>
   	  <a href="javascript:toggleDiv('hiddenDiv1');">
    	<img id='hiddenDiv1Toggle' src="images/disclosed.gif"/>
    	GO annotation in toxoMine ...
   	  </a>
 	  </h4>

	  <div id="hiddenDiv1" class="dataSetDescription">
      <p>
      The Gene Ontology project provides a controlled vocabulary to describe
      gene and gene product attributes in any organism.  The GO collaborators
      are developing three structured, controlled vocabularies (ontologies)
      that describe gene products in terms of their associated biological
      processes, cellular components and molecular functions in a species-independent manner.
      </p>
        <ul>
         <li>Protein Domains - GO annotations for InterPro protein domains gene  assigned by <a href="http://www.ebi.ac.uk/interpro/" target="_new">InterPro</a>.</li><br/>
       </ul>
      </div>

    <td width="40%" valign="top">
      <div class="heading2">
        Bulk download
      </div>
      <div class="body">
        <ul>

          <li>
            <im:querylink text="All gene/GO annotation pairs from <i>T.gondii</i> " skipBuilder="true">
			<query name="" model="genomic" view="Gene.primaryIdentifier Gene.secondaryIdentifier Gene.symbol Gene.goAnnotation.ontologyTerm.name Gene.goAnnotation.ontologyTerm.identifier Gene.goAnnotation.ontologyTerm.namespace" sortOrder="Gene.primaryIdentifier asc">
  			<constraint path="Gene.organism.name" op="=" value="Toxoplasma gondii"/>
			</query>
			</im:querylink>
         </li>

       </ul>
      </div>
    </td>
  </tr>
</table>
<!-- /GO.jsp -->
