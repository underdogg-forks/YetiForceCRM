<?php
/* +***********************************************************************************
 * The contents of this file are subject to the vtiger CRM Public License Version 1.0
 * ("License"); You may not use this file except in compliance with the License
 * The Original Code is:  vtiger CRM Open Source
 * The Initial Developer of the Original Code is vtiger.
 * Portions created by vtiger are Copyright (C) vtiger.
 * All Rights Reserved.
 * Contributor(s): YetiForce.com
 * *********************************************************************************** */

class Vtiger_UserRole_UIType extends Vtiger_Picklist_UIType
{

	/**
	 * {@inheritDoc}
	 */
	public function validate($value, $isUserFormat = false)
	{
		if ($this->validate || empty($value)) {
			return;
		}
		if (substr($value, 0, 1) !== 'H' || !is_numeric(substr($value, 1)) || is_null(\App\PrivilegeUtil::getRoleName($value))) {
			throw new \App\Exceptions\Security('ERR_ILLEGAL_FIELD_VALUE||' . $this->get('field')->getFieldName() . '||' . $value, 406);
		}
		$this->validate = true;
	}

	/**
	 * {@inheritDoc}
	 */
	public function getDisplayValue($value, $recordId = false, $recordInstance = false, $rawText = false)
	{
		$displayValue = \App\Language::translate(\App\PrivilegeUtil::getRoleName($value), $this->get('field')->getModuleName());
		if (\App\User::getCurrentUserModel()->isAdmin() && $rawText !== false) {
			$roleRecordModel = new Settings_Roles_Record_Model();
			$roleRecordModel->set('roleid', $value);
			return '<a href="' . $roleRecordModel->getEditViewUrl() . '">' . \App\Purifier::encodeHtml(\vtlib\Functions::textLength($displayValue)) . '</a>';
		}
		return $displayValue;
	}

	/**
	 * Function to get all the available picklist values for the current field
	 * @return string[]
	 */
	public function getPicklistValues()
	{
		$roleModels = Settings_Roles_Record_Model::getAll();
		$roles = [];
		foreach ($roleModels as $roleId => $roleModel) {
			$roles[$roleId] = \App\Language::translate($roleModel->getName(), $this->get('field')->getModuleName());
		}
		return $roles;
	}

	/**
	 * Function searches for value data
	 * @param string $value
	 * @return string[]
	 */
	public function getSearchValues($value)
	{
		$roles = (new App\Db\Query())->select(['roleid', 'rolename'])->from('vtiger_role')->where(['like', 'rolename', $value])
				->createCommand()->queryAllByGroup();
		return $roles;
	}

	/**
	 * {@inheritDoc}
	 */
	public function getListSearchTemplateName()
	{
		return 'uitypes/UserRoleFieldSearchView.tpl';
	}
}
