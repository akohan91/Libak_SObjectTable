/**
 * @author Andrei Kakhanouski <akohan91@gmail.com>
 * 
 * Interface for building SOQL (Salesforce Object Query Language) queries for SObject tables.
 * Allows adding fields, functions, conditions, ordering, limits, and offsets to the query.
 * Supports generating a string representation of the constructed query.
 */
public interface ISObjectTableSOQL {

	/**
	 * Adds a field to the SELECT clause of the SOQL query.
	 *
	 * @param fieldPath the path of the field to be added.
	 * @return an ISObjectTableSOQL instance with the added field.
	 */
	ISObjectTableSOQL withField(String fieldPath);

	/**
	 * Adds a function to the SELECT clause of the SOQL query.
	 *
	 * @param soqlFunction the function to be added.
	 * @return an ISObjectTableSOQL instance with the added function.
	 */
	ISObjectTableSOQL withFunction(SobjectTableService.SOQLFunction soqlFunction);

	/**
	 * Adds conditions to the WHERE clause of the SOQL query.
	 *
	 * @param conditionBlock the condition block to be added.
	 * @return an ISObjectTableSOQL instance with the added conditions.
	 */
	ISObjectTableSOQL withConditions(SobjectTableService.ConditionBlock conditionBlock);

	/**
	 * Adds ordering to the ORDER BY clause of the SOQL query.
	 *
	 * @param orderBy the ordering to be added.
	 * @return an ISObjectTableSOQL instance with the added ordering.
	 */
	ISObjectTableSOQL withOrderBy(SobjectTableService.OrderBy orderBy);

	/**
	 * Sets the limit for the number of records returned by the SOQL query.
	 *
	 * @param limitRecords the limit of records to be set.
	 * @return an ISObjectTableSOQL instance with the specified limit.
	 */
	ISObjectTableSOQL withLimit(Integer limitRecords);

	/**
	 * Sets the offset for the number of records to skip in the SOQL query result.
	 *
	 * @param offsetRecords the offset of records to be set.
	 * @return an ISObjectTableSOQL instance with the specified offset.
	 */
	ISObjectTableSOQL withOffset(Integer offsetRecords);

	/**
	 * Generates a string representation of the constructed SOQL query.
	 *
	 * @return the string representation of the SOQL query.
	 */
	String stringify();
}