/**
 * @author Andrei Kakhanouski <akohan91@gmail.com>
 * 
 * Interface for constructing ISObjectTableFieldPath instances.
 * This interface supports constructing paths for fields within SObjects.
 * 
 * Supported paths can include various formats to represent the fields within the SObject.
 * 
 * Examples:
 * - Simple field path: "Name"
 * - Relationship field path: "Account.Owner.Name"

 * @see ISObjectTableFieldPath
 */
public interface ISObjectTableFieldPathConstructable {

	/**
	 * Constructs an ISObjectTableFieldPath instance.
	 * 
	 * This method constructs a field path instance for a specified SObject and field path.
	 * The implementation should validate the SObject name and field path, and handle any
	 * invalid inputs appropriately (e.g., by throwing exceptions or returning null).
	 * 
	 * @param sObjectName the name of the SObject. For example, "Account".
	 * @param fieldPath the field path within the SObject. For example, "Owner.Name".
	 * @return an instance of ISObjectTableFieldPath.
	 */
	ISObjectTableFieldPath construct(String sObjectName, String fieldPath);
}
