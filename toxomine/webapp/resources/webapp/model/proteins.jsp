<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html" %>
<%@ taglib tagdir="/WEB-INF/tags" prefix="im" %>

<table width="100%">
  <tr>
    <td valign="top" rowspan="2">
      <div class="heading2">
        Current data
      </div>
      <div class="body">
        <DL>
          <DT><A href="http://www.ebi.uniprot.org/index.shtml">UniProt
          Knowledgebase (UniProtKB)</A></DT>
          <DD>
            All proteins from the <A href="http://www.ebi.uniprot.org/index.shtml">UniProt Knowledgebase</A> for the <I>T. gondii</I> have been loaded.
            &nbsp;
            For each protein record in UniProt for each species the following information is extracted:
            <UL>
              <LI>Entry name</LI>
              <LI>Primary accession number</LI>
              <LI>Secondary accession number</LI>
              <LI>Protein name</LI>
              <LI>Comments</LI>
              <LI>Publications</LI>
              <LI>Sequence</LI>
              <LI>Gene ORF name</LI>
            </UL>
          </DD>
        </DL>
      </div>
    </td>
    <td valign="top">
      <div class="heading2">
        Bulk download <i>T. gondii</i> data
      </div>
      <div class="body">
        <ul>
          <li>
            <span style="white-space:nowrap">
              <im:querylink text="Toxoplasma gondii proteins and corresponding genes:" skipBuilder="true">
<query name="" model="genomic" view="Protein.primaryIdentifier Protein.primaryAccession Protein.organism.name Protein.genes.primaryIdentifier Protein.genes.secondaryIdentifier Protein.genes.organism.shortName" sortOrder="Protein.primaryIdentifier asc">
  <constraint path="Protein.organism.name" op="=" value="Toxoplasma gondii"/>
</query>
              </im:querylink>
            </span>
          </li>
        </ul>
      </div>
    </td>
  </tr>
</table>
