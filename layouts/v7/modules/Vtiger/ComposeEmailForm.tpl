{*+**********************************************************************************
* The contents of this file are subject to the vtiger CRM Public License Version 1.1
* ("License"); You may not use this file except in compliance with the License
* The Original Code is: vtiger CRM Open Source
* The Initial Developer of the Original Code is vtiger.
* Portions created by vtiger are Copyright (C) vtiger.
* All Rights Reserved.
************************************************************************************}
{* modules/Vtiger/views/ComposeEmail.php *}

{strip}
    <div class="SendEmailFormStep2 modal-dialog modal-lg" id="composeEmailContainer">
        <div class="modal-content">
            <form class="form-horizontal" id="massEmailForm" method="post" action="index.php" enctype="multipart/form-data" name="massEmailForm">
                {include file="ModalHeader.tpl"|vtemplate_path:$MODULE TITLE={vtranslate('LBL_COMPOSE_EMAIL', $MODULE)}}
                <div class="modal-body">
                    <input type="hidden" name="selected_ids" value='{ZEND_JSON::encode($SELECTED_IDS)}' />
                    <input type="hidden" name="excluded_ids" value='{ZEND_JSON::encode($EXCLUDED_IDS)}' />
                    <input type="hidden" name="viewname" value="{$VIEWNAME}" />
                    <input type="hidden" name="module" value="{$MODULE}"/>
                    <input type="hidden" name="mode" value="massSave" />
                    <input type="hidden" name="toemailinfo" value='{ZEND_JSON::encode($TOMAIL_INFO)}' />
                    <input type="hidden" name="view" value="MassSaveAjax" />
                    <input type="hidden"  name="to" value='{ZEND_JSON::encode($TO)}' />
                    <input type="hidden"  name="toMailNamesList" value='{$TOMAIL_NAMES_LIST}'/>
                    <input type="hidden" id="flag" name="flag" value="" />
                    <input type="hidden" id="maxUploadSize" value="{$MAX_UPLOAD_SIZE}" />
                    <input type="hidden" id="documentIds" name="documentids" value="" />
                    <input type="hidden" name="emailMode" value="{if isset($EMAIL_MODE)}{$EMAIL_MODE}{/if}" />
                    <input type="hidden" name="source_module" value="{$SOURCE_MODULE}" />
                    {if !empty($PARENT_EMAIL_ID)}
                        <input type="hidden" name="parent_id" value="{$PARENT_EMAIL_ID}" />
                        <input type="hidden" name="parent_record_id" value="{$PARENT_RECORD}" />
                    {/if}
                    {if !empty($RECORDID)}
                        <input type="hidden" name="record" value="{$RECORDID}" />
                    {/if}
                    <input type="hidden" name="search_key" value="{if isset($SEARCH_KEY)}{$SEARCH_KEY}{/if}" />
                    <input type="hidden" name="operator" value="{$OPERATOR}" />
                    <input type="hidden" name="search_value" value="{if isset($ALPHABET_VALUE)}{$ALPHABET_VALUE}{/if}" />
                    {if !empty($SEARCH_PARAMS)}
                        <input type="hidden" name="search_params" value='{Vtiger_Util_Helper::toSafeHTML(ZEND_JSON::encode($SEARCH_PARAMS))}' />
                    {/if}
                    
                    <div class="row toEmailField">
                        <div class="col-lg-12">
                            <div class="col-lg-2">
                                <span class="">{vtranslate('LBL_TO',$MODULE)}&nbsp;<span class="redColor">*</span></span>
                            </div>
                            <div class="col-lg-6">
                                {if !empty($TO)}
                                    {assign var=TO_EMAILS value=","|implode:$TO|htmlentities}
                                {/if}
                                <input id="emailField" style="width:100%" name="toEmail" type="text" class="autoComplete sourceField select2" data-rule-required="true" data-rule-multiEmails="true" value="{if !empty($TO_EMAILS)}{$TO_EMAILS|escape:html}{/if}" placeholder="{vtranslate('LBL_TYPE_AND_SEARCH',$MODULE)}">
                            </div>
                            <div class="col-lg-4 input-group">
                                <select style="width: 140px;" class="select2 emailModulesList pull-right">
                                    {foreach item=MODULE_NAME from=$RELATED_MODULES}
                                        <option value="{$MODULE_NAME}" {if $MODULE_NAME eq $FIELD_MODULE} selected {/if}>{vtranslate($MODULE_NAME,$MODULE_NAME)}</option>
							 {/foreach}
                                </select>
                                <a href="#" class="clearReferenceSelection cursorPointer" name="clearToEmailField"> X </a>
                                <span class="input-group-addon">
                                    <span class="selectEmail cursorPointer">
                                        <i class="fa fa-search" title="{vtranslate('LBL_SELECT', $MODULE)}"></i>
                                    </span>
                                </span>
                            </div>
                            </div>
                                    
                        </div>
                    
                    <div class="row {if empty($CC)} hide {/if} ccContainer">
                        <div class="col-lg-12">
                            <div class="col-lg-2">
                                <span class="">{vtranslate('LBL_CC',$MODULE)}</span>
                            </div>
                            <div class="col-lg-6">
                                <input type="text" name="cc" data-rule-multiEmails="true" value="{if !empty($CC)}{$CC}{/if}"/>
                            </div>
                            <div class="col-lg-4"></div>
                        </div>
                    </div>

                    <div class="row {if empty($BCC)} hide {/if} bccContainer">
                        <div class="col-lg-12">
                            <div class="col-lg-2">
                                <span class="">{vtranslate('LBL_BCC',$MODULE)}</span>
                            </div>
                            <div class="col-lg-6">
                                <input type="text" name="bcc" data-rule-multiEmails="true" value="{if !empty($BCC)}{$BCC}{/if}"/>
                            </div>
                            <div class="col-lg-4"></div>
                        </div>
                    </div>
                    
                    <div class="row {if (!empty($CC)) and (!empty($BCC))} hide {/if} ">
                        <div class="col-lg-12">
                            <div class="col-lg-2">
                            </div>
                            <div class="col-lg-6">
                                <a href="#" class="cursorPointer {if (!empty($CC))}hide{/if}" id="ccLink">{vtranslate('LBL_ADD_CC', $MODULE)}</a>&nbsp;&nbsp;
                                <a href="#" class="cursorPointer {if (!empty($BCC))}hide{/if}" id="bccLink">{vtranslate('LBL_ADD_BCC', $MODULE)}</a>
                            </div>
                            <div class="col-lg-4"></div>
                        </div>
                    </div>
                    
                    <div class="row subjectField">
                        <div class="col-lg-12">
                            <div class="col-lg-2">
                                <span class="">{vtranslate('LBL_SUBJECT',$MODULE)}&nbsp;<span class="redColor">*</span></span>
                            </div>
                            <div class="col-lg-6">
                                <input type="text" name="subject" value="{if !empty($SUBJECT)}{$SUBJECT|escape:html}{/if}" data-rule-required="true" id="subject" spellcheck="true" class="inputElement"/>
                            </div>
                            <div class="col-lg-4"></div>
                        </div>
                    </div>
                            
                    <div class="row attachment">
                        <div class="col-lg-12">
                            <div class="col-lg-2">
                                <span class="">{vtranslate('LBL_ATTACHMENT',$MODULE)}</span>
                            </div>
                            <div class="col-lg-9">
                                <div class="row">
                                    <div class="col-lg-4 browse">
                                        <input type="file" {if isset($FILE_ATTACHED)}class="removeNoFileChosen"{/if} id="multiFile" name="file[]"/>&nbsp;
                                    </div>
                                    <div class="col-lg-4 brownseInCrm">
                                        <button type="button" class="btn btn-small btn-default" id="browseCrm" data-url="{$DOCUMENTS_URL}" title="{vtranslate('LBL_BROWSE_CRM',$MODULE)}">{vtranslate('LBL_BROWSE_CRM',$MODULE)}</button>
                                    </div>
                                    <div class="col-lg-4 insertTemplate">
                                        <button id="selectEmailTemplate" class="btn btn-success" data-url="module=EmailTemplates&view=Popup">{vtranslate('LBL_SELECT_EMAIL_TEMPLATE',$MODULE)}</button>
                                    </div>
                                </div>
                                <div id="attachments">
                                    {if isset($ATTACHMENTS) && $ATTACHMENTS|@count > 0}
                                        {foreach item=ATTACHMENT from=$ATTACHMENTS}
                                            {if ('docid'|array_key_exists:$ATTACHMENT)}
                                                {assign var=DOCUMENT_ID value=$ATTACHMENT['docid']}
                                                {assign var=FILE_TYPE value="document"}
                                            {else}
                                                {assign var=FILE_TYPE value="file"}
                                            {/if}
                                            <div class="MultiFile-label customAttachment" data-file-id="{(isset($ATTACHMENT['fileid'])) ? $ATTACHMENT['fileid'] : ''}" data-file-type="{$FILE_TYPE}"  data-file-size="{$ATTACHMENT['size']}" {if $FILE_TYPE eq "document"} data-document-id="{$DOCUMENT_ID}"{/if}>
                                                {if isset($ATTACHMENT['nondeletable']) && $ATTACHMENT['nondeletable'] neq true}
                                                    <a name="removeAttachment" class="cursorPointer">x </a>
                                                {/if}
                                                <span>{$ATTACHMENT['attachment']}</span>
                                            </div>
                                        {/foreach}
                                    {/if}
                                </div>
                            </div>
                        </div>
                    </div>
                                
                    <div class="row">
                        <div class="col-lg-12">
                            <div class="col-lg-2">
                                <span class="">{vtranslate('LBL_INCLUDE_SIGNATURE',$MODULE)}</span>
                            </div>
                            <div class="item col-lg-9">
                                <input class="" type="checkbox" name="signature" value="Yes" checked="checked" id="signature">
                            </div>
                        </div>
                    </div>
                    <div class="container-fluid hide" id='emailTemplateWarning'>
                        <div class="alert alert-warning fade in">
                            <a href="#" class="close" data-dismiss="alert">&times;</a>
                            <p>{vtranslate('LBL_EMAILTEMPLATE_WARNING_CONTENT',$MODULE)}</p>
                        </div>
                    </div>         
                    <div class="row templateContent">
                        <div class="col-lg-12">
                            <textarea style="width:390px;height:200px;" id="description" name="description">{if !empty($DESCRIPTION)}{$DESCRIPTION}{/if}</textarea>
                        </div>
                    </div>
                    
                    {if isset($RELATED_LOAD) && $RELATED_LOAD eq true}
                        <input type="hidden" name="related_load" value={$RELATED_LOAD} />
                    {/if}
                    <input type="hidden" name="attachments" value="{if isset($ATTACHMENTS)}{ZEND_JSON::encode($ATTACHMENTS)}{else}null{/if}" />
                    <div id="emailTemplateWarningContent" style="display: none;">
                        {vtranslate('LBL_EMAILTEMPLATE_WARNING_CONTENT',$MODULE)}
                    </div>
                </div>
                
                <div class="modal-footer">
                    <div class="pull-right cancelLinkContainer">
                        <a href="#" class="cancelLink" type="reset" data-dismiss="modal">{vtranslate('LBL_CANCEL', $MODULE)}</a>
                    </div>
                    <button id="sendEmail" name="sendemail" class="btn btn-success" title="{vtranslate("LBL_SEND_EMAIL",$MODULE)}" type="submit"><strong>{vtranslate("LBL_SEND_EMAIL",$MODULE)}</strong></button>
                    <button id="saveDraft" name="savedraft" class="btn btn-default" title="{vtranslate('LBL_SAVE_AS_DRAFT',$MODULE)}" type="submit"><strong>{vtranslate('LBL_SAVE_AS_DRAFT',$MODULE)}</strong></button>
                </div>
            </form>
        </div>
    </div>
{/strip}
