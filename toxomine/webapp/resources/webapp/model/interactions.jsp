<%@ taglib tagdir="/WEB-INF/tags" prefix="im" %>
<!-- interactions.jsp -->
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
            Interactions datasets ...
          </a>
        </h4>

        <div id="hiddenDiv1" class="dataSetDescription">

          <ul><li><dt>Protein interactions have been loaded from <a href="http://www.ebi.ac.uk/intact/" target="_new">IntAct</a>.</dt></li></ul>
        </div>
    </td>

    <td width="40%" valign="top">
      <div class="heading2">
        Bulk download
      </div>
    </td>
  </tr>
</table>
<!-- /interactions.jsp -->