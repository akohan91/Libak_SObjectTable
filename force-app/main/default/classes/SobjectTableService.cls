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
	
	/**
	 * @description The IConstructable interface allows to enable reflection for the SobjectTableService
	 * and prevents using static methods for service instantiation.
	 * @param  inputJSON inputJSON the JSON string which represents the SobjectTableService
	 * @return           {SobjectTableService}
	 */
	public interface IConstructable {
		SobjectTableService construct(String inputJSON);
	}

	/**
	 * @description The method allows overriding the table data after it's been selected.
	 * @return   return {List<Object>}
	 */
	virtual public List<Object> tableRows() {
		return this.sobjectRecords();
	}

	/* ABSTRACT METHODS */

	/**
	 * @description Returns the list of Sobject records
	 * @return   { List<SObject> }
	 */
	abstract public List<SObject> sobjectRecords();

	/**
	 * @description Returns the number of Sobject records.
	 * @return   { Integer }
	 */
	abstract public Integer recordsCount();

	/**
	 * @description Returns the list of field paths that have ADDRESS display type
	 * @return   { List<String> }
	 */
	abstract public List<String> addressFieldPaths();

	/**
	 * @description Returns the list of field paths that have ID or REFERENCE display type
	 * @return   { List<String> }
	 */
	abstract public List<String> referenceFieldPaths();

	/**
	 * @description Returns the list of LWC dataTable columns
	 * @return   { List<Object> }
	 */
	abstract public List<Object> dataTableColumns();


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
	}
}
