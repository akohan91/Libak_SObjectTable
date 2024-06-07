/**
 * @author Andrei Kakhanouski <akohan91@gmail.com>
 * 
 * Represents the column definition of a Lightning Web Component (LWC) data table column.
 * 
 * This class provides a definition for each column in an LWC data table, including properties such as field name,
 * label, type, etc.
 * 
 * For more information on LWC data table columns, refer to the Salesforce documentation:
 * [LWC Data Table Documentation](https://developer.salesforce.com/docs/component-library/bundle/lightning-datatable/documentation)
 */
public with sharing class SObjectTableColumn {
	
	/**
	 * List of actions to be displayed in the column header.
	 */
	@AuraEnabled
	public List<HeaderAction> actions {get;private set;}

	/**
	 * Additional attributes for the cell in the column.
	 */
	@AuraEnabled
	public Map<String, Object> cellAttributes {get;private set;}

	/**
	 * Unique identifier for the column.
	 */
	@AuraEnabled
	public String columnKey {get;private set;}

	/**
	 * Specifies if the column is editable.
	 */
	@AuraEnabled
	public Boolean editable {get;private set;}

	/**
	 * API name of the field associated with the column.
	 */
	@AuraEnabled
	public String fieldName {get;private set;}

	/**
	 * Width of the column when it is fixed.
	 */
	@AuraEnabled
	public Integer fixedWidth {get;private set;}

	/**
	 * Specifies if default actions in the column should be hidden.
	 */
	@AuraEnabled
	public Boolean hideDefaultActions {get;private set;}

	/**
	 * Specifies if the column label should be hidden.
	 */
	@AuraEnabled
	public Boolean hideLabel {get;private set;}

	/**
	 * Name of the icon to be displayed in the column.
	 */
	@AuraEnabled
	public String iconName {get;private set;}

	/**
	 * Initial width of the column.
	 */
	@AuraEnabled
	public Integer initialWidth {get;private set;}

	/**
	 * Label of the column.
	 */
	@AuraEnabled
	public String label {get;private set;}

	/**
	 * Specifies if the column is sortable.
	 */
	@AuraEnabled
	public Boolean sortable {get;private set;}

	/**
	 * Type of data displayed in the column.
	 */
	@AuraEnabled
	public String type {get;private set;}

	/**
	 * Additional attributes for the data type displayed in the column.
	 */
	@AuraEnabled
	public Map<String, Object> typeAttributes {get;private set;}

	/**
	 * Specifies if text in the column should wrap.
	 */
	@AuraEnabled
	public Boolean wrapText {get;private set;}

	/**
	 * Initializes a new instance of the SObjectTableColumn class with the specified field name, label, and type.
	 * 
	 * @param fieldName the API name of the field associated with the column
	 * @param label the label of the column
	 * @param type the type of data displayed in the column
	 */
	public SObjectTableColumn(String fieldName, String label, String type) {
		this.fieldName = fieldName;
		this.label = label;
		this.type = type;
	}

	/**
	 * Specifies the list of actions to be displayed in the column header.
	 * 
	 * @param headerActions the list of HeaderAction instances representing actions
	 * @return the current SObjectTableColumn instance
	 */
	public SObjectTableColumn withHeaderActions(List<HeaderAction> headerActions) {
		this.actions = headerActions;
		return this;
	}

	/**
	 * Specifies additional attributes for the cell in the column.
	 * 
	 * @param cellAttributes the map of additional attributes for the cell
	 * @return the current SObjectTableColumn instance
	 */
	public SObjectTableColumn withCellAttributes(Map<String, Object> cellAttributes) {
		this.cellAttributes = cellAttributes;
		return this;
	}

	/**
	 * Specifies the unique identifier for the column.
	 * 
	 * @param columnKey the unique identifier for the column
	 * @return the current SObjectTableColumn instance
	 */
	public SObjectTableColumn withColumnKey(String columnKey) {
		this.columnKey = columnKey;
		return this;
	}

	/**
	 * Specifies the name of the icon to be displayed in the column.
	 * 
	 * @param iconName the name of the icon to be displayed in the column
	 * @return the current SObjectTableColumn instance
	 */
	public SObjectTableColumn withIconName(String iconName) {
		this.iconName = iconName;
		return this;
	}

	/**
	 * Specifies the width of the column when it is fixed.
	 * 
	 * @param fixedWidth the width of the column when it is fixed
	 * @return the current SObjectTableColumn instance
	 */
	public SObjectTableColumn withFixedWidth(Integer fixedWidth) {
		this.fixedWidth = fixedWidth;
		return this;
	}

	/**
	 * Specifies the initial width of the column.
	 * 
	 * @param initialWidth the initial width of the column
	 * @return the current SObjectTableColumn instance
	 */
	public SObjectTableColumn withInitialWidth(Integer initialWidth) {
		this.initialWidth = initialWidth;
		return this;
	}

	/**
	 * Specifies if the column is editable.
	 * 
	 * @param isEditable true if the column is editable; otherwise, false
	 * @return the current SObjectTableColumn instance
	 */
	public SObjectTableColumn withEditable(Boolean isEditable) {
		this.editable = isEditable;
		return this;
	}

	/**
	 * Specifies if the column is sortable.
	 * 
	 * @param isSortable true if the column is sortable; otherwise, false
	 * @return the current SObjectTableColumn instance
	 */
	public SObjectTableColumn withSortable(Boolean isSortable) {
		this.sortable = isSortable;
		return this;
	}

	/**
	 * Specifies if default actions in the column should be hidden.
	 * 
	 * @param isHideDefaultActions true if default actions should be hidden; otherwise, false
	 * @return the current SObjectTableColumn instance
	 */
	public SObjectTableColumn withHideDefaultActions(Boolean isHideDefaultActions) {
		this.hideDefaultActions = isHideDefaultActions;
		return this;
	}

	/**
	 * Specifies if the column label should be hidden.
	 * 
	 * @param isHideLabel true if the column label should be hidden; otherwise, false
	 * @return the current SObjectTableColumn instance
	 */
	public SObjectTableColumn withHideLabel(Boolean isHideLabel) {
		this.hideLabel = isHideLabel;
		return this;
	}

	/**
	 * Specifies if text in the column should wrap.
	 * 
	 * @param isWrapText true if text in the column should wrap; otherwise, false
	* @return the current SObjectTableColumn instance
	*/
	public SObjectTableColumn withWrapText(Boolean isWrapText) {
		this.wrapText = isWrapText;
		return this;
	}

	/**
	 * Specifies additional attributes for the data type displayed in the column.
	 * 
	 * @param typeAttributes the map of additional attributes for the data type displayed in the column
	 * @return the current SObjectTableColumn instance
	 */
	public SObjectTableColumn withTypeAttributes(Map<String, Object> typeAttributes) {
		this.typeAttributes = typeAttributes;
		return this;
	}

	/**
	 * Represents an action to be displayed in the column header.
	 */
	public class HeaderAction {

		/**
		 * Label of the action.
		 */
		@AuraEnabled
		public String label {get;private set;}

		/**
		 * Name of the action.
		 */
		@AuraEnabled
		public String name {get;private set;}

		/**
		 * Specifies if the action is checked.
		 */
		@AuraEnabled
		public Boolean checked {get;private set;}

		/**
		 * Specifies if the action is disabled.
		 */
		@AuraEnabled
		public Boolean disabled {get;private set;}

		/**
		 * Name of the icon for the action.
		 */
		@AuraEnabled
		public String iconName {get;private set;}

		
		/**
		 * Initializes a new instance of the HeaderAction class with the specified label and name.
		 * 
		 * @param label the label of the action
		 * @param name the name of the action
		 */
		public HeaderAction(String label, String name) {
			this.label = label;
			this.name = name;
		}

		/**
		 * Specifies if the action is checked.
		 * 
		 * @param isChecked true if the action is checked; otherwise, false
		 * @return the current HeaderAction instance
		 */
		public HeaderAction withChecked(Boolean isChecked) {
			this.checked = isChecked;
			return this;
		}

		/**
		 * Specifies if the action is disabled.
		 * 
		 * @param isDisabled true if the action is disabled; otherwise, false
		 * @return the current HeaderAction instance
		 */
		public HeaderAction withDisabled(Boolean isDisabled) {
			this.disabled = isDisabled;
			return this;
		}

		/**
		 * Specifies the name of the icon for the action.
		 * 
		 * @param iconName the name of the icon for the action
		 * @return the current HeaderAction instance
		 */
		public HeaderAction withIcon(String iconName) {
			this.iconName = iconName;
			return this;
		}
	}
}
