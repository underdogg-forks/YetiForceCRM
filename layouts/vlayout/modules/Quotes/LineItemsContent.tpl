﻿{*<!--
/*********************************************************************************
  ** The contents of this file are subject to the vtiger CRM Public License Version 1.0
   * ("License"); You may not use this file except in compliance with the License
   * The Original Code is:  vtiger CRM Open Source
   * The Initial Developer of the Original Code is vtiger.
   * Portions created by vtiger are Copyright (C) vtiger.
   * All Rights Reserved.
  *
 ********************************************************************************/
-->*}
{strip}
	{assign var="deleted" value="deleted"|cat:$row_no}
    {assign var="hdnProductId" value="hdnProductId"|cat:$row_no}
    {assign var="productName" value="productName"|cat:$row_no}
	{assign var="calculationId" value="calculationId"|cat:$row_no}
	{assign var="calculation" value="calculation"|cat:$row_no}
    {assign var="comment" value="comment"|cat:$row_no}
    {assign var="productDescription" value="productDescription"|cat:$row_no}
    {assign var="qtyInStock" value="qtyInStock"|cat:$row_no}
    {assign var="qty" value="qty"|cat:$row_no}
    {assign var="usageUnit" value="usageUnit"|cat:$row_no}
    {assign var="listPrice" value="listPrice"|cat:$row_no}
	{assign var="purchase" value="purchase"|cat:$row_no}
	{assign var="margin" value="margin"|cat:$row_no}
	{assign var="marginp" value="marginp"|cat:$row_no}
	{assign var="tax" value="tax"|cat:$row_no}
    {assign var="productTotal" value="productTotal"|cat:$row_no}
    {assign var="subproduct_ids" value="subproduct_ids"|cat:$row_no}
    {assign var="subprod_names" value="subprod_names"|cat:$row_no}
    {assign var="entityIdentifier" value="entityType"|cat:$row_no}
    {assign var="entityType" value=$data.$entityIdentifier}

    {assign var="discount_type" value="discount_type"|cat:$row_no}
    {assign var="discount_percent" value="discount_percent"|cat:$row_no}
    {assign var="checked_discount_percent" value="checked_discount_percent"|cat:$row_no}
    {assign var="style_discount_percent" value="style_discount_percent"|cat:$row_no}
    {assign var="discount_amount" value="discount_amount"|cat:$row_no}
    {assign var="checked_discount_amount" value="checked_discount_amount"|cat:$row_no}
    {assign var="style_discount_amount" value="style_discount_amount"|cat:$row_no}
    {assign var="checked_discount_zero" value="checked_discount_zero"|cat:$row_no}

    {assign var="discountTotal" value="discountTotal"|cat:$row_no}
    {assign var="totalAfterDiscount" value="totalAfterDiscount"|cat:$row_no}
    {assign var="taxTotal" value="taxTotal"|cat:$row_no}
    {assign var="netPrice" value="netPrice"|cat:$row_no}
    {assign var="FINAL" value=$RELATED_PRODUCTS.1.final_details}
	
	{assign var="productDeleted" value="productDeleted"|cat:$row_no}
        {assign var="productId" value=$data[$hdnProductId]}
        {assign var="listPriceValues" value=Products_Record_Model::getListPriceValues($productId)}
	<td>
		<i class="glyphicon glyphicon-trash deleteRow cursorPointer" title="{vtranslate('LBL_DELETE',$MODULE)}"></i>
		&nbsp;<a><img src="{vimage_path('drag.png')}" border="0" alt="{vtranslate('LBL_DRAG',$MODULE)}"/></a>
		<input type="hidden" class="rowNumber" value="{$row_no}" />
	</td>
	<td>
		<!-- Product Re-Ordering Feature Code Addition Starts -->
		<input type="hidden" name="hidtax_row_no{$row_no}" id="hidtax_row_no{$row_no}" value="{$tax_row_no}"/>
		<!-- Product Re-Ordering Feature Code Addition ends -->
		<div>
			<input type="text" id="{$productName}" name="{$productName}" value="{$data.$productName}" class="productName {if $row_no neq 0} autoComplete {/if}" placeholder="{vtranslate('LBL_TYPE_SEARCH',$MODULE)}" data-validation-engine="validate[required]" {if !empty($data.$productName)} disabled="disabled" {/if}/>
			<input type="hidden" id="{$hdnProductId}" name="{$hdnProductId}" value="{$data.$hdnProductId}" class="selectedModuleId"/>
			<input type="hidden" id="lineItemType{$row_no}" name="lineItemType{$row_no}" value="{$entityType}" class="lineItemType"/>
			&nbsp;&nbsp;&nbsp;&nbsp;
			{if $row_no eq 0}
				<img class="lineItemPopup cursorPointer alignMiddle" data-popup="ServicesPopup" title="{vtranslate('Services',$MODULE)}" data-module-name="Services" data-field-name="serviceid" src="{vimage_path('Services.png')}"/>
				<img class="lineItemPopup cursorPointer alignMiddle" data-popup="ProductsPopup" title="{vtranslate('Products',$MODULE)}" data-module-name="Products" data-field-name="productid" src="{vimage_path('Products.png')}"/>
				&nbsp;<i class="glyphicon glyphicon-remove-sign clearLineItem cursorPointer" title="{vtranslate('LBL_CLEAR',$MODULE)}" style="vertical-align:middle"></i>
			{else}
				{if !$RECORD_ID} 
                                    {if ($entityType eq 'Services') and (!$data.$productDeleted) or $PRODUCT_ACTIVE neq 'true'} 
					<img class="lineItemPopup cursorPointer alignMiddle" data-popup="ServicesPopup" data-module-name="Services" title="{vtranslate('Services',$MODULE)}" data-field-name="serviceid" src="{vimage_path('Services.png')}"/>
					&nbsp;<i class="glyphicon glyphicon-remove-sign clearLineItem cursorPointer" title="{vtranslate('LBL_CLEAR',$MODULE)}" style="vertical-align:middle"></i>
                                    {elseif (!$data.$productDeleted)}
                                            <img class="lineItemPopup cursorPointer alignMiddle" data-popup="ProductsPopup" data-module-name="Products" title="{vtranslate('Products',$MODULE)}" data-field-name="productid" src="{vimage_path('Products.png')}"/>
                                            &nbsp;<i class="glyphicon glyphicon-remove-sign clearLineItem cursorPointer" title="{vtranslate('LBL_CLEAR',$MODULE)}" style="vertical-align:middle"></i>
                                    {/if}   
                                {else} 
                                    {if ($entityType eq 'Services') and (!$data.$productDeleted)} 
                                            <img class="{if $SERVICE_ACTIVE}lineItemPopup{/if} cursorPointer alignMiddle" data-popup="ServicesPopup" data-module-name="Services" title="{vtranslate('Services',$MODULE)}" data-field-name="serviceid" src="{vimage_path('Services.png')}"/> 
                                            &nbsp;<i class="glyphicon glyphicon-remove-sign {if $SERVICE_ACTIVE}clearLineItem{/if} cursorPointer" title="{vtranslate('LBL_CLEAR',$MODULE)}" style="vertical-align:middle"></i> 
                                    {elseif (!$data.$productDeleted)} 
                                            <img class="{if $PRODUCT_ACTIVE}lineItemPopup{/if} cursorPointer alignMiddle" data-popup="ProductsPopup" data-module-name="Products" title="{vtranslate('Products',$MODULE)}" data-field-name="productid" src="{vimage_path('Products.png')}"/> 
                                        &nbsp;<i class="glyphicon glyphicon-remove-sign {if $PRODUCT_ACTIVE}clearLineItem{/if} cursorPointer" title="{vtranslate('LBL_CLEAR',$MODULE)}" style="vertical-align:middle"></i> 
                                    {/if}   
                                {/if} 
			{/if}
		</div>
		<input type="hidden" value="{$data.$subproduct_ids}" id="{$subproduct_ids}" name="{$subproduct_ids}" class="subProductIds" />
		<div id="{$subprod_names}" name="{$subprod_names}" class="subInformation"><span class="subProductsContainer">{$data.$subprod_names}</span></div>
		{if $data.$productDeleted}
			<div class="row deletedItem redColor">
				{if empty($data.$productName)}
					{vtranslate('LBL_THIS_LINE_ITEM_IS_DELETED_FROM_THE_SYSTEM_PLEASE_REMOVE_THIS_LINE_ITEM',$MODULE_NAME)}
				{else}
					{vtranslate('LBL_THIS',$MODULE_NAME)} {vtranslate($entityType)} {vtranslate('LBL_IS_DELETED_FROM_THE_SYSTEM_PLEASE_REMOVE_OR_REPLACE_THIS_ITEM',$MODULE_NAME)}
				{/if}
			</div>
		{else}
			<div><br><textarea id="{$comment}" name="{$comment}" title="{$data.$comment}" class="lineItemCommentBox">{$data.$comment}</textarea>
		{/if}
	</td>
	<td>
		<input id="{$qty}" name="{$qty}" type="text" class="qty smallInputBox" data-validation-engine="validate[required,funcCall[Vtiger_GreaterThanZero_Validator_Js.invokeValidation]]" value="{if !empty($data.$qty)}{$data.$qty}{else}1{/if}" title="{if !empty($data.$qty)}{$data.$qty}{else}1{/if}"/>
		{if $MODULE neq 'PurchaseOrder'}
		<br>
		<span class="stockAlert redColor {if $data.$qty <= $data.$qtyInStock}hide{/if}" >
			{vtranslate('LBL_STOCK_NOT_ENOUGH',$MODULE)}
			<br>
			{vtranslate('LBL_MAX_QTY_SELECT',$MODULE)}&nbsp;<span class="maxQuantity">{$data.$qtyInStock}</span>
		</span>
		{/if}
	</td>
	<td>
		<span id="{$usageUnit}" class="usageUnit">{vtranslate($data.$usageUnit, $entityType)}</span>
	</td>
	<td>
		<div>
			<input id="{$listPrice}" name="{$listPrice}" value="{if !empty($data.$listPrice)}{$data.$listPrice}{else}0{/if}" type="text" data-validation-engine="validate[required,funcCall[Vtiger_PositiveNumber_Validator_Js.invokeValidation]]" class="listPrice smallInputBox" list-info='{if !empty($data.$listPrice)}{Zend_Json::encode($listPriceValues)}{/if}'/>
			&nbsp;
			{assign var=PRICEBOOK_MODULE_MODEL value=Vtiger_Module_Model::getInstance('PriceBooks')}
			{if $PRICEBOOK_MODULE_MODEL->isPermitted('DetailView')}
				<img src="{vimage_path('PriceBooks.png')}" class="cursorPointer alignMiddle priceBookPopup" data-popup="Popup" data-module-name="PriceBooks" title="{vtranslate('PriceBooks',$MODULE)}"/>
			{/if}
			<div>
		</div>
		<div>
			<span>
				(-)&nbsp; <b><a href="javascript:void(0)" class="individualDiscount">{vtranslate('LBL_DISCOUNT',$MODULE)}</a> : </b>
			</span>
		</div>
		<div class="discountUI validCheck hide" id="discount_div{$row_no}">
		{assign var="DISCOUNT_TYPE" value="zero"}
		{if !empty($data.$discount_type)}
			{assign var="DISCOUNT_TYPE" value=$data.$discount_type}
		{/if}
			<input type="hidden" id="discount_type{$row_no}" name="discount_type{$row_no}" value="{$DISCOUNT_TYPE}" class="discount_type" />
			<table width="100%" border="0" cellpadding="5" cellspacing="0" class="table table-nobordered popupTable">
			   <tr>
				   <!-- TODO : CLEAN : should not append product total it should added in the js because product total can change at any point of time -->
					<th id="discount_div_title{$row_no}" nowrap><b>{vtranslate('LBL_SET_DISCOUNT_FOR',$MODULE)} : {$data.$productTotal}</b></th>
					<th>
						<button type="button" class="close closeDiv">x</button>
					</th>
			   </tr>
			   <!-- TODO : discount price and amount are hide by default we need to check id they are already selected if so we should not hide them  -->
			   <tr>
					<td>
						<input type="radio" name="discount{$row_no}" {$data.$checked_discount_zero} title="{vtranslate('LBL_ZERO_DISCOUNT',$MODULE)}" {if empty($data)}checked{/if} class="discounts" data-discount-type="zero" />
						&nbsp;
						{vtranslate('LBL_ZERO_DISCOUNT',$MODULE)}
					</td>
					<td>
						<!-- Make the discount value as zero -->
						<input type="hidden" class="discountVal" value="0" />
					</td>
			   </tr>
			   <tr>
					<td>
						<input type="radio" name="discount{$row_no}" {$data.$checked_discount_percent} title="{vtranslate('LBL_OF_PRICE',$MODULE)}" class="discounts" data-discount-type="percentage" />
						&nbsp; %
						{vtranslate('LBL_OF_PRICE',$MODULE)}
					</td>
					<td>
						<span class="pull-right">&nbsp;%</span>
						<input type="text" data-validation-engine="validate[funcCall[Vtiger_PositiveNumber_Validator_Js.invokeValidation]]" id="discount_percentage{$row_no}" name="discount_percentage{$row_no}" value="{$data.$discount_percent}" title="{$data.$discount_percent}" class="discount_percentage smallInputBox pull-right discountVal {if empty($data.$checked_discount_percent)}hide{/if}" />
					</td>
			   </tr>
			   <tr>
					<td class="LineItemDirectPriceReduction">
						<input type="radio" name="discount{$row_no}" {$data.$checked_discount_amount} title="{vtranslate('LBL_DIRECT_PRICE_REDUCTION',$MODULE)}" class="discounts" data-discount-type="amount" />
						&nbsp;
						{vtranslate('LBL_DIRECT_PRICE_REDUCTION',$MODULE)}
					</td>
					<td>
						<input type="text" data-validation-engine="validate[funcCall[Vtiger_PositiveNumber_Validator_Js.invokeValidation]]" id="discount_amount{$row_no}" name="discount_amount{$row_no}" value="{$data.$discount_amount}" title="{$data.$discount_amount}" class="smallInputBox pull-right discount_amount discountVal {if empty($data.$checked_discount_amount)}hide{/if}"/>
					</td>
			   </tr>
			</table>
			<div class="modal-footer lineItemPopupModalFooter modal-footer-padding">
				<div class=" pull-right cancelLinkContainer">
					<a class="cancelLink" type="reset" data-dismiss="modal">{vtranslate('LBL_CANCEL', $MODULE)}</a>
				</div>
				<button class="btn btn-success discountSave" type="button" name="lineItemActionSave"><strong>{vtranslate('LBL_SAVE', $MODULE)}</strong></button>
			</div>
		</div>
		<div>
			<b>{vtranslate('LBL_TOTAL_AFTER_DISCOUNT',$MODULE)} :</b>
		</div>
		<div class="individualTaxContainer {if $IS_GROUP_TAX_TYPE}hide{/if}">
			(+)&nbsp;<b><a href="javascript:void(0)" class="individualTax">{vtranslate('LBL_TAX',$MODULE)} </a> : </b>
		</div>
		<span class="taxDivContainer">
			<div class="taxUI hide" id="tax_div{$row_no}" style="width: 35%;">
			<!-- we will form the table with all taxes -->
			<table width="100%" border="0" cellpadding="5" cellspacing="0" class="table table-nobordered popupTable" id="tax_table{$row_no}">
			   <tr>
					<th colspan="2" id="tax_div_title{$row_no}" nowrap align="left" ><strong>{vtranslate('LBL_SET_TAX_FOR',$MODULE)} : {$data.$totalAfterDiscount}</strong></th>
					<th colspan="2">
						<button type="button" class="close closeDiv">x</button>
					</th>
			   </tr>

			{foreach key=tax_row_no item=tax_data from=$data.taxes}
			   {assign var="taxname" value=$tax_data.taxname|cat:"_percentage"|cat:$row_no}
			   {assign var="tax_id_name" value="hidden_tax"|cat:$tax_row_no+1|cat:"_percentage"|cat:$row_no}
			   {assign var="taxlabel" value=$tax_data.taxlabel|cat:"_percentage"|cat:$row_no}
			   {assign var="popup_tax_rowname" value="popup_tax_row"|cat:$row_no}
			   <tr>
				<td>
					<input type="radio" name="tax_option{$row_no}" class="tax_option" value="{$tax_data.taxname}" value="{$tax_data.taxname}" {if {$data[$tax]} == $tax_data.taxname}checked{/if}>
				</td>
				<td>
					<input type="text" data-validation-engine="validate[funcCall[Vtiger_PositiveNumber_Validator_Js.invokeValidation]]" name="{$taxname}" id="{$taxname}" value="{$tax_data.percentage}" class="smallInputBox taxPercentage" readonly="readonly"/>&nbsp;%
				</td>
				<td><div class="textOverflowEllipsis">{$tax_data.taxlabel}</div></td>
				<td>
					<input type="text" name="{$popup_tax_rowname}" class="cursorPointer smallInputBox taxTotal" value="{$tax_data.amount}" readonly />
				</td>
			   </tr>
			{/foreach}
			</table>
			<div class="modal-footer lineItemPopupModalFooter modal-footer-padding">
				<div class=" pull-right cancelLinkContainer">
					<a class="cancelLink" type="reset" data-dismiss="modal">{vtranslate('LBL_CANCEL', $MODULE)}</a>
				</div>
				<button class="btn btn-success taxSave" type="button" name="lineItemActionSave"><strong>{vtranslate('LBL_SAVE', $MODULE)}</strong></button>
			</div>
			</div>
		</span>
		{vtranslate('LBL_PURCHASE',$MODULE)}:<br />
		<input id="{$purchase}" name="{$purchase}" value="{if !empty($data.$purchase)}{$data.$purchase}{else}0.00{/if}" type="text" data-validation-engine="validate[required,funcCall[Vtiger_PositiveNumber_Validator_Js.invokeValidation]]" class="purchase smallInputBox" />
		<br />{vtranslate('LBL_MARGIN',$MODULE)}:<br />
		<input id="{$margin}" name="{$margin}" value="{if !empty($data.$margin)}{$data.$margin}{else}0.00{/if}" type="text" data-validation-engine="validate[required,funcCall[Vtiger_PositiveNumber_Validator_Js.invokeValidation]]" class="margin smallInputBox" readonly="readonly"/>
		<br />{vtranslate('LBL_MARGINP',$MODULE)}:<br />
		<input id="{$marginp}" name="{$marginp}" value="{if !empty($data.$marginp)}{$data.$marginp}{else}0.00{/if}" type="text" data-validation-engine="validate[required,funcCall[Vtiger_PositiveNumber_Validator_Js.invokeValidation]]" class="marginp smallInputBox" readonly="readonly"/>
	</td>
	<td>
		<div id="productTotal{$row_no}" align="right" class="productTotal">{if $data.$productTotal}{$data.$productTotal}{else}0.00{/if}</div>
		<div id="discountTotal{$row_no}" align="right" class="discountTotal">{if $data.$discountTotal}{$data.$discountTotal}{else}0.00{/if}</div>
		<div id="totalAfterDiscount{$row_no}" align="right" class="totalAfterDiscount">{if $data.$totalAfterDiscount}{$data.$totalAfterDiscount}{else}0.00{/if}</div>
		<div id="taxTotal{$row_no}" align="right" class="productTaxTotal {if $IS_GROUP_TAX_TYPE}hide{/if}">{if $data.$taxTotal}{$data.$taxTotal}{else}0.00{/if}</div>
	</td>
	<td>
		<span id="netPrice{$row_no}" class="pull-right netPrice">{if $data.$netPrice}{$data.$netPrice}{else}0.00{/if}</span>
	</td>
	<td>
		<input type="text" id="{$calculation}" name="{$calculation}" value="{$data.$calculation}" class="calculation {if $row_no neq 0} autoComplete {/if}" placeholder="{vtranslate('LBL_TYPE_SEARCH',$MODULE)}" {if !empty($data.$calculation)} disabled="disabled" {/if}/>
		<input type="hidden" id="{$calculationId}" name="{$calculationId}" value="{$data.$calculationId}" class="selectedModuleIdC"/>
		<input type="hidden" id="old_{$calculationId}" name="old_{$calculationId}" value="{$data.$calculationId}" />
		<input type="hidden" id="lineItemType{$row_no}" name="lineItemTypeC{$row_no}" value="Calculations" class="lineItemTypeC"/>
		<img class="lineItemPopup cursorPointer alignMiddle" data-popup="CalculationsPopup" title="{vtranslate('Calculations','Calculations')}" data-module-name="Calculations" data-field-name="calculationsid" src="{vimage_path('Mobile.png')}">
		&nbsp;<i class="glyphicon glyphicon-remove-sign clearLineItem cursorPointer" title="{vtranslate('LBL_CLEAR',$MODULE)}" style="vertical-align:middle"></i>
	</td>