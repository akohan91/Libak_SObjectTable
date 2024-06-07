/**
 * Interface for providing field path information for SObjects.
 * @author Andrei Kakhanouski <akohan91@gmail.com>
 */
public interface ISObjectTableFieldPath {

	/**
	 * Gets the field path.
	 * Example: "Account.Name"
	 *
	 * @return the field path as a String
	 */
	String path();

	/**
	 * Gets the reference path for the target SObject.
	 * For example, if the SObject is 'Contact' and the path is 'account.name',
	 * this method returns the reference path such as 'account.id'.
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
