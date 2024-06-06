/**
 * @author Andrei Kakhanouski <akohan91@gmail.com>
 * The class represents the column definition of lwc data table column
 * https://developer.salesforce.com/docs/component-library/bundle/lightning-datatable/documentation
 */
public with sharing class SObjectTableColumn {

	@AuraEnabled
	public List<HeaderAction> actions {get;private set;}

	@AuraEnabled
	public Map<String, Object> cellAttributes {get;private set;}

	@AuraEnabled
	public String columnKey {get;private set;}

	@AuraEnabled
	public Boolean editable {get;private set;}

	@AuraEnabled
	public String fieldName {get;private set;}

	@AuraEnabled
	public Integer fixedWidth {get;private set;}

	@AuraEnabled
	public Boolean hideDefaultActions {get;private set;}

	@AuraEnabled
	public Boolean hideLabel {get;private set;}

	@AuraEnabled
	public String iconName {get;private set;}

	@AuraEnabled
	public Integer initialWidth {get;private set;}

	@AuraEnabled
	public String label {get;private set;}

	@AuraEnabled
	public Boolean sortable {get;private set;}

	@AuraEnabled
	public String type {get;private set;}

	@AuraEnabled
	public Map<String, Object> typeAttributes {get;private set;}

	@AuraEnabled
	public Boolean wrapText {get;private set;}

	public SObjectTableColumn(String fieldName, String label, String type) {
		this.fieldName = fieldName;
		this.label = label;
		this.type = type;
	}

	public SObjectTableColumn withHeaderActions(List<HeaderAction> headerActions) {
		this.actions = headerActions;
		return this;
	}

	public SObjectTableColumn withCellAttributes(Map<String, Object> cellAttributes) {
		this.cellAttributes = cellAttributes;
		return this;
	}

	public SObjectTableColumn withColumnKey(String columnKey) {
		this.columnKey = columnKey;
		return this;
	}

	public SObjectTableColumn withIconName(String iconName) {
		this.iconName = iconName;
		return this;
	}

	public SObjectTableColumn withFixedWidth(Integer fixedWidth) {
		this.fixedWidth = fixedWidth;
		return this;
	}

	public SObjectTableColumn withInitialWidth(Integer initialWidth) {
		this.initialWidth = initialWidth;
		return this;
	}

	public SObjectTableColumn withEditable(Boolean isEditable) {
		this.editable = isEditable;
		return this;
	}

	public SObjectTableColumn withSortable(Boolean isSortable) {
		this.sortable = isSortable;
		return this;
	}

	public SObjectTableColumn withHideDefaultActions(Boolean isHideDefaultActions) {
		this.hideDefaultActions = isHideDefaultActions;
		return this;
	}

	public SObjectTableColumn withHideLabel(Boolean isHideLabel) {
		this.hideLabel = isHideLabel;
		return this;
	}

	public SObjectTableColumn withWrapText(Boolean isWrapText) {
		this.wrapText = isWrapText;
		return this;
	}

	public SObjectTableColumn withTypeAttributes(Map<String, Object> typeAttributes) {
		this.typeAttributes = typeAttributes;
		return this;
	}


	public class HeaderAction {

		@AuraEnabled
		public String label {get;private set;}

		@AuraEnabled
		public String name {get;private set;}

		@AuraEnabled
		public Boolean checked {get;private set;}

		@AuraEnabled
		public Boolean disabled {get;private set;}

		@AuraEnabled
		public String iconName {get;private set;}

		public HeaderAction(String label, String name) {
			this.label = label;
			this.name = name;
		}

		public HeaderAction withChecked(Boolean isChecked) {
			this.checked = isChecked;
			return this;
		}

		public HeaderAction withDisabled(Boolean isDesabled) {
			this.disabled = isDesabled;
			return this;
		}

		public HeaderAction withIcon(String iconName) {
			this.iconName = iconName;
			return this;
		}
	}
}
