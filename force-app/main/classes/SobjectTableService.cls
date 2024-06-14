/**
 * @author Andrei Kakhanouski <akohan91@gmail.com>
 */
public abstract class SobjectTableService {
	protected SObjectTableInputData inputData;

	protected ISObjectTableFieldPathConstructable fieldPathConstructor {
		get {
			if (this.fieldPathConstructor == null) {
				this.fieldPathConstructor = this.sObjectTableFieldPathConstructor();
			}
			return this.fieldPathConstructor;
		} private set;
	}
	protected ISObjectTableSOQLConstructable soqlConstructor {
		get {
			if (this.soqlConstructor == null) {
				this.soqlConstructor = this.sObjectTableSOQLConstructor();
			}
			return this.soqlConstructor;
		} private set;
	}
	
	protected Set<String> fieldPathsToRetrieve;
	protected List<SOQLFunction> retriveFunctions;
	protected List<String> addressFieldPaths;
	protected List<String> referenceFieldPaths;
	protected Map<String, ISObjectTableFieldPath> targetFieldPathItemByPath;

	public SobjectTableService(SObjectTableInputData inputData) {
		this.inputData = inputData;
	}

	/**
	 * @description The IConstructable interface allows to enable reflection for the SobjectTableService
	 * and prevents using static methods for service instantiation.
	 * @param  inputJSON inputJSON the JSON string which represents the SobjectTableService
	 * @return           {SobjectTableService}
	 */
	public interface IConstructable {
		SobjectTableService construct(SObjectTableInputData inputData);
	}

	/**
	 * Abstract method for providing an instance of {@link ISObjectTableSOQLConstructable}.
	 * Subclasses must implement this method to provide a concrete implementation.
	 * 
	 * @return an instance of {@link ISObjectTableSOQLConstructable}
	 */
	abstract protected ISObjectTableSOQLConstructable sObjectTableSOQLConstructor();

	/**
	 * Abstract method for providing an instance of {@link ISObjectTableFieldPathConstructor}.
	 * Subclasses must implement this method to provide a concrete implementation.
	 * 
	 * @return an instance of {@link ISObjectTableFieldPathConstructor}
	 */
	abstract protected ISObjectTableFieldPathConstructable sObjectTableFieldPathConstructor();


	/**
	 * @description The method allows overriding the table data after it's been selected.
	 * @return   return {List<Object>}
	 */
	virtual public List<Object> tableRows() {
		return this.sobjectRecords();
	}

	/**
	 * @description Returns the list of Sobject records
	 * @return   { List<SObject> }
	 */
	virtual protected List<SObject> sobjectRecords() {
		this.processFieldPaths();
		ISObjectTableSOQL soql = this.soqlConstructor.construct(this.inputData.sobjectName);
		for (String fieldPath : fieldPathsToRetrieve) {
			soql.withField(fieldPath);
		}
		for (SOQLFunction function : retriveFunctions) {
			soql.withFunction(function);
		}
		soql.withConditions(this.inputData.conditionBlock);
		soql.withOrderBy(this.inputData.orderBy);
		soql.withLimit(this.inputData.limitRecords);
		soql.withOffset(this.inputData.offsetRecords);
		return Database.query(soql.stringify());
	}

	/**
	 * @description Returns the number of Sobject records.
	 * @return   { Integer }
	 */
	virtual public Integer recordsCount() {
		return Database.countQuery(
			this.soqlConstructor.construct(this.inputData.sobjectName)
			.withFunction(new SOQLFunction('COUNT'))
			.withConditions(this.inputData.conditionBlock)
			.stringify()
		);
	}

	/**
	 * @description Returns the list of field paths that have ADDRESS display type
	 * @return   { List<String> }
	 */
	virtual public List<String> addressFieldPaths() {
		this.processFieldPaths();
		return this.addressFieldPaths;
	}

	/**
	 * @description Returns the list of field paths that have ID or REFERENCE display type
	 * @return   { List<String> }
	 */
	virtual public List<String> referenceFieldPaths() {
		this.processFieldPaths();
		return this.referenceFieldPaths;
	}

	/**
	 * @description Returns the list of LWC dataTable columns
	 * @return   { List<SObjectTableColumn> }
	 */
	virtual public List<SObjectTableColumn> dataTableColumns() {
		this.processFieldPaths();
		List<SObjectTableColumn> dataTableColumns = new List<SObjectTableColumn>();
		for (String fieldPathStr : this.inputData.selectFields) {
			fieldPathStr = fieldPathStr.toLowerCase();
			ISObjectTableFieldPath fieldPathItem = this.targetFieldPathItemByPath.get(fieldPathStr);
			DisplayType fieldType = fieldPathItem.targetFieldDescribe().isNameField()
				? DisplayType.REFERENCE
				: fieldPathItem.targetFieldDescribe().getType();
			SObjectTableColumnFactory columnFactory = (SObjectTableColumnFactory)SObjectTableColumnFactory.DISPLAY_TYPE_TO_FACTORY_TYPE
				.get(fieldType)
				.newInstance();
			dataTableColumns.add(columnFactory.build(fieldPathItem));
		}
		return dataTableColumns;
	}

	/* PRIVATE METHODS */

	private void processFieldPaths() {
		if (this.targetFieldPathItemByPath != null) {
			return;
		}
		this.fieldPathsToRetrieve = new Set<String>();
		this.retriveFunctions = new List<SOQLFunction>();
		this.addressFieldPaths = new List<String>();
		this.referenceFieldPaths = new List<String>();
		this.targetFieldPathItemByPath = new Map<String, ISObjectTableFieldPath>();

		for (String fieldPathStr : this.inputData.selectFields) {
			fieldPathStr = fieldPathStr.toLowerCase();
			ISObjectTableFieldPath fieldPath = this.fieldPathConstructor.construct(this.inputData.sObjectName, fieldPathStr);
			this.targetFieldPathItemByPath.put(fieldPath.path().toLowerCase(), fieldPath);

			this.fieldPathsToRetrieve.add(fieldPath.path().toLowerCase());
			if (fieldPath.targetFieldDescribe().getType() == DisplayType.ID ||
				fieldPath.targetFieldDescribe().getType() == DisplayType.REFERENCE ||
				fieldPath.targetFieldDescribe().isNameField()
			) {
				this.fieldPathsToRetrieve.add(fieldPath.targetReferencePath().toLowerCase());
				this.referenceFieldPaths.add(fieldPath.targetReferencePath().toLowerCase());
			} else if (fieldPath.targetFieldDescribe().getType() == DisplayType.PICKLIST) {
				this.fieldPathsToRetrieve.remove(fieldPath.path().toLowerCase());
				this.retriveFunctions.add(new SOQLFunction('toLabel', fieldPath.path().toLowerCase()));
			} else if (fieldPath.targetFieldDescribe().getType() == DisplayType.ADDRESS) {
				this.addressFieldPaths.add(fieldPath.path().toLowerCase());
			}
		}
	}


	public class SObjectTableInputData {
		@AuraEnabled
		public String sobjectName {get; set;}
		@AuraEnabled
		public List<String> selectFields {get; set;}
		@AuraEnabled
		public ConditionBlock conditionBlock {get; set;}
		@AuraEnabled
		public OrderBy orderBy {get; set;}
		@AuraEnabled
		public Integer limitRecords {get; set;}
		@AuraEnabled
		public Integer offsetRecords {get; set;}
	}
	
	public class ConditionBlock {
		@AuraEnabled
		public List<ConditionBlock> blocks {get; set;}
		@AuraEnabled
		public List<Condition> conditions {get; set;}
		@AuraEnabled
		public String operator {get; set;}
	}

	public class Condition {
		@AuraEnabled
		public SOQLFunction function {get; set;}
		@AuraEnabled
		public String fieldName {get; set;}
		@AuraEnabled
		public String operator {get; set;}
		@AuraEnabled
		public String value {get; set;}
		@AuraEnabled
		public List<String> values {get; set;}
	}

	public class OrderBy {
		@AuraEnabled
		public List<String> orderByFields {get; set;}
		@AuraEnabled
		public Boolean isDESC {get; set;}
		@AuraEnabled
		public Boolean isNullsFirst {get; set;}
	}

	public class SOQLFunction {
		@AuraEnabled
		public String functionName {get; set;}
		@AuraEnabled
		public String fieldName {get; set;}
		@AuraEnabled
		public String alias {get; set;}

		public SOQLFunction(String functionName) {
			this.functionName = functionName;
			this.fieldName = fieldName;
		}

		public SOQLFunction(String functionName, String fieldName) {
			this.functionName = functionName;
			this.fieldName = fieldName;
		}
	}

	public class SobjectTableServiceException extends Exception {}
}
