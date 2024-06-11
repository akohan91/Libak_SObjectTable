/**
 * Interface for constructing ISObjectTableSOQL instances.
 * This interface provides a method to construct SOQL queries for SObject tables.
 * 
 * Implementations of this interface should ensure that the constructed queries are valid
 * and properly handle any specific requirements for the given SObject.
 * 
 * Example usage:
 * 
 * ISObjectTableSOQLConstructable queryConstructor = ...;
 * ISObjectTableSOQL soqlQuery = queryConstructor.construct("Account");
 * 
 * @see ISObjectTableSOQL
 */
public interface ISObjectTableSOQLConstructable {

	/**
	 * Constructs an ISObjectTableSOQL instance for the specified SObject.
	 *
	 * This method constructs an instance of ISObjectTableSOQL that can be used to build
	 * and represent a SOQL query for the specified SObject.
	 * 
	 * @param sObjectName the name of the SObject for which the SOQL query is constructed. For example, "Account".
	 * @return an ISObjectTableSOQL instance for the specified SObject.
	 */
	ISObjectTableSOQL construct(String sObjectName);
}