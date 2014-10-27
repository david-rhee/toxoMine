<!-- orthologues.jsp -->
<%@ taglib tagdir="/WEB-INF/tags" prefix="im" %>

<TABLE width="100%">
  <tr>
    <td valign="top">
      <div class="heading2">
        Current data
      </div>
      <div class="body">

	  <div id="hiddenDiv3" class="dataSetDescription">
        <p>Orthologue and paralogue relationships calculated by <A href="http://www.orthomcl.org/" target="_new">OrthoMCL</A> between the following organisms:</p>
        <ul>
          <li><I>T.gondii</I></li>
        </ul><br/>
		</div>
	</td>

    <td width="40%" valign="top">
      <div class="heading2">
       Bulk download
      </div>
      <div class="body">
        <ul>
          <li>
            <im:querylink text="Homologues: <i>T.gondii</i> " skipBuilder="true">
			<query name="" model="genomic" view="Homologue.gene.primaryIdentifier Homologue.gene.secondaryIdentifier Homologue.gene.symbol Homologue.homologue.primaryIdentifier Homologue.homologue.secondaryIdentifier Homologue.type Homologue:dataSets.name" sortOrder="Homologue.gene.primaryIdentifier asc Homologue.gene.secondaryIdentifier asc Homologue.gene.symbol asc Homologue.homologue.primaryIdentifier asc Homologue.homologue.secondaryIdentifier asc Homologue.type asc" constraintLogic="A">
  			<pathDescription pathString="Homologue:dataSets" description="dataset">
  			</pathDescription>
  			<pathDescription pathString="Homologue.homologue" description="Homologue">
  			</pathDescription>
  			<pathDescription pathString="Homologue.gene" description="Gene">
  			</pathDescription>
  			<node path="Homologue" type="Homologue">
  			</node>
  			<node path="Homologue.gene" type="Gene">
  			</node>
  			<node path="Homologue.gene.organism" type="Organism">
  			</node>
  			<node path="Homologue.gene.organism.name" type="String">
    		<constraint op="=" value="Toxoplasma gondii" description="Show the predicted orthologues between:" identifier="" editable="true" code="A">
    		</constraint>
  			</node>
			</query>
            </im:querylink>
          </li>
        </ul>
      </div>
    </td>
  </tr>
</TABLE>

<!-- /orthologues.jsp -->