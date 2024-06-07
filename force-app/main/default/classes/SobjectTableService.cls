/**
 * @author Andrei Kakhanouski <akohan91@gmail.com>
 */
public abstract class SobjectTableService {
	@TestVisible protected String sobjectName;
	@TestVisible protected List<String> selectFields;
	@TestVisible protected ConditionBlock conditionBlock;
	@TestVisible protected OrderBy orderBy;
	@TestVisible protected Integer limitRecords;
	@TestVisible protected Integer offsetRecords;

	protected ISObjectTableFieldPathConstructor fieldPathConstructor;
	protected ISObjectTableSOQLConstractable soqlConstructor;
	
	protected Set<String> fieldPathsToRetrieve;
	protected List<SOQLFunction> retriveFunctions;
	protected List<String> addressFieldPaths;
	protected List<String> referenceFieldPaths;
	protected Map<String, ISObjectTableFieldPath> targetFieldPathItemByPath;
	
	/**
	 * @description The IConstructable interface allows to enable reflection for the SobjectTableService
	 * and prevents using static methods for service instantiation.
	 * @param  inputJSON inputJSON the JSON string which represents the SobjectTableService
	 * @return           {SobjectTableService}
	 */
	public interface IConstructable {
		SobjectTableService construct(
			String inputJSON,
			ISObjectTableFieldPathConstructor fieldPathConstructor,
			ISObjectTableSOQLConstractable soqlConstructor
		);
	}

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
		ISObjectTableSOQL soql = this.soqlConstructor.construct(this.sobjectName);
		for (String fieldPath : fieldPathsToRetrieve) {
			soql.withField(fieldPath);
		}
		for (SOQLFunction function : retriveFunctions) {
			soql.withFunction(function);
		}
		soql.withConditions(this.conditionBlock);
		soql.withOrderBy(this.orderBy);
		soql.withLimit(this.limitRecords);
		soql.withOffset(this.offsetRecords);
		return Database.query(soql.stringify());
	}

	/**
	 * @description Returns the number of Sobject records.
	 * @return   { Integer }
	 */
	virtual public Integer recordsCount() {
		return Database.countQuery(
			this.soqlConstructor.construct(this.sobjectName)
			.withFunction(new SOQLFunction('COUNT'))
			.withConditions(this.conditionBlock)
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
		List<SObjectTableColumn> dataTableColumns = new List<SObjectTableColumn>();
		for (String fieldPathStr : this.selectFields) {
			ISObjectTableFieldPath fieldPathItem = this.fieldPathConstructor.construct(this.sObjectName, fieldPathStr);
			Schema.DisplayType fieldType = fieldPathItem.targetFieldDescribe().isNameField()
				? Schema.DisplayType.REFERENCE
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

		for (String fieldPathStr : this.selectFields) {
			fieldPathStr = fieldPathStr.toLowerCase();
			ISObjectTableFieldPath fieldPath = this.fieldPathConstructor.construct(this.sObjectName, fieldPathStr);
			this.targetFieldPathItemByPath.put(fieldPath.path(), fieldPath);

			this.fieldPathsToRetrieve.add(fieldPath.path());
			if (fieldPath.targetFieldDescribe().getType() == Schema.DisplayType.ID ||
				fieldPath.targetFieldDescribe().getType() == Schema.DisplayType.REFERENCE ||
				fieldPath.targetFieldDescribe().isNameField()
			) {
				this.fieldPathsToRetrieve.add(fieldPath.targetReferencePath());
				this.referenceFieldPaths.add(fieldPath.targetReferencePath());
			} else if (fieldPath.targetFieldDescribe().getType() == Schema.DisplayType.PICKLIST) {
				this.fieldPathsToRetrieve.remove(fieldPath.path());
				this.retriveFunctions.add(new SOQLFunction('toLabel', fieldPath.path()));
			} else if (fieldPath.targetFieldDescribe().getType() == Schema.DisplayType.ADDRESS) {
				this.addressFieldPaths.add(fieldPath.path());
			}
		}
	}


	public class ConditionBlock {
		public List<ConditionBlock> blocks;
		public List<Condition> conditions;
		public String operator;
	}

	public class Condition {
		public SOQLFunction function;
		public String fieldName;
		public String operator;
		public String value;
		public List<String> values;
	}

	public class OrderBy {
		public List<String> orderByFields;
		public Boolean isDESC;
		public Boolean isNullsFirst;
	}

	public class SOQLFunction {
		public String functionName;
		public String fieldName;
		public String alias;

		public SOQLFunction(String functionName) {
			this.functionName = functionName;
			this.fieldName = fieldName;
		}

		public SOQLFunction(String functionName, String fieldName) {
			this.functionName = functionName;
			this.fieldName = fieldName;
		}
	}
}
