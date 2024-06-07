/**
 * @author Andrei Kakhanouski <akohan91@gmail.com>
 * 
 * Interface for constructing ISObjectTableSOQL instances.
 * This interface provides a method to construct SOQL queries for SObject tables.
 */
public interface ISObjectTableSOQLConstructable {

	/**
	 * Constructs an ISObjectTableSOQL instance for the specified SObject.
	 *
	 * @param sObjectName the name of the SObject for which the SOQL query is constructed.
	 * @return an ISObjectTableSOQL instance for the specified SObject.
	 */
	ISObjectTableSOQL construct(String sObjectName);
}