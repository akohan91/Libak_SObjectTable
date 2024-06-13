/**
 * @author Andrei Kakhanouski <akohan91@gmail.com>
 * 
 * Interface for providing field path information for SObjects.
 * This interface defines methods to obtain details about specific fields within Salesforce SObjects.
 * It includes methods for getting the field path, reference path, and field description.
 * 
 * Example usage:
 * 
 * ISObjectTableFieldPath fieldPath = ...;
 * String path = fieldPath.getPath(); // Returns "Account.Name"
 * String refPath = fieldPath.getTargetReferencePath(); // Returns "Account.Id"
 * Schema.DescribeFieldResult describe = fieldPath.getTargetFieldDescribe(); // Returns DescribeFieldResult for "Name"
 * 
 * @see Schema.DescribeFieldResult
 */
public interface ISObjectTableFieldPath {

	/**
	 * Gets the field path.
	 * 
	 * Example: "Account.Name"
	 *
	 * @return the field path as a String
	 */
	String path();

	/**
	 * Gets the reference path for the target SObject.
	 * For example, if the SObject is 'Contact' and the path is 'Account.Name',
	 * this method returns the reference path such as 'Account.Id'.
	 *
	 * @return the reference path for the target SObject as a String
	 */
	String targetReferencePath();

	/**
	 * Gets the DescribeFieldResult for the target field.
	 * The target field is the final field in the specified path.
	 * For example, in the path "Account.Owner.Name", the target field is "Name".
	 *
	 * @return the DescribeFieldResult for the target field
	 */
	Schema.DescribeFieldResult targetFieldDescribe();
}
