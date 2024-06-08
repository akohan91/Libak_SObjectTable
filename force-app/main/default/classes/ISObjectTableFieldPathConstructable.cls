/**
 * @author Andrei Kakhanouski <akohan91@gmail.com>\
 * 
 * Interface for constructing ISObjectTableFieldPath instances.
 * This interface supports constructing paths for fields within SObjects.
 * 
 * Supported paths can include various formats to represent the fields within the SObject.
 * 
 * For example:
 * - Simple field path: "Name"
 * - Relationship field path: "Account.Owner.Name"
 */
public interface ISObjectTableFieldPathConstructable {

	/**
	 * Constructs an ISObjectTableFieldPath instance.
	 * 
	 * @param sObjectName the name of the SObject.
	 * @param fieldPath the field path within the SObject.
	 * @return an instance of ISObjectTableFieldPath.
	 */
	ISObjectTableFieldPath construct(String sObjectName, String fieldPath);
}